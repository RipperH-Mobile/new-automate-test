import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/slider_custom_track_shape.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/action_top_widget_desktop.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/extension/extension.dart';

import '../../controller/video_previewer_controller.dart';

class VideoInfoPanelDesktop extends GetView<VideoPreviewerController> {
  final String heroTag;
  final bool show;
  final MediaFileModel media;
  final MediaViewerOpenFrom openFrom;
  final VoidCallback onClosePage;
  final VoidCallback onDownload;
  final VoidCallback onShare;
  final VoidCallback onGridPressed;
  final bool isSecretRoom;

  const VideoInfoPanelDesktop({
    super.key,
    required this.show,
    required this.media,
    required this.onClosePage,
    required this.onDownload,
    required this.onShare,
    required this.onGridPressed,
    required this.heroTag,
    this.isSecretRoom = false,
    required this.openFrom,
  });

  @override
  String get tag => heroTag;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topAction(),
            bottomAction(),
          ],
        ),
        IgnorePointer(
          child: Align(
            alignment: Alignment.center,
            child: playPauseButtonCenter(),
          ),
        )
      ],
    );
  }

  Widget topAction() {
    return ActionTopWidgetDesktop(
      show: show,
      media: media,
      openFrom: openFrom,
      onDownload: onDownload,
      onShare: onShare,
      disableActionDivider: true,
    );
  }

  Widget bottomAction() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          // Add this gesture detector to prevent closing info panel when tapping on empty space of bottom bar
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.0),
                  Colors.black.withValues(alpha: 0.5),
                ],
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.spMin,
                  vertical: 5.spMin,
                ),
                child: Column(
                  children: !show
                      ? []
                      : [
                          videoPlayerProgress(),
                          Row(
                            children: [
                              playPauseButton(),
                              5.horizontalSpace,
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    speakerIconButton(),
                                    soundVolumeSlider(),
                                  ],
                                ),
                              ),
                              ...videoDurationWidgetList(),
                            ],
                          ),
                        ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget videoPlayerProgress() {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: SliderCustomTrackShape(),
        trackHeight: 4.spMin,
      ),
      child: SizedBox(
        height: 8.spMin,
        child: Obx(() {
          double currentValue = controller.currentPlayingTimeValue.value;
          if (currentValue < 0) {
            currentValue = 0;
          }

          return Slider(
            min: 0,
            max: controller.totalPlayTime.value.inMilliseconds.toDouble(),
            value: currentValue,
            onChanged: controller.seekToVideo,
            onChangeStart: (_) {
              controller.onSeekStart();
            },
            onChangeEnd: (_) {
              controller.onSeekEnd();
            },
            thumbColor: Colors.white,
            activeColor: UTheme.color.primary.withValues(alpha: 0.75),
            inactiveColor: Colors.white.withValues(alpha: 0.4),
          );
        }),
      ),
    );
  }

  Widget playPauseButton() {
    return Obx(() {
      return InkWell(
        onTap: controller.onTapPlayButton,
        child: controller.isPlaying.value
            ? Icon(
                Icons.pause,
                color: Colors.white,
                size: 25.spMin,
              )
            : Assets.images.v2.play.image(
                height: 24.spMin,
                width: 24.spMin,
                cacheWidth: 50.cacheSize,
              ),
      );
    });
  }

  Widget playPauseButtonCenter() {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: controller.isPlaying.value
            ? const SizedBox.shrink()
            : Assets.images.v2.play.image(
                height: 50.spMin,
                width: 50.spMin,
                cacheWidth: 75.cacheSize,
              ),
      );
    });
  }

  Widget speakerIconButton() {
    return InkWell(
      onTap: controller.handleMute,
      child: Obx(() {
        if (controller.volume() > 0.5) {
          return Assets.images.v2.volumeMax.image(
            height: 24.spMin,
            width: 24.spMin,
            cacheWidth: 50.cacheSize,
          );
        } else if (controller.volume() > 0.0) {
          return Assets.images.v2.volumeMin.image(
            height: 24.spMin,
            width: 24.spMin,
            cacheWidth: 50.cacheSize,
          );
        }

        return Assets.images.v2.volumeOff.image(
          height: 24.spMin,
          width: 24.spMin,
          cacheWidth: 50.cacheSize,
        );
      }),
    );
  }

  Widget soundVolumeSlider() {
    return Obx(() {
      return SizedBox(
        width: 120.spMin,
        child: Slider(
          value: controller.volume(),
          onChanged: controller.handleVolume,
          thumbColor: Colors.white,
          inactiveColor: Colors.white,
          activeColor: UTheme.color.primary.withValues(alpha: 0.75),
        ),
      );
    });
  }

  List<Widget> videoDurationWidgetList() {
    return [
      Obx(() {
        return Text(
          controller.currentPlayingTime.value.formattedVideoTime,
          style: TextStyle(
            color: Colors.white.withValues(alpha: .75),
            fontSize: 14.spMin,
            fontWeight: FontWeight.w500,
          ),
        );
      }),
      Text(' | ',
          style: TextStyle(
            color: Colors.white.withValues(alpha: .5),
            fontSize: 14.spMin,
            fontWeight: FontWeight.w500,
          )),
      Text(
        Duration(
          milliseconds: media.duration?.toInt() ?? 0,
        ).formattedVideoTime,
        style: TextStyle(
          color: Colors.white.withValues(alpha: .75),
          fontSize: 14.spMin,
          fontWeight: FontWeight.w500,
        ),
      ),
    ];
  }
}
