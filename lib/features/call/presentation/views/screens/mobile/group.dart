import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/livekit/start_group_call_controller.dart';
import 'package:uchat/features/call/presentation/views/screens/mobile/direct.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_speaker_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/livekit/participant_widget_group.dart';
import 'package:uchat/features/call/presentation/views/widgets/panels/call_action_panel_group.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/animation/widget_bouncing.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/call/participant_info.dart';

class GroupCallScreenImpl<C extends StartGroupCallCtl> extends GetView<C> {
  final String roomId;

  GroupCallScreenImpl({super.key, required this.roomId});

  @override
  String? get tag => roomId;

  double get widthScreen => Get.width;

  double get heightScreen => Get.height;

  final PageController pageViewCtl = PageController();

  final double appbarHeight = kToolbarHeight;

  double get buttonAction => 90.spMin;

  double get participantDetail => 55.spMin;

  double get pageIndicatorAndInternetQuality => 60.spMin;

  double participantHalfHeight(context) {
    return heightScreen -
        appbarHeight -
        buttonAction -
        pageIndicatorAndInternetQuality -
        participantDetail -
        MediaQuery.of(context).viewPadding.top -
        MediaQuery.of(context).padding.bottom;
  }

  final pageViewIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.otherParticipantList.length <= 2) {
        return DirectCallScreenImpl<C>(
          roomId: roomId,
        );
      }
      return GroupCallScreen(
        debugTap: () {},
        callData: RoomCallModel(),
        appBar: AppBar(
          // title: controller.callDuration(),
          leadingWidth: 150.spMin,
          leading: Padding(
            padding: const EdgeInsets.only(left: AppSpace.space3),
            child: AppControlButton.back(
              context: context,
              actionColor: context.theme.appColors.textPrimaryInverse,
              iconColor: context.theme.appColors.textPrimaryInverse,
            ),
          ),
          actions: [
            Obx(() {
              return Row(
                children: [
                  if (controller.enableWarMode())
                    Obx(() {
                      if (controller.isShareScreen() == true) {
                        return IconButton(
                          icon: Icon(
                            Icons.monitor_outlined,
                            color: context.theme.appColors.textPrimaryInverse,
                          ),
                          onPressed: () => controller.onDisableScreenShare(),
                          tooltip: 'unshare screen (experimental)',
                        );
                      } else {
                        return IconButton(
                          icon: Icon(
                            Icons.monitor,
                            color: context.theme.appColors.textPrimaryInverse,
                          ),
                          onPressed: () => controller.onEnableScreenShare(),
                          tooltip: 'share screen (experimental)',
                        );
                      }
                    }),
                  if (controller.isVideoCall || controller.cameraOn())
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpace.space3),
                      child: SizedBox(
                        width: 40.spMin,
                        height: 40.spMin,
                        child: Obx(() {
                          return CallActionSpeakerButton(
                            selectedDevice: controller.selectedAudioOutput(),
                            audioOutputs: controller.audioOutputs(),
                            onPressed: controller.toggleSpeaker,
                            isActive: controller.speakerOn(),
                            sheetOffset: const Offset(0, 50),
                            sheetPosition: PopupMenuPosition.over,
                            small: true,
                            onDeviceSelected: (device) {
                              controller.selectAudioOutput(device);
                            },
                          );
                        }),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
        body: _buildBodyParticipants(context),
        actionsControl: buildWidgetActionControl(context),
      );
    });
  }

  Widget collapseButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: BouncingGesture(
        initialEnable: false,
        bouncingDurationMilliseconds: 100,
        isActionWidgetUpdateEnable: false,
        onTap: () {
          GetIt.I<VibrateUtil>().vibrateSelection();
          // controller.onMinimizePressed();
        },
        child: Container(
          // width: widthScreen * 0.151,
          width: 70.spMin,
          decoration: BoxDecoration(
            color: const Color(0xff5A9BDB),
            borderRadius: BorderRadius.circular(30),
          ),
          child: AspectRatio(
            aspectRatio: 65 / 38,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
                top: 8.0,
              ),
              child: Image(
                image: ResizeImage(
                  const AssetImage(
                    'assets/images/v2/collapse_group.png',
                  ),
                  width: 50.cacheSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWidgetActionControl(BuildContext context) {
    return Obx(() {
      return Container(
        color: Colors.transparent,
        child: GroupCallActionPanelWidget(
          isVideo: controller.uiState.value == UiCallState.video || controller.cameraOn(),
          onDecline: () => controller.disconnect('Decline button pressed (Group)'),
          toggleCamera: controller.toggleCamera,
          toggleCameraSwitching: controller.switchCamera,
          toggleSpeaker: () => controller.toggleSpeaker(context: context),
          toggleMic: controller.toggleMic,
          micOn: controller.micOn(),
          cameraOn: controller.cameraOn(),
          speakerOn: controller.speakerOn(),
          audioOutputs: controller.audioOutputs(),
          onDeviceSelected: controller.selectAudioOutput,
          selectedDevice: controller.selectedAudioOutput(),
        ),
      );
    });
  }

  Widget _buildBodyParticipants(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            //NOTE. List of participants box
            _buildParticipantsBox(context),
            //NOTE. Internet instable and indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Center(
                child: SizedBox(
                  height: 20,
                  child: SmoothPageIndicator(
                    controller: pageViewCtl,
                    count: indicatorPageViewNumberCal(controller.remoteParticipants().length + 1),
                    effect: ExpandingDotsEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      activeDotColor: context.theme.appColors.iconInverse,
                      dotColor: context.theme.appColors.iconLighter,
                    ),
                  ),
                  // _indicatorWithAnimationSwitcher(
                  //   250,
                  //   false,
                  //   transitionBuilder: fromRightTransitionBuilder,
                  // ),
                ),
              ),
            ),
          ],
        ),
        if (controller.internetUnStable())
          FadeIn(
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpace.space3),
              child: networkQualityWidget(),
            ),
          ),
      ],
    );
  }

  Widget networkQualityWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Get.context!.theme.appColors.backgroundNeutralLighterPressed,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space4,
        ),
        child: SizedBox(
          height: 34.spMin,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.vectors.callInternetUnstable.svg(
                width: 20.spMin,
                height: 20.spMin,
              ),
              const SizedBox(
                width: 5,
              ),
              AppText.body3Bold(
                'Unstable Network'.tr,
                context: Get.context!,
                color: Get.context!.theme.appColors.textError,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int indicatorPageViewNumberCal(int index) {
    return ((index / 4)).ceil().toInt();
  }

  Widget _buildParticipantsBox(context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        padding: EdgeInsets.only(
          top: 5.0.spMin,
          bottom: 5.0.spMin,
        ),
        child: Obx(() {
          return pageViewBuilder(context, controller.otherParticipantList());
        }),
      ),
    );
  }

  Widget pageViewBuilder(context, List<ParticipantTrack> remote) {
    RxList<Widget> participantList = <Widget>[].obs;
    for (int index = 0; index < remote.length; index++) {
      final pt = controller.otherParticipant(index);
      // final participantId = pt?.participant.identity;
      // final temp2 = controller.roomMemberList.firstWhereOrNull((e) => e.id == participantId);
      final avatarUrl = controller.getParticipantImage(pt?.participant);
      final blurHash = controller.getParticipantBlurHash(pt?.participant);
      Widget child = ParticipantGroupWidget.widgetFor(
        pt!,
        RoomCallModel(
          imageUrl: avatarUrl,
          roomId: controller.callData.roomId,
          imageBlurHash: blurHash,
        ),
      );
      if (index == 0) {
        child = AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Transform.scale(
            scale: 1.0,
            key: const ValueKey('showFrontSide2'),
            child: ParticipantGroupWidget.widgetFor(
              pt,
              RoomCallModel(
                imageUrl: avatarUrl,
                roomId: controller.callData.roomId,
                imageBlurHash: blurHash,
              ),
            ),
          ),
        );
      }
      participantList.add(child);
    }

    var chunks = [];
    int chunkSize = 4;
    for (var i = 0; i < participantList.length; i += chunkSize) {
      chunks.add(
        participantList.sublist(
          i,
          i + chunkSize > participantList.length ? participantList.length : i + chunkSize,
        ),
      );
    }
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: pageViewCtl,
      onPageChanged: (index) {
        // controller.pinedId(''); //reset participant pin.
        // controller.groupCallPageViewIndex(index);
      },
      children: <Widget>[...chunks.map((e) => buildGridview(e, remote.length))],
    );
  }

  double get participantFullHeight {
    return Get.height - kToolbarHeight - 90.spMin - 30.spMin;
  }

  Widget buildGridview(
    List<Widget> widgets,
    int total,
  ) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2),
      child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpace.space2.spMin,
            ),
            child: layoutManager(widgets, total),
          )),
    );
  }

  Widget layoutManager(
    List<Widget> items,
    int total,
  ) {
    return LayoutBuilder(builder: (context, ct) {
      final uiWidth = 200.spMin;
      final uiHeight = 312.spMin;
      final width = ct.maxWidth;
      final height = ct.maxHeight;

      return Wrap(
        runAlignment: WrapAlignment.spaceBetween,
        spacing: 10,
        runSpacing: AppSpace.space4.spMin,
        children: [
          ...List<Widget>.generate(items.length, (index) {
            if (items.length.isOdd && total > 1) {
              // if the participant is the last grid show full width screen.
              if (index == items.length - 1) {
                return ZoomIn(
                  delay: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: (max(width * 0.45, uiWidth)) * 2 + 10,
                    height: min(height * 0.45, uiHeight),
                    child: items[index],
                  ),
                );
              }
            }
            return ZoomIn(
              delay: const Duration(milliseconds: 300),
              child: SizedBox(
                width: max(width * 0.45, uiWidth),
                height: min(height * 0.45, uiHeight),
                child: items[index],
              ),
            );
          })
        ],
      );
    });
  }

  Widget layoutManagerWithPinAndFullScreen(List<Widget> items) {
    return Stack(
      children: [
        ...List<Widget>.generate(
          items.length,
          (index) {
            AlignmentGeometry? alignment = Alignment.topLeft;

            /// UI participant builder if the participants more than 2.
            /// ```Design
            ///  >= 3
            ///  |  x |  x |
            ///  |----|----|
            ///  |  x |  x |
            ///  |----|----|
            /// ```
            if (index == 0) {
              alignment = Alignment.topLeft;
            }
            if (index == 1) {
              alignment = Alignment.topRight;
            }
            if (index == 2) {
              alignment = Alignment.bottomLeft;
            }
            if (index == 3) {
              alignment = Alignment.bottomRight;
            }
            // POC
            // if (items.length == 2 &&
            //     items.length == controller.remoteParticipants().length + 1) {
            //   /// UI participant builder if there are 2 participants.
            //   /// ```Design
            //   ///  =2
            //   ///  |   x  |
            //   ///  |------|
            //   ///  |   x  |
            //   ///  |------|
            //   /// ```
            //   if (index == 0) {
            //     alignment = Alignment.topCenter;
            //   }
            //   if (index == 1) {
            //     alignment = Alignment.bottomCenter;
            //   }
            // }

            return Align(
              alignment: alignment,
              child: items[index],
            );
          },
        ),
      ],
    );
  }
}

class MockCallModel {
  String? id;
  String? title;
  String? imageUrl;
  bool? isSpeaking;
  bool? isMute;
  bool? isConnectionFail;
  bool? isPinned;

  MockCallModel({
    this.id,
    this.title,
    this.imageUrl,
    this.isSpeaking,
    this.isMute,
    this.isConnectionFail,
    this.isPinned,
  });
}

class GroupCallScreen extends StatelessWidget {
  final Widget actionsControl;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final VoidCallback? debugTap;
  final VoidCallback? debugTap2;
  final VoidCallback? debugTap3;
  final RoomCallModel callData;
  final bool disableBottomNavbarSafeArea;
  final bool disableDebugFloatingBtn;

  const GroupCallScreen({
    super.key,
    required this.actionsControl,
    required this.body,
    required this.callData,
    this.appBar,
    this.debugTap,
    this.debugTap2,
    this.debugTap3,
    this.disableBottomNavbarSafeArea = false,
    this.disableDebugFloatingBtn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: context.theme.appColors.backgroundDarkNeutral,
      appBar: appBar,
      body: Stack(
        children: [
          SafeArea(child: body),
          // SafeArea(
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: SizedBox(
          //       height: 250,
          //       child: actionsControl,
          //     ),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: disableBottomNavbarSafeArea
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: actionsControl,
                ),
              ],
            )
          : SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: actionsControl,
                  ),
                ],
              ),
            ),
      // floatingActionButton: disableDebugFloatingBtn
      //     ? null
      //     : SingleChildScrollView(
      //         scrollDirection: Axis.horizontal,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             FloatingActionButton(
      //               onPressed: () {
      //                 debugTap3?.call();
      //               },
      //               child: const Icon(Icons.info),
      //             ),
      //             FloatingActionButton(
      //               onPressed: () {
      //                 debugTap2?.call();
      //               },
      //               child: const Icon(Icons.hide_source),
      //             ),
      //             FloatingActionButton(
      //               onPressed: () {
      //                 debugTap?.call();
      //               },
      //               child: const Icon(Icons.change_circle),
      //             ),
      //           ],
      //         ),
      //       ),
    );
  }
}
