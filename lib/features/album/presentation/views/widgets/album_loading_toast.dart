import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

/// Album toast widget to show progress when uploading / downloading or success in album image list screen.
class AlbumLoadingToast extends StatelessWidget {
  /// Type of the task (download or upload) used to determine title and subtitle.
  final AlbumTaskType type;

  /// Status of the task used to determine title and subtitle.
  final AlbumTaskStatus status;

  /// Name of the album will be shown in subtitle.
  final String albumName;

  /// Callback when undo button is pressed.
  final Function onUndoPressed;

  /// Current progress of the task used in circular progress indicator.
  final int currentProgress;

  /// Max progress of the task used in circular progress indicator.
  final int maxProgress;

  /// If true, Return a widget without SafeArea, Align and margin to be used in [AppToast].
  /// Otherwise, Return a widget with SafeArea, Align and margin to be used in [AlbumImageListScreen].
  final bool isToast;

  const AlbumLoadingToast({
    super.key,
    required this.type,
    required this.status,
    required this.albumName,
    required this.onUndoPressed,
    required this.currentProgress,
    required this.maxProgress,
    this.isToast = true,
  });

  String get title {
    switch (type) {
      case AlbumTaskType.upload:
        if (status == AlbumTaskStatus.completed) {
          return 'Upload Success'.tr;
        } else {
          return 'Uploading...'.tr;
        }

      case AlbumTaskType.download:
      case AlbumTaskType.downloadAll:
        if (status == AlbumTaskStatus.completed) {
          return 'Download Success'.tr;
        } else {
          return 'Downloading...'.tr;
        }
    }
  }

  String get subtitle {
    switch (type) {
      case AlbumTaskType.upload:
        return 'You are uploading to the @albumName album.'.trParams({'albumName': albumName});
      case AlbumTaskType.download:
      case AlbumTaskType.downloadAll:
        return 'You are downloading the @albumName album.'.trParams({'albumName': albumName});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isToast) {
      return buildContent(context);
    } else {
      return SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: buildContent(context),
        ),
      );
    }
  }

  Widget buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.theme.appGradientColors.gradientBlack, // Gradient colors
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
      ),
      margin: isToast ? null : const EdgeInsets.all(AppSpace.space4),
      padding: const EdgeInsets.all(AppSpace.space3),
      child: Row(
        children: [
          SizedBox(
            width: 50.spMin,
            height: 50.spMin,
            child: Stack(
              children: [
                SizedBox(
                  width: 50.spMin,
                  height: 50.spMin,
                  child: CircularProgressIndicator(
                    value: currentProgress / maxProgress,
                    color: context.theme.appColors.borderLighter,
                  ),
                ),
                Center(
                  child: Container(
                    width: 36.spMin,
                    height: 36.spMin,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.appColors.iconPrimaryInverse,
                    ),
                    child: Center(
                      child: currentProgress ~/ maxProgress == 1 || status == AlbumTaskStatus.completed
                          ? Assets.vectors.iconAlbumSuccess.svg()
                          : AppText.caption1Bold(
                              '${(currentProgress / maxProgress * 100).toInt()}%',
                              color: context.theme.appColors.textDarkest,
                              context: context,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.space3),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AppText.body3Bold(
                    title,
                    color: context.theme.appColors.textInformationInverse,
                    textAlign: TextAlign.start,
                    context: context,
                  ),
                ),
                const SizedBox(height: AppSpace.space1),
                SizedBox(
                  width: double.infinity,
                  child: AppText.caption1(
                    subtitle,
                    textAlign: TextAlign.start,
                    color: context.theme.appColors.textInformationInverse,
                    context: context,
                  ),
                ),
              ],
            ),
          ),
          if (status == AlbumTaskStatus.inProgress)
            GestureDetector(
              onTap: () {
                onUndoPressed();
              },
              child: AppText.body3Bold(
                'Undo'.tr,
                color: context.theme.appColors.textInformationInverse,
                context: context,
              ),
            ),
        ],
      ),
    );
  }
}
