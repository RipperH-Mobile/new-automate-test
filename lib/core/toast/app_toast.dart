import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/toast/toast_with_undo.dart';
import 'package:uchat/core/toast/toast_with_undo_controller.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';
import 'package:uchat/features/album/presentation/album_presentation.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar.dart';

class AppToast {
  static const toastDuration = Duration(seconds: 3);

  static void showAllReadToast({
    required BuildContext context,
    required String title,
    required String description,
    Icon? icon,
    bool? isLoading = false,
  }) {
    hideToast(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        content: Container(
          height: 70.spMin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.spMin),
            gradient: LinearGradient(
              colors: context.theme.appGradientColors.gradientBlack, // Gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.spMin),
            child: Row(
              children: [
                if (isLoading == true)
                  SpinKitRing(
                    size: 25.spMin,
                    lineWidth: 4,
                    color: Colors.white,
                  ),
                if (isLoading == false)
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                SizedBox(
                  width: 15.spMin,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.theme.appTexts.body3Bold,
                    ),
                    Text(
                      description,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        duration: toastDuration,
        behavior: SnackBarBehavior.floating, // Makes it like a toast
      ),
    );
  }

  static void showToast({
    required BuildContext context,
    required String message,
    String? subtitle,
    Widget? icon,
    Duration? duration,
    Widget? suffix,
    EdgeInsetsGeometry sbMargin = EdgeInsets.zero,
  }) {
    hideToast(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: sbMargin,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
            gradient: LinearGradient(
              colors: context.theme.appGradientColors.gradientBlack, // Gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(AppSpace.space3),
          child: Container(
            constraints: const BoxConstraints(minHeight: AppSpace.space6),
            child: Row(
              children: [
                if (icon != null) ...[
                  icon,
                  const SizedBox(width: AppSpace.space3),
                ],
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: AppText.body3Bold(
                          message,
                          context: context,
                          textAlign: TextAlign.start,
                          color: context.theme.appColors.textInformationInverse,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSpace.space1),
                        SizedBox(
                          width: double.infinity,
                          child: AppText.caption1(
                            subtitle,
                            context: context,
                            textAlign: TextAlign.start,
                            color: context.theme.appColors.textInformationInverse,
                          ),
                        )
                      ]
                    ],
                  ),
                ),
                if (suffix != null) ...[
                  const SizedBox(width: AppSpace.space3),
                  suffix,
                ],
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        duration: duration ?? toastDuration,
        behavior: SnackBarBehavior.floating, // Makes it like a toast
      ),
    );
  }

  static void showToastV2({
    required BuildContext context,
    required Widget messageWidget,
    String? subtitle,
    Widget? icon,
    Duration? duration,
    Widget? suffix,
    EdgeInsets sbMargin = EdgeInsets.zero,
  }) {
    hideToast(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: sbMargin,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
            color: context.theme.appColors.backgroundNeutralLightest,
            boxShadow: [
              BoxShadow(
                color: context.theme.appColors.backgroundDarkNeutral.withAlpha(38), // 38 is ~15% opacity
                spreadRadius: AppSpace.spacePx,
                blurRadius: 3,
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppSpace.space3),
          child: Container(
            constraints: const BoxConstraints(minHeight: AppSpace.space6),
            child: Row(
              children: [
                if (icon != null) ...[
                  icon,
                  const SizedBox(width: AppSpace.space3),
                ],
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: messageWidget,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSpace.space1),
                        SizedBox(
                          width: double.infinity,
                          child: AppText.caption1(
                            subtitle,
                            context: context,
                            textAlign: TextAlign.start,
                            color: context.theme.appColors.textDarkest,
                          ),
                        )
                      ]
                    ],
                  ),
                ),
                if (suffix != null) ...[
                  const SizedBox(width: AppSpace.space3),
                  suffix,
                ],
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        duration: duration ?? toastDuration,
        behavior: SnackBarBehavior.floating, // Makes it like a toast
      ),
    );
  }

  static void showSwitchAccountToast({
    required BuildContext context,
    required String displayName,
    String? avatarUrl,
    double? bottomMargin,
  }) {
    showToastV2(
      context: context,
      messageWidget: RichText(
        text: TextSpan(
          style: context.theme.appTexts.body3.copyWith(
            color: context.theme.appColors.textDarkest,
          ),
          children: [
            TextSpan(text: 'Switching to '.tr),
            TextSpan(
              text: displayName,
              style: context.theme.appTexts.body3Bold.copyWith(
                color: context.theme.appColors.textDarkest,
              ),
            ),
          ],
        ),
      ),
      icon: avatarUrl != null
          ? Avatar(
              url: avatarUrl,
              radius: AppSize.size4,
            )
          : Assets.vectors.defaultAvatar.svg(
              width: AppSize.size8,
              height: AppSize.size8,
            ),
      sbMargin: bottomMargin != null ? EdgeInsets.only(bottom: bottomMargin) : EdgeInsets.zero,
    );
  }

  static void showDownloadToast({
    required BuildContext context,
    required String title,
    double? height,
    bool? isLoading = false,
  }) {
    hideToast(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        content: Container(
          height: height ?? 70.spMin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.spMin),
            gradient: LinearGradient(
              colors: context.theme.appGradientColors.gradientBlack,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.spMin),
            child: Row(
              children: [
                const Icon(
                  Icons.download,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 15.spMin,
                ),
                Text(
                  title,
                  style: context.theme.appTexts.body3Bold,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        duration: toastDuration,
        behavior: SnackBarBehavior.floating, // Makes it like a toast
      ),
    );
  }

  static void hideToast(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void clearToast(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  static void showToastWithUndo({
    required BuildContext context,
    required String title,
    required String description,
    Widget? icon,
    Duration? duration,
    required void Function() onTapUndo,
    EdgeInsets? margin,
  }) {
    if (Get.isRegistered<ToastWithUndoController>()) {
      Get.delete<ToastWithUndoController>();
    }

    Get.put<ToastWithUndoController>(
      ToastWithUndoController(),
    );

    hideToast(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: margin,
        padding: EdgeInsets.zero,
        elevation: 0,
        content: ToastWithUndo(
          title: title,
          description: description,
          onTapUndo: onTapUndo,
        ),
        backgroundColor: Colors.transparent,
        duration: duration ?? toastDuration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showAlbumCannotDoItNowToast(BuildContext context) {
    AppToast.showToast(
      context: context,
      message: 'Can\'t do it now'.tr,
      subtitle: 'You\'re doing something else. Please try again later.'.tr,
      icon: Assets.vectors.iconInfo.svg(
        colorFilter: ColorFilter.mode(context.theme.appColors.iconPrimaryInverse, BlendMode.srcIn),
        width: AppSize.size8,
        height: AppSize.size8,
      ),
    );
  }

  /// Used to show upload / download success in album image list screen.
  static void showAlbumTaskSuccessToast({
    required BuildContext context,
    required String albumName,
    required AlbumTaskType type,
  }) {
    hideToast(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        content: AlbumLoadingToast(
          type: type,
          status: AlbumTaskStatus.completed,
          albumName: albumName,
          onUndoPressed: () {},
          currentProgress: 1,
          maxProgress: 1,
        ),
        backgroundColor: Colors.transparent,
        duration: toastDuration,
        behavior: SnackBarBehavior.floating, // Makes it like a toast
      ),
    );
  }

  static void showSyncToast(BuildContext context) {
    AppToast.showToast(
      context: context,
      message: 'Syncing...'.tr,
      icon: SizedBox(
        height: AppSpace.space6,
        width: AppSpace.space6,
        child: CircularProgressIndicator(
          color: context.theme.appColors.textPrimaryInverse,
          strokeWidth: AppSpace.space05,
        ),
      ),
    );
  }

  static void showProcessingToast(BuildContext context) {
    AppToast.showToast(
      context: context,
      message: 'Processing...'.tr,
      duration: const Duration(days: 1),
      icon: SizedBox(
        height: AppSpace.space6,
        width: AppSpace.space6,
        child: CircularProgressIndicator(
          color: context.theme.appColors.textPrimaryInverse,
          strokeWidth: AppSpace.space05,
        ),
      ),
    );
  }

  /// show toast widget with custom widget
  static void showCustomToast({
    required BuildContext context,
    required Widget widget,
    Duration? duration,
  }) {
    hideToast(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        content: Container(
          height: 48.spMin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.spMin),
            color: context.theme.appColors.backgroundGrayLightPressed,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.spMin),
            child: widget,
          ),
        ),
        backgroundColor: Colors.transparent,
        duration: duration ?? toastDuration,
        behavior: SnackBarBehavior.floating, // Makes it like a toast
      ),
    );
  }

  static void showCopyToClipboardToast({
    required BuildContext context,
    String? message,
    Duration? duration,
  }) {
    hideToast(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        content: Container(
          height: 48.spMin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
            color: context.theme.appColors.backgroundNeutralLightest,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.spMin),
            child: Row(
              children: [
                Assets.vectors.contentCopy.svg(
                  colorFilter: ColorFilter.mode(context.theme.appColors.iconPrimary, BlendMode.srcIn),
                  width: AppSize.size6,
                  height: AppSize.size6,
                ),
                const SizedBox(width: AppSpace.space3),
                Expanded(
                  child: AppText.body3Bold(
                    message ?? 'Copied to clipboard'.tr,
                    context: context,
                    textAlign: TextAlign.start,
                    color: context.theme.appColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        duration: duration ?? toastDuration,
        behavior: SnackBarBehavior.floating, // Makes it like a toast
      ),
    );
  }

  static void showRevokedInviteLinkToast({
    required BuildContext context,
    String? message,
    Duration? duration,
  }) {
    hideToast(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        content: Container(
          height: 48.spMin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
            color: context.theme.appColors.backgroundNeutralLightest,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.spMin),
            child: Row(
              children: [
                Assets.vectors.trash.svg(width: AppSize.size6, height: AppSize.size6),
                const SizedBox(width: AppSpace.space3),
                Expanded(
                  child: AppText.body3Bold(
                    message ?? 'Revoked'.tr,
                    context: context,
                    textAlign: TextAlign.start,
                    color: context.theme.appColors.textDarkest,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        duration: duration ?? toastDuration,
        behavior: SnackBarBehavior.floating, // Makes it like a toast
      ),
    );
  }

  static void showInternetUnstableToast(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    AppToast.showToast(
      context: context,
      message: 'Unstable Network'.tr,
      subtitle: 'Please check your connection'.tr,
      icon: Assets.vectors.callInternetUnstable.svg(
        width: AppSize.size6,
        height: AppSize.size6,
      ),
      suffix: GestureDetector(
        onTap: onConfirm,
        child: Padding(
          padding: const EdgeInsets.all(
            AppSpace.space1,
          ),
          child: AppText.body4Bold(
            'Voice call'.tr,
            context: context,
            textAlign: TextAlign.start,
            color: context.theme.appColors.textInformationInverse,
          ),
        ),
      ),
    );
  }
}
