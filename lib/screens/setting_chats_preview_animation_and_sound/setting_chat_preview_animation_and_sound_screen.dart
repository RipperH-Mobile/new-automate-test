import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/animation/widget_bouncing.dart';
import 'package:uchat/widgets/row_menu/uchat_check_box_row_menu_custom_circle_icon.dart';

const curves = [
  Curves.linear,
  Curves.fastEaseInToSlowEaseOut,
  Curves.easeInOutBack,
  Curves.elasticInOut,
  Curves.elasticOut
];

enum PreviewAnimationAndSoundType { animation, sound }

class MessageMock {
  final String msg;
  final bool isMe;

  const MessageMock({required this.msg, required this.isMe});
}

class ConfigMessage {
  final String? newMessageSoundMeSelected;
  final String? newMessageSoundFriendSelected;
  final int? newMessageAnimatedType;
  final double? newMessageAnimatedDuration;

  const ConfigMessage({
    this.newMessageSoundMeSelected,
    this.newMessageSoundFriendSelected,
    this.newMessageAnimatedType,
    this.newMessageAnimatedDuration,
  });
}

class ConfigMessageInitial extends ConfigMessage {
  final bool? isMe;

  ConfigMessageInitial({
    this.isMe,
    super.newMessageSoundMeSelected,
    super.newMessageSoundFriendSelected,
    super.newMessageAnimatedType,
    super.newMessageAnimatedDuration,
  });
}

class PreviewAnimationAndSoundScreen extends StatefulWidget {
  final PreviewAnimationAndSoundType type;
  final ConfigMessageInitial initialConfig;
  final Function(ConfigMessage config) configResult;

  const PreviewAnimationAndSoundScreen({
    super.key,
    required this.type,
    required this.initialConfig,
    required this.configResult,
  });

  @override
  State<PreviewAnimationAndSoundScreen> createState() => _PreviewAnimationAndSoundScreenState();
}

class _PreviewAnimationAndSoundScreenState extends State<PreviewAnimationAndSoundScreen>
    with SingleTickerProviderStateMixin {
  List<MessageMock> listMessage = [];
  Random r = Random();
  int pageIndex = 0;
  int soundMeSelectedIndex = 0;
  int soundFriendSelectedIndex = 0;
  int? animatedSelectedIndex;
  final itemScrollController = ItemScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final controller = ScrollController();

  double _currentSliderValue = 500;

  List<String> soundList = [];
  UserController? get userCtl {
    try {
      return Get.find<UserController>();
    } catch (_) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    listMessage = List.generate(10, (index) {
      return MessageMock(msg: 'Message @index'.trParams({'index': index.toString()}), isMe: r.nextDouble() <= 0.7);
    });
    await getSoundList();
    initConfig();
    setState(() {});
  }

  void initConfig() {
    if (widget.initialConfig.newMessageSoundMeSelected != null) {
      final index = soundList.indexOf(widget.initialConfig.newMessageSoundMeSelected!);
      if (index != -1) {
        soundMeSelectedIndex = index;
      }
    }
    if (widget.initialConfig.newMessageSoundFriendSelected != null) {
      final index = soundList.indexOf(widget.initialConfig.newMessageSoundFriendSelected!);
      if (index != -1) {
        soundFriendSelectedIndex = index;
      }
    }
    if (widget.initialConfig.newMessageAnimatedType != null) {
      animatedSelectedIndex = widget.initialConfig.newMessageAnimatedType;
    }
    if (widget.initialConfig.newMessageAnimatedDuration != null) {
      _currentSliderValue = widget.initialConfig.newMessageAnimatedDuration!;
    }
    if (widget.initialConfig.isMe != null) {
      pageIndex = widget.initialConfig.isMe! ? 0 : 1;
    }
  }

  void fallbackResult() {
    widget.configResult(
      ConfigMessage(
        newMessageSoundMeSelected: soundList.isNotEmpty ? soundList[soundMeSelectedIndex] : null,
        newMessageSoundFriendSelected: soundList.isNotEmpty ? soundList[soundFriendSelectedIndex] : null,
        newMessageAnimatedType: animatedSelectedIndex,
        newMessageAnimatedDuration: _currentSliderValue,
      ),
    );
  }

  Future<void> getSoundList() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final allSoundName = manifestMap.keys.where((String key) => key.contains('assets/audios/message')).toList();

    soundList = allSoundName.map((e) => e.replaceAll('assets/', '')).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !Navigator.of(context).userGestureInProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (listMessage.isNotEmpty)
            SizedBox(
              height: Get.height * (widget.type == PreviewAnimationAndSoundType.sound ? 0.5 : 0.35),
              child: AnimatedList(
                key: _listKey,
                reverse: true,
                controller: controller,
                padding: const EdgeInsets.only(top: 10),
                initialItemCount: listMessage.length,
                itemBuilder: (context, index, animation) {
                  return Padding(
                    padding: index == 0 ? const EdgeInsets.only(bottom: 18.0) : EdgeInsets.zero,
                    child: SlideTransition(
                      position: CurvedAnimation(
                        curve: curves[animatedSelectedIndex ?? 0],
                        parent: animation,
                      ).drive((Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: const Offset(0, 0),
                      ))),
                      child: messageContainer(
                        listMessage[index].isMe,
                        listMessage[index].msg,
                      ),
                    ),
                  );
                },
              ),

              // ScrollablePositionedList.builder(
              //   key: _listKey,
              //   itemScrollController: itemScrollController,
              //   initialScrollIndex: 0,
              //   reverse: true,
              //   itemCount: listMessage.length,
              //   // NOTE: We force index to be at least 1 to avoid sliding bug when items length change from 0 to 1
              //   itemBuilder: (BuildContext context, int index) {
              //     return MockMessageWithAnimationProvider(
              //       isPlayAnimation: true,
              //       isMe: listMessage[index].isMe,
              //       msg: listMessage[index].msg,
              //       isPlaySound: index == (listMessage.length - 1),
              //     );
              //   },
              // ),
            ),
          const SettingDivider(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: SafeArea(
                top: false,
                child: buildSelector(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSelector() {
    switch (widget.type) {
      case PreviewAnimationAndSoundType.animation:
        return animationSelector();
      case PreviewAnimationAndSoundType.sound:
        return soundSelector();
    }
  }

  Widget animationSelector() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Animation speed: @duration second'.trParams({'duration': '${_currentSliderValue / 1000}'})),
        ),
        Slider(
          value: _currentSliderValue,
          max: 2000,
          min: 200,
          divisions: 18,
          label: (_currentSliderValue / 1000).toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
          onChangeEnd: (double value) {
            fallbackResult();
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pageButton(pageIndex == 1 ? 1 : 0.5, 'Friend'.tr, 1),
            pageButton(pageIndex == 0 ? 1 : 0.5, 'Me'.tr, 0),
            pageButton(pageIndex == 2 ? 1 : 0.5, 'Random'.tr, 2),
          ],
        ),
        buildAnimatedSelector()
      ],
    );
  }

  void togglePage(int value) {
    if (pageIndex == value) return;
    setState(() {
      pageIndex = value;
    });
  }

  Widget soundSelector() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pageButton(pageIndex == 1 ? 1 : 0.5, 'Friend'.tr, 1),
            pageButton(pageIndex == 0 ? 1 : 0.5, 'Me'.tr, 0),
          ],
        ),
        buildSoundSelector()
      ],
    );
  }

  Widget buildSoundSelectedHelper(int index, String text) {
    return UChatCheckBoxRowMenu(
      prefixWidget: const Icon(Icons.volume_down),
      title: text,
      selected: pageIndex == 0 ? soundMeSelectedIndex == index : soundFriendSelectedIndex == index,
      onTap: (_) {
        AudioPlayer().play(
          AssetSource(
            soundList[index],
          ),
          volume: 0.7,
          mode: PlayerMode.lowLatency,
        );
        addNewMockMessage();
        setState(() {
          if (pageIndex == 0) {
            soundMeSelectedIndex = index;
          } else if (pageIndex == 1) {
            soundFriendSelectedIndex = index;
          }
        });
        fallbackResult();
      },
      isShowDisableIcon: true,
      customSelectedWidget: (value) => UChatCheckBoxCircleWidgetChild(value),
      selectedTitleColor: UTheme.color.primary,
    );
  }

  Widget buildSoundSelector() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...soundList.mapIndexedAndLast((index, item, isLast) =>
                buildSoundSelectedHelper(index, item.replaceAll('assets/audios/message/', '').replaceAll('.mp3', '')))
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedSelector() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...curves
                .mapIndexedAndLast((index, e, last) => buildAnimatedSelectedHelper(index, e.runtimeType.toString()))
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedSelectedHelper(int index, String text) {
    return UChatCheckBoxRowMenu(
      prefixWidget: const Icon(Icons.animation),
      title: text,
      selected: animatedSelectedIndex == index,
      onTap: (_) {
        AudioController.to.playGetMessageSound(false);
        addNewMockMessage();
        setState(() {
          animatedSelectedIndex = index;
        });
        fallbackResult();
      },
      isShowDisableIcon: true,
      customSelectedWidget: (value) => UChatCheckBoxCircleWidgetChild(value),
      selectedTitleColor: UTheme.color.primary,
    );
  }

  void addNewMockMessage() {
    final bool isMe;
    // itemScrollController.scrollTo(
    //     index: 0, duration: const Duration(milliseconds: 200));
    if (widget.type == PreviewAnimationAndSoundType.sound) {
      isMe = pageIndex == 0;
    } else {
      isMe = pageIndex != 2 ? pageIndex == 0 : r.nextDouble() <= 0.5;
    }
    final msg = MessageMock(
      msg: 'Message @index'.trParams({'index': listMessage.length.toString()}),
      isMe: isMe,
    );
    setState(() {
      controller.jumpTo(0);
      listMessage.insert(0, msg);
      _listKey.currentState?.insertItem(0, duration: Duration(milliseconds: _currentSliderValue.toInt()));
    });
  }

  Widget pageButton(double bgOpacity, String text, int page) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: BouncingGesture(
          bouncingDurationMilliseconds: 150,
          onTap: () => togglePage(page),
          child: TextButton(
            onPressed: null,
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.zero,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                UTheme.color.primary.withValues(alpha: bgOpacity),
              ),
            ),
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget messageContainer(bool isMe, String msg) {
    return Align(
      alignment: isMe ? Alignment.bottomRight : Alignment.bottomLeft,
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: isMe ? UTheme.color.primary : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  msg,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
