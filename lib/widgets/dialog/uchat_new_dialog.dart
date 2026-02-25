import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/in_app_purchase_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/collections/announcement_collection.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/features/accounts_center/accounts_center_barrel.dart';
import 'package:uchat/features/album/presentation/views/widgets/album_error_image_box.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

abstract class IUChatNewDialog {
  Future<dynamic> showDialog({
    required BuildContext context,
    String? title,
    String? description,
    String? description2,
    String cancelText,
    String confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    Color? cancelTextColor,
    Color? confirmTextColor,
    bool isDestructive,
    bool barrierDismissible,
  });

  Future<void> showSettingAppDialog({
    required BuildContext context,
    String? title,
    String cancelText,
    String confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool isDestructive,
    bool barrierDismissible,
  });

  void showSingleButtonDialog({
    required BuildContext context,
    String? title,
    String? description,
    String confirmText,
    VoidCallback? onConfirm,
    Color? confirmTextColor,
    bool isDestructive,
    bool barrierDismissible,
  });

  Future<void> showSingleButtonCustomDialog({
    required BuildContext context,
    String? title,
    Widget? description,
    String confirmText,
    VoidCallback? onConfirm,
    Color? confirmTextColor,
    bool isDestructive,
    bool barrierDismissible,
  });

  void showGeneralErrorDialog({
    required BuildContext context,
    bool isDestructive,
    bool barrierDismissible,
    String? message,
    Exception? e,
  });

  void showYouAreOfflineDialog({
    required BuildContext context,
    bool isDestructive,
    bool barrierDismissible,
  });

  void showConnectionErrorDialog({
    required BuildContext context,
    bool isDestructive,
    bool barrierDismissible,
  });

  void showAlbumImageLongPressDialog({
    required BuildContext context,
    required String imageUrl,
    required bool isSelected,
    required Function onSelectPressed,
    required Function onDownloadPressed,
    required Function onSharePressed,
    required Function onDeletePressed,
  });

  void showRetryAlbumUploadDownloadDialog({
    required BuildContext context,
    required String title,
    required VoidCallback onRetry,
    required VoidCallback onDiscard,
    bool isDestructive,
    bool barrierDismissible,
    bool showRetryButton,
  });

  void showResendFailedMessageDialog({
    required BuildContext context,
    required String title,
    required VoidCallback onResend,
    required VoidCallback onDelete,
    bool isDestructive,
    bool barrierDismissible,
  });

  void showSingleButtonWithIconDialog({
    required SvgPicture svgIcon,
    String? title,
    String? description,
    String confirmText,
    VoidCallback? onConfirm,
    Color? confirmTextColor,
    bool isDestructive,
    bool barrierDismissible,
    dynamic exception,
  });

  void showDownloadAlbumImagePartialSuccessDialog({
    required BuildContext context,
    required int successCount,
    required int totalImages,
  });

  void showFileTooLargeDialog({
    required BuildContext context,
    int maxFileSize,
  });

  void showFileTooLargeDialogWithSize({
    required BuildContext context,
    int width,
    int height,
  });

  void showUnsupportedFile({required BuildContext context});

  void showConfirmDeleteChatDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  });

  void showLeaveGroupDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  });
}

class UChatNewDialog {
  @visibleForTesting
  static IUChatNewDialog? testMode;

  /// Shows a Cupertino (iOS-style) dialog with optional cancel and confirm buttons.
  static Future showDialog({
    required BuildContext context,
    String? title,
    String? description,
    String? description2,
    String? cancelText,
    String? confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    Color? cancelTextColor,
    Color? confirmTextColor,
    bool isDestructive = false,
    bool barrierDismissible = false,
  }) async {
    if (testMode != null) {
      return testMode!.showDialog(
        context: context,
        title: title,
        description: description,
        description2: description2,
        cancelText: cancelText ?? 'Cancel'.tr,
        confirmText: confirmText ?? 'Confirm'.tr,
        onCancel: onCancel,
        onConfirm: onConfirm,
        cancelTextColor: cancelTextColor,
        confirmTextColor: confirmTextColor,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
      );
    }
    return await Get.dialog(
      _UChatDialogWidget(
        title: title ?? '',
        description: description,
        description2: description2,
        cancelText: cancelText ?? 'Cancel'.tr,
        confirmText: confirmText ?? 'Confirm'.tr,
        onCancel: onCancel,
        onConfirm: onConfirm,
        cancelTextColor: cancelTextColor,
        confirmTextColor: confirmTextColor,
        isDestructive: isDestructive,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showSettingAppDialog({
    required BuildContext context,
    String? title,
    String cancelText = 'Cancel',
    String confirmText = 'Setting',
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool isDestructive = false,
    bool barrierDismissible = false,
  }) async {
    if (testMode != null) {
      return testMode!.showSettingAppDialog(
        context: context,
        title: title,
        cancelText: cancelText,
        confirmText: confirmText,
        onCancel: onCancel,
        onConfirm: onConfirm,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
      );
    }
    await Get.dialog(
      CupertinoAlertDialog(
        title: AppText.body3(
          title?.tr ?? '',
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textDarkest,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              if (onCancel != null) {
                onCancel();
              } else {
                Get.back();
              }
            },
            child: AppText.body3(
              cancelText.tr,
              context: context,
              color: context.theme.appColors.textPrimary,
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              if (onConfirm != null) {
                onConfirm();
              } else {
                Get.back();
              }
            },
            isDestructiveAction: isDestructive,
            child: AppText.body3(
              confirmText.tr,
              context: context,
              color: context.theme.appColors.textPrimary,
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showSingleButtonDialog({
    required BuildContext context,
    String? title,
    String? description,
    String confirmText = 'Got it',
    VoidCallback? onConfirm,
    Color? confirmTextColor,
    bool isDestructive = false,
    bool barrierDismissible = false,
    RouteSettings? routeSettings,
  }) async {
    if (testMode != null) {
      return testMode!.showSingleButtonDialog(
        context: context,
        title: title,
        description: description,
        confirmText: confirmText,
        onConfirm: onConfirm,
        confirmTextColor: confirmTextColor,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
      );
    }
    Get.dialog(
      CupertinoAlertDialog(
        title: AppText.title3(
          title?.tr ?? '',
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textDarkest,
        ),
        content: description != null
            ? Padding(
                padding: const EdgeInsets.only(top: AppSize.size1),
                child: AppText.body3(
                  description,
                  context: context,
                  textAlign: TextAlign.center,
                  color: context.theme.appColors.textLight,
                ),
              )
            : null,
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              if (onConfirm != null) {
                onConfirm();
              } else {
                Get.back();
              }
            },
            isDestructiveAction: isDestructive,
            child: AppText.button1Bold(
              confirmText.tr,
              context: context,
              color: confirmTextColor,
            ),
          ),
        ],
      ),
      routeSettings: routeSettings,
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showSingleButtonCustomDialog({
    required BuildContext context,
    String? title,
    Widget? description,
    String confirmText = 'Got it',
    VoidCallback? onConfirm,
    Color? confirmTextColor,
    bool isDestructive = false,
    bool barrierDismissible = false,
  }) async {
    if (testMode != null) {
      return testMode!.showSingleButtonCustomDialog(
        context: context,
        title: title,
        description: description,
        confirmText: confirmText,
        onConfirm: onConfirm,
        confirmTextColor: confirmTextColor,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
      );
    }
    await Get.dialog(
      CupertinoAlertDialog(
        title: title != null
            ? AppText.title3(
                title,
                context: context,
                textAlign: TextAlign.center,
                color: context.theme.appColors.textDarkest,
              )
            : null,
        content: description,
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              if (onConfirm != null) {
                onConfirm();
              } else {
                Get.back();
              }
            },
            isDestructiveAction: isDestructive,
            child: AppText.button1Bold(
              confirmText.tr,
              context: context,
              color: confirmTextColor,
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void showGeneralErrorDialog({
    required BuildContext context,
    bool isDestructive = false,
    bool barrierDismissible = false,
    String? message,
    String? description,
    Exception? e,
  }) {
    if (testMode != null) {
      return testMode!.showGeneralErrorDialog(
        context: context,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
        message: message,
        e: e,
      );
    }
    Get.dialog(
      CupertinoAlertDialog(
        title: AppText.title3(
          message ?? 'Something went wrong. Please try again later'.tr,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textDarkest,
        ),
        content: description != null
            ? AppText.body3(
                description,
                context: context,
                textAlign: TextAlign.center,
              )
            : null,
        actions: [
          GestureDetector(
            onLongPress: () {
              if (e != null) {
                Clipboard.setData(
                  ClipboardData(text: e.toString()),
                );
              }
            },
            child: CupertinoDialogAction(
              onPressed: () {
                Get.back();
              },
              isDestructiveAction: isDestructive,
              child: AppText.button2Bold(
                'Got it'.tr,
                context: context,
                color: context.theme.appColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showYouAreOfflineDialog({
    required BuildContext context,
    bool isDestructive = false,
    bool barrierDismissible = false,
  }) async {
    if (testMode != null) {
      return testMode!.showYouAreOfflineDialog(
        context: context,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
      );
    }
    final offlineDialogLabel = 'OFFLINE_DIALOG_LABEL';
    if (Get.isDialogOpen == true && Get.routing.route?.settings.name == offlineDialogLabel) {
      return;
    }

    await Get.dialog(
      routeSettings: RouteSettings(name: offlineDialogLabel),
      CupertinoAlertDialog(
        title: AppText.title3(
          'You are offline. Please try again later'.tr,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textDarkest,
        ),
        actions: [
          GestureDetector(
            child: CupertinoDialogAction(
              onPressed: () {
                Get.back();
              },
              isDestructiveAction: isDestructive,
              child: AppText.button2Bold(
                'Got it'.tr,
                context: context,
                color: context.theme.appColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void showConnectionErrorDialog({
    required BuildContext context,
    bool isDestructive = false,
    bool barrierDismissible = false,
  }) {
    if (testMode != null) {
      return testMode!.showConnectionErrorDialog(
        context: context,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
      );
    }

    final connectionErrorLabel = 'UNSTABLE_CONNECTIONS';
    if (Get.isDialogOpen == true && Get.routing.route?.settings.name == connectionErrorLabel) {
      return;
    }

    Get.dialog(
      routeSettings: RouteSettings(name: connectionErrorLabel),
      CupertinoAlertDialog(
        title: AppText.title3(
          'Unstable connection\nPlease try again later'.tr,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textDarkest,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            isDestructiveAction: isDestructive,
            child: AppText.button2Bold(
              'Got it'.tr,
              context: context,
              color: context.theme.appColors.textPrimary,
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void showAlbumImageLongPressDialog({
    required BuildContext context,
    required String imageUrl,
    required bool isSelected,
    required Function onSelectPressed,
    required Function onDownloadPressed,
    required Function onSharePressed,
    required Function onDeletePressed,
    bool isDisableAlbumMenu = false,
  }) {
    if (testMode != null) {
      return testMode!.showAlbumImageLongPressDialog(
        context: context,
        imageUrl: imageUrl,
        isSelected: isSelected,
        onSelectPressed: onSelectPressed,
        onDownloadPressed: onDownloadPressed,
        onSharePressed: onSharePressed,
        onDeletePressed: onDeletePressed,
      );
    }

    Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            color: Colors.grey.shade200.withValues(alpha: 0.4),
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                    child: UChatImage.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      customErrorWidget: (state) {
                        return const AlbumErrorImageBox();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.space4),
                if (isDisableAlbumMenu == false) ...[
                  Container(
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundNeutralLightest,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppRadius.roundedXl),
                        topRight: Radius.circular(AppRadius.roundedXl),
                      ),
                      border: Border(
                        left: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        right: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        top: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSpace.space1, horizontal: AppSpace.space4),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        onSelectPressed();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AppText.body1(
                              isSelected ? 'Unselect'.tr : 'Select'.tr,
                              color: context.theme.appColors.textDarkest,
                              context: context,
                            ),
                          ),
                          const SizedBox(width: AppSpace.space2),
                          Assets.vectors.iconCheckCircle.svg(
                            colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundNeutralLightest,
                      border: Border(
                        left: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        right: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        top: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSpace.space1, horizontal: AppSpace.space4),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        onDownloadPressed();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AppText.body1(
                              'Download'.tr,
                              color: context.theme.appColors.textDarkest,
                              context: context,
                            ),
                          ),
                          const SizedBox(width: AppSpace.space2),
                          Assets.vectors.iconDownload.svg(
                            colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundNeutralLightest,
                      border: Border(
                        left: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        right: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        top: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSpace.space1, horizontal: AppSpace.space4),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        onSharePressed();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AppText.body1(
                              'Share'.tr,
                              color: context.theme.appColors.textDarkest,
                              context: context,
                            ),
                          ),
                          const SizedBox(width: AppSpace.space2),
                          Assets.vectors.iconShare.svg(
                            colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundNeutralLightest,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(AppRadius.roundedXl),
                        bottomRight: Radius.circular(AppRadius.roundedXl),
                      ),
                      border: Border.all(
                        color: context.theme.appColors.border,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSpace.space1, horizontal: AppSpace.space4),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        onDeletePressed();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AppText.body1(
                              'Delete'.tr,
                              color: context.theme.appColors.textError,
                              context: context,
                            ),
                          ),
                          const SizedBox(width: AppSpace.space2),
                          Assets.vectors.iconTrash.svg(
                            colorFilter: ColorFilter.mode(context.theme.appColors.iconError, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  Container(
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundNeutralLightest,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppRadius.roundedXl),
                        topRight: Radius.circular(AppRadius.roundedXl),
                      ),
                      border: Border(
                        left: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        right: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        top: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSpace.space1, horizontal: AppSpace.space4),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        onDownloadPressed();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AppText.body1(
                              'Download'.tr,
                              color: context.theme.appColors.textDarkest,
                              context: context,
                            ),
                          ),
                          const SizedBox(width: AppSpace.space2),
                          Assets.vectors.iconDownload.svg(
                            colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundNeutralLightest,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(AppRadius.roundedXl),
                        bottomRight: Radius.circular(AppRadius.roundedXl),
                      ),
                      border: Border(
                        left: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        right: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                        top: BorderSide(
                          color: context.theme.appColors.border,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSpace.space1, horizontal: AppSpace.space4),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        onSharePressed();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AppText.body1(
                              'Share'.tr,
                              color: context.theme.appColors.textDarkest,
                              context: context,
                            ),
                          ),
                          const SizedBox(width: AppSpace.space2),
                          Assets.vectors.iconShare.svg(
                            colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showRetryAlbumUploadDownloadDialog({
    required BuildContext context,
    required String title,
    required VoidCallback onRetry,
    required VoidCallback onDiscard,
    bool isDestructive = false,
    bool barrierDismissible = false,
    bool showRetryButton = true,
  }) {
    if (testMode != null) {
      return testMode!.showRetryAlbumUploadDownloadDialog(
        context: context,
        title: title,
        onRetry: onRetry,
        onDiscard: onDiscard,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
        showRetryButton: showRetryButton,
      );
    }
    Get.dialog(
      CupertinoAlertDialog(
        title: AppText.title3(
          title,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textDarkest,
        ),
        content: AppText.body3(
          'Your request cannot be processed due to a temporary error. Please try again'.tr,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textLight,
        ),
        actions: [
          if (showRetryButton)
            CupertinoDialogAction(
              onPressed: () {
                onRetry();
                Get.back();
              },
              isDestructiveAction: isDestructive,
              child: AppText.button1Bold(
                'Retry'.tr,
                context: context,
                color: context.theme.appColors.textPrimary,
              ),
            ),
          CupertinoDialogAction(
            onPressed: () {
              onDiscard();
              Get.back();
            },
            isDestructiveAction: isDestructive,
            child: AppText.button1Bold(
              'Discard'.tr,
              context: context,
              color: context.theme.appColors.textError,
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            isDestructiveAction: isDestructive,
            child: AppText.button1Bold(
              'Cancel'.tr,
              context: context,
              color: context.theme.appColors.textLight,
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void showResendFailedMessageDialog({
    required BuildContext context,
    required String title,
    required VoidCallback onResend,
    required VoidCallback onDelete,
    bool isDestructive = false,
    bool barrierDismissible = false,
  }) {
    if (testMode != null) {
      return testMode!.showResendFailedMessageDialog(
        context: context,
        title: title,
        onResend: onResend,
        onDelete: onDelete,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
      );
    }
    Get.dialog(
      CupertinoAlertDialog(
        title: AppText.title3(
          title,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textDarkest,
        ),
        content: AppText.body3(
          'There is a problem that prevents sending messages. Please try again'.tr,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textLight,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
              onResend();
            },
            isDestructiveAction: isDestructive,
            child: AppText.button1Bold(
              'Resend'.tr,
              context: context,
              color: context.theme.appColors.textPrimary,
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
              onDelete();
            },
            isDestructiveAction: isDestructive,
            child: AppText.button1Bold(
              'Delete'.tr,
              context: context,
              color: context.theme.appColors.textError,
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            isDestructiveAction: isDestructive,
            child: AppText.button1Bold(
              'Cancel'.tr,
              context: context,
              color: context.theme.appColors.textLight,
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void showSingleButtonWithIconDialog({
    required SvgPicture svgIcon,
    String? title,
    String? description,
    String confirmText = 'Got it',
    VoidCallback? onConfirm,
    Color? confirmTextColor,
    bool isDestructive = false,
    bool barrierDismissible = false,
    dynamic exception,
  }) {
    if (testMode != null) {
      return testMode!.showSingleButtonWithIconDialog(
        svgIcon: svgIcon,
        title: title,
        description: description,
        confirmText: confirmText,
        onConfirm: onConfirm,
        confirmTextColor: confirmTextColor,
        isDestructive: isDestructive,
        barrierDismissible: barrierDismissible,
        exception: exception,
      );
    }
    final context = Get.context!;
    Get.dialog(
      CupertinoAlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            svgIcon,
            const SizedBox(height: AppSpace.space2),
            AppText.title3(
              title?.tr ?? '',
              context: context,
              textAlign: TextAlign.center,
              color: context.theme.appColors.textDarkest,
            ),
          ],
        ),
        content: (description != null && description.isNotEmpty)
            ? AppText.body3(
                description.tr,
                context: context,
                textAlign: TextAlign.center,
                color: context.theme.appColors.textLight,
              )
            : null,
        actions: [
          GestureDetector(
            onLongPress: () {
              if (exception != null) {
                Clipboard.setData(
                  ClipboardData(text: exception.toString()),
                );
              }
            },
            child: CupertinoDialogAction(
              onPressed: () {
                if (onConfirm != null) {
                  onConfirm();
                } else {
                  Get.back();
                }
              },
              isDestructiveAction: isDestructive,
              child: AppText.button1Bold(
                confirmText.tr,
                context: context,
                color: confirmTextColor,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void showDownloadAlbumImagePartialSuccessDialog({
    required BuildContext context,
    required int successCount,
    required int totalImages,
  }) {
    if (testMode != null) {
      return testMode!.showDownloadAlbumImagePartialSuccessDialog(
        context: context,
        successCount: successCount,
        totalImages: totalImages,
      );
    }
    UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'There was a problem with the download'.tr,
      description: 'There was an issue with the download. Successfully loaded @count out of @total items'.trParams({
        'count': successCount.toString(),
        'total': totalImages.toString(),
      }),
      confirmTextColor: context.theme.appColors.textPrimary,
    );
  }

  static void showFileTooLargeDialog({
    required BuildContext context,
    int maxFileSize = UChatConstant.fileSizeLimit,
  }) {
    if (testMode != null) {
      return testMode!.showFileTooLargeDialog(
        context: context,
        maxFileSize: maxFileSize,
      );
    }
    UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Max file size: @sizeInMB MB'.trParams({'sizeInMB': maxFileSize.sizeInMB.toString()}),
      description:
          "The file you're trying to send exceeds @sizeInMB MB size limit. \nPlease compress the file or use \na cloud service to share it."
              .trParams({'sizeInMB': maxFileSize.sizeInMB.toString()}),
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
    );
  }

  static void showFileTooLargeDialogWithSize({
    required BuildContext context,
    int width = UChatConstant.maxWidthMedia,
    int height = UChatConstant.maxHeightMedia,
  }) {
    if (testMode != null) {
      return testMode!.showFileTooLargeDialogWithSize(
        context: context,
        width: width,
        height: height,
      );
    }
    UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'The file is too large'.tr,
      description:
          'The file you\'re sending is too large. Please select a file that is not larger than @width x @height pixels and try again.'
              .trParams({
        'width': width.toString(),
        'height': height.toString(),
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
    );
  }

  static void showUnsupportedFile({required BuildContext context}) {
    if (testMode != null) {
      return testMode!.showUnsupportedFile(context: context);
    }
    UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Unable to open photo'.tr,
      description:
          'This file type is not supported. Check the supported formats or try opening it with another app.'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
    );
  }

  static void showConfirmDeleteChatDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    if (testMode != null) {
      return testMode!.showConfirmDeleteChatDialog(
        context: context,
        onConfirm: onConfirm,
      );
    }
    UChatNewDialog.showDialog(
      context: context,
      title: 'Delete this chat'.tr,
      description: 'Permanently remove this chat and all its messages. This action cannot be undone.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Delete'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: onConfirm,
    );
  }

  /// Shows a confirmation dialog for leaving a group
  static void showLeaveGroupDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    UChatNewDialog.showDialog(
      context: context,
      title: 'Confirm leaving the group?'.tr,
      description: 'Do you want to confirm your exit from this group?'.tr,
      confirmText: 'Leave'.tr,
      onConfirm: onConfirm,
      confirmTextColor: context.theme.appColors.textError,
      cancelTextColor: context.theme.appColors.textLight,
      isDestructive: true,
    );
  }

  static void showBlockUserDialog({
    required BuildContext context,
    required String name,
    required VoidCallback onConfirm,
  }) {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Block ‘@userDisplayName‘?'.trParams({
        'userDisplayName': name,
      }),
      description:
          'This account will no longer be able to contact you on UChat.\n\nTo unblock this account, go to: Settings > Friends > Blocked Accounts.'
              .tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Block'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: onConfirm,
    );
  }

  static void showUnblockUserDialog({
    required BuildContext context,
    required String name,
    required VoidCallback onConfirm,
  }) {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: name,
      description:
          'This account will be able to contact you again on UChat.\n\nTo block this account, go to: Settings > Friends > Blocked Accounts.'
              .tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Unblock'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: onConfirm,
    );
  }

  static void showAccountBannedDialog({
    required BuildContext context,
    required String? content,
    required VoidCallback onConfirm,
  }) {
    UChatNewDialog.showSingleButtonCustomDialog(
      onConfirm: onConfirm,
      context: context,
      description: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.vectors.accountBannedIcon.svg(),
          AppText.title3(
            'Account banned'.tr,
            context: context,
            textAlign: TextAlign.center,
          ),
          AppText.body3(
            content ??
                'You cannot use your account due to a violation of the terms of service.\n\ncontact us at @emailUChat'
                    .trParams({
                  'emailUChat': UChatConstant.emailUChat,
                }),
            context: context,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
    );
  }

  static void showConfirmClearRecentlyStickerSearch({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    UChatNewDialog.showDialog(
      context: context,
      title: 'Clear recent searches'.tr,
      description: 'Clear all recent search records.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Clear'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: onConfirm,
    );
  }

  static void showSendReasonRefundCoinSuccess() {
    UChatNewDialog.showSingleButtonDialog(
      context: Get.context!,
      title: 'Received your message'.tr,
      description:
          'We need to consider the reasons for violating the Terms and condition and will contact you later.'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
    );
  }

  static void sendAlreadySubmitReasonRefundCoin() {
    UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Reason has already been submitted.'.tr,
        description:
            'Your refund reason has already been submitted from another device. Thank you for your cooperation.'.tr,
        confirmTextColor: Get.context!.theme.appColors.textPrimary,
        onConfirm: () {
          Get.close(2);
        });
  }

  static void showPurchasedStickerSuccessDialog({
    required String packId,
    required String fileId,
    bool isDestructive = false,
    dynamic exception,
  }) {
    final context = Get.context!;
    Get.dialog(
      CupertinoAlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StickerItemPreview(
              packId: packId,
              fileId: fileId,
              width: AppSize.size28,
              height: AppSize.size28,
            ),
            const SizedBox(height: AppSpace.space2),
            AppText.title3(
              'You have successfully purchased a new sticker'.tr,
              context: context,
              textAlign: TextAlign.center,
              color: context.theme.appColors.textDarkest,
            ),
          ],
        ),
        content: AppText.body3(
          'Download your new sticker and start chatting!'.tr,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textLight,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            isDestructiveAction: isDestructive,
            child: AppText.button1Bold(
              'Got it'.tr,
              context: context,
              color: context.theme.appColors.textPrimary,
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  static void showSendGiftStickerSuccessDialog({
    required String packId,
    required String fileId,
    required String friendName,
    bool isDestructive = false,
    dynamic exception,
  }) {
    final context = Get.context!;
    Get.dialog(
      CupertinoAlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StickerItemPreview(
              packId: packId,
              fileId: fileId,
              width: AppSize.size28,
              height: AppSize.size28,
            ),
            const SizedBox(height: AppSpace.space2),
            AppText.title3(
              'Your gift has been sent'.tr,
              context: context,
              textAlign: TextAlign.center,
              color: context.theme.appColors.textDarkest,
            ),
          ],
        ),
        content: AppText.body3(
          'The sticker has been successfully gifted to @friendName'.trParams({'friendName': friendName}),
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textLight,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            isDestructiveAction: isDestructive,
            child: AppText.button1Bold(
              'Got it'.tr,
              context: context,
              color: context.theme.appColors.textPrimary,
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  static void showCoinNotEnoughDialog() {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Not enough coins'.tr,
      description: 'You don\'t have enough coins to purchase this sticker. Would you like to top up your balance?'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Buy coin'.tr,
      onConfirm: () {
        InAppPurchaseController.instance.jumpToCoinStore();
      },
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      cancelTextColor: Get.context!.theme.appColors.textLight,
    );
  }

  static void showMultipleActionsDialog({
    required String title,
    required String description,
    required List<UChatNewDialogAction> actions,
    BuildContext? context,
    bool isDestructive = false,
    bool barrierDismissible = false,
  }) {
    if (context == null) return;

    final dialogActions = actions
        .map(
          (action) => CupertinoDialogAction(
            onPressed: () {
              Get.back();
              action.onPressed?.call();
            },
            isDestructiveAction: isDestructive,
            child: action.title,
          ),
        )
        .toList();

    Get.dialog(
      CupertinoAlertDialog(
        title: AppText.title3(
          title,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textDarkest,
        ),
        content: AppText.body3(
          description,
          context: context,
          textAlign: TextAlign.center,
          color: context.theme.appColors.textDark,
        ),
        actions: dialogActions,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showCoinPromotion({
    required AnnouncementCollection coinPromotion,
    void Function()? onPressDoNotShow,
  }) async {
    await Get.dialog(
      CoinPromotionDialog(
        coinPromotion: coinPromotion,
        onPressDoNotShow: onPressDoNotShow ??
            () async {
              try {
                await GetIt.I<DoNotShowPromotionTodayUseCase>().call(NoParams());
              } catch (e, stacktrace) {
                useLogger().e('Error handling don\'t show pressed', e, stacktrace);
              } finally {
                Get.back();
              }
            },
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> showCancelPurchase({required BuildContext context}) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Your purchase has been cancelled.'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
    );
  }

  static Future<void> showPreventPlayAudioDuringCall({required BuildContext context}) async {
    return showSingleButtonDialog(
      context: context,
      title: 'This feature is unavailable while a call is in progress'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.theme.appColors.textPrimary,
    );
  }

  static void showConfirmRevokeInviteLinkDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    if (testMode != null) {
      return testMode!.showConfirmDeleteChatDialog(
        context: context,
        onConfirm: onConfirm,
      );
    }

    UChatNewDialog.showDialog(
      context: context,
      title: 'Revoke invite link?'.tr,
      description: 'Do you want to confirm the revocation of this invitation link?'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Revoke'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: onConfirm,
    );
  }

  static Future<void> showRoomMemberExceedLimit({
    required BuildContext context,
  }) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: Get.context!,
      title: 'Group member limit reached'.tr,
      description:
          'This group has reached its maximum member limit, and you cannot join at this time.\n\nYou may be able to join in the future if space becomes available.'
              .tr,
    );
  }

  static Future<void> showPermissionDeniedDialog({
    required BuildContext context,
    String? title,
    String? description,
    String? buttonText,
    VoidCallback? onButtonTap,
    bool barrierDismissible = false,
    bool useCupertinoStyle = true,
    bool isDestructive = true,
  }) async {
    final titleText = title ?? 'You don’t have the permission to perform this action'.tr;
    if (useCupertinoStyle) {
      return await Get.dialog(
        CupertinoAlertDialog(
          title: AppText.title3(
            titleText,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textDarkest,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Get.back();
              },
              isDestructiveAction: isDestructive,
              child: AppText.button2Bold(
                'Got it'.tr,
                context: context,
                color: context.theme.appColors.textPrimary,
              ),
            ),
          ],
        ),
        barrierDismissible: barrierDismissible,
      );
    }

    return await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.size8),
        ),
        backgroundColor: context.theme.appColors.elevationSurface,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppSpace.space14),
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppSpace.space6,
            bottom: AppSpace.space4,
            left: AppSpace.space4,
            right: AppSpace.space4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
                child: AppText.title3(
                  titleText,
                  context: context,
                  color: context.theme.appColors.textDarkest,
                  textAlign: TextAlign.left,
                ),
              ),
              AppSize.size1.height,
              if (description != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpace.space3,
                    right: AppSpace.space3,
                    top: AppSpace.space1,
                    bottom: AppSpace.space4,
                  ),
                  child: AppText.body2(
                    description,
                    context: context,
                    color: context.theme.appColors.textDark,
                    textAlign: TextAlign.left,
                  ),
                )
              else
                AppSpace.space4.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppFilledButton.primary(
                      context: context,
                      label: (buttonText ?? 'Got it').tr,
                      onTap: () {
                        Get.back();
                        onButtonTap?.call();
                      },
                      style: AppButtonStyle.fullRounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showRequestNotFoundDialog({
    required BuildContext context,
    String? title,
    String? description,
    String? buttonText,
    VoidCallback? onButtonTap,
    bool barrierDismissible = false,
    bool useCupertinoStyle = true,
    bool isDestructive = true,
  }) async {
    final titleText = title ?? 'Request not found'.tr;
    final descriptionText = description ?? 'This request has already been processed'.tr;
    if (useCupertinoStyle) {
      return await Get.dialog(
        CupertinoAlertDialog(
          title: AppText.title3(
            titleText,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textDarkest,
          ),
          content: AppText.body3(
            descriptionText,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textLight,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Get.back();
              },
              isDestructiveAction: isDestructive,
              child: AppText.button2Bold(
                'Got it'.tr,
                context: context,
                color: context.theme.appColors.textPrimary,
              ),
            ),
          ],
        ),
        barrierDismissible: barrierDismissible,
      );
    }

    return await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.size8),
        ),
        backgroundColor: context.theme.appColors.elevationSurface,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppSpace.space14),
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppSpace.space6,
            bottom: AppSpace.space4,
            left: AppSpace.space4,
            right: AppSpace.space4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
                child: AppText.title3(
                  titleText,
                  context: context,
                  color: context.theme.appColors.textDarkest,
                  textAlign: TextAlign.left,
                ),
              ),
              AppSize.size1.height,
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpace.space3,
                  right: AppSpace.space3,
                  top: AppSpace.space1,
                  bottom: AppSpace.space4,
                ),
                child: AppText.body2(
                  descriptionText,
                  context: context,
                  color: context.theme.appColors.textDark,
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AppFilledButton.primary(
                      context: context,
                      label: (buttonText ?? 'Got it').tr,
                      onTap: () {
                        Get.back();
                        onButtonTap?.call();
                      },
                      style: AppButtonStyle.fullRounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void showPinMessageLimitDialog({required BuildContext context}) {
    UChatNewDialog.showSingleButtonDialog(
      context: Get.context!,
      title: 'Pinning messages is limited'.tr,
      description: 'You’ve reached the limit of 20 pinned messages. Unpin an existing one to pin this message'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
    );
  }

  static void showJumpMessageUnavailableDialog({required BuildContext context}) {
    UChatNewDialog.showSingleButtonDialog(
      context: Get.context!,
      title: 'Message is unavailable'.tr,
      description: 'The message you find may no longer be available as it may have been unsent or deleted'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
    );
  }

  static Future<bool?> showAccountSettingUnavailableDialog(BuildContext context, UserEntity user) async {
    final isConfirm = await UChatNewDialog.showDialog(
      context: context,
      title: 'Please change to this account to edit your account'.tr,
      description: 'You cannot edit an account that is currently inactive. Please use this account before editing.'.tr,
      confirmText: 'Use account'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
    );
    if (isConfirm == true) {
      await GetIt.I<AccountsCenterService>().switchAccount(user);
    }
    return isConfirm;
  }

  static Future<void> showFriendLimitExceededDialog() async {
    if (Get.context != null) {
      await UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Friend Limit Reached'.tr,
        description:
            'You have reached the maximum number of friends. To add a new friend, please remove someone from your contact list.'
                .tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.theme.appColors.textPrimary,
      );
    }
  }

  static Future<void> showOfficialAccountLimitExceededDialog() async {
    if (Get.context != null) {
      await UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Official Account Limit Reached'.tr,
        description:
            'You have reached the maximum number of Official Accounts. Please remove an existing Official Account before adding a new one.'
                .tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.theme.appColors.textPrimary,
      );
    }
  }

  static void showSingleButtonDialogV2({
    required BuildContext context,
    required String title,
    String? description,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.rounded4xl),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.appColors.elevationSurface,
            borderRadius: BorderRadius.circular(AppRadius.rounded4xl),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space4,
            vertical: AppSpace.space6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
                child: AppText.title3(
                  title,
                  context: context,
                  textAlign: TextAlign.start,
                  color: context.theme.appColors.textDarkest,
                ),
              ),
              if (description != null) ...[
                const SizedBox(height: AppSpace.space1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppText.body3(
                      description,
                      context: context,
                      textAlign: TextAlign.start,
                      color: context.theme.appColors.textDark,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpace.space4),
              AppFilledButton.primary(
                context: context,
                label: 'Got it'.tr,
                onTap: () {
                  Get.back();
                },
                style: AppButtonStyle.fullRounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool?> showConfirmDialogV2({
    required BuildContext context,
    required String title,
    String? description,
    String? confirmText,
    String? cancelText,
    Function? onConfirm,
  }) async {
    return await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.rounded4xl),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.appColors.elevationSurface,
            borderRadius: BorderRadius.circular(AppRadius.rounded4xl),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space4,
            vertical: AppSpace.space6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
                child: AppText.title3(
                  title,
                  context: context,
                  textAlign: TextAlign.start,
                  color: context.theme.appColors.textDarkest,
                ),
              ),
              if (description != null) ...[
                const SizedBox(height: AppSpace.space1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppText.body3(
                      description,
                      context: context,
                      textAlign: TextAlign.start,
                      color: context.theme.appColors.textDark,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpace.space4),
              Row(
                children: [
                  Expanded(
                    child: AppFilledButton.defaultButton(
                      context: context,
                      label: cancelText ?? 'Cancel'.tr,
                      onTap: () {
                        Get.back(result: false);
                      },
                      style: AppButtonStyle.fullRounded,
                    ),
                  ),
                  const SizedBox(width: AppSpace.space2),
                  Expanded(
                    child: AppFilledButton.primary(
                      context: context,
                      label: confirmText ?? 'Confirm'.tr,
                      onTap: () {
                        Get.back(result: true);
                        onConfirm?.call();
                      },
                      style: AppButtonStyle.fullRounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// This widget is used to show a dialog with a title, description, and two buttons (cancel and confirm).
/// It is used in the UChatNewDialog's showDialog function to show the dialog.
/// This is created to give this widget a build function to be able to use dialog's context to use in Navigator.pop
/// without dialog context, Navigator.pop will probably pop the wrong screen or widget instead of pop this dialog.
class _UChatDialogWidget extends StatelessWidget {
  final String title;
  final String? description;
  final String? description2;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final String cancelText;
  final String confirmText;
  final bool isDestructive;
  final Color? cancelTextColor;
  final Color? confirmTextColor;

  const _UChatDialogWidget({
    required this.title,
    required this.description,
    this.description2,
    this.onCancel,
    this.onConfirm,
    required this.cancelText,
    required this.confirmText,
    required this.isDestructive,
    this.cancelTextColor,
    this.confirmTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: AppText.title3(
        title,
        context: context,
        textAlign: TextAlign.center,
      ),
      content: Column(
        children: [
          if (description?.isNotEmpty == true)
            AppText.body3(
              description!,
              context: context,
              textAlign: TextAlign.center,
              color: context.theme.appColors.textLight,
            ),
          if (description2 != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpace.space4),
              child: AppText.body3(
                description2 ?? '',
                context: context,
                textAlign: TextAlign.center,
                color: context.theme.appColors.textLight,
              ),
            ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            } else {
              // This use Navigator.pop because when in app notification is showing Get.back() will close in app
              // notification instead of this dialog.
              Navigator.of(context).pop(false);
            }
          },
          child: AppText.button2Bold(
            cancelText.tr,
            context: context,
            color: cancelTextColor,
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            if (onConfirm != null) {
              // This use Navigator.pop because when in app notification is showing Get.back() will close in app
              // notification instead of this dialog.
              Navigator.of(context).pop(true);
              onConfirm!();
            } else {
              // This use Navigator.pop because when in app notification is showing Get.back() will close in app
              // notification instead of this dialog.
              Navigator.of(context).pop(true);
            }
          },
          isDestructiveAction: isDestructive,
          child: AppText.button2Bold(
            confirmText.tr,
            context: context,
            color: confirmTextColor,
          ),
        ),
      ],
    );
  }
}

class UChatNewDialogAction {
  final Widget title;
  final VoidCallback? onPressed;

  UChatNewDialogAction({
    required this.title,
    this.onPressed,
  });
}

class UChatDialogV3 {
  static Future<T?> showDefaultDialog<T>({
    required BuildContext context,
    String? title,
    String? description,
    String? cancelText,
    String? confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool barrierDismissible = false,
    bool isRedButton = false,
    Widget? contentWidget,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        final confirmButton = isRedButton
            ? AppFilledButton.error(
                context: context,
                label: confirmText ?? 'Confirm'.tr,
                style: AppButtonStyle.fullRounded,
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  onConfirm?.call();
                },
                size: AppButtonSize.medium,
              )
            : AppFilledButton.primary(
                context: context,
                label: confirmText ?? 'Confirm'.tr,
                style: AppButtonStyle.fullRounded,
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  onConfirm?.call();
                },
                size: AppButtonSize.medium,
              );

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpace.space8)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.space4,
              AppSpace.space6,
              AppSpace.space4,
              AppSpace.space4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                contentWidget ?? const SizedBox.shrink(),
                if (title != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSpace.space3),
                      child: AppText.title3(
                        title,
                        context: context,
                        color: context.theme.appColors.textDarkest,
                      ),
                    ),
                  ),
                if (description != null) ...[
                  const SizedBox(height: AppSpace.space1),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpace.space3),
                    child: AppText.body2(
                      description,
                      context: context,
                      color: context.theme.appColors.textDark,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpace.space4),
                Row(
                  children: [
                    Expanded(
                      child: AppFilledButton.defaultButton(
                        context: context,
                        label: cancelText ?? 'Cancel'.tr,
                        style: AppButtonStyle.fullRounded,
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                          onCancel?.call();
                        },
                        size: AppButtonSize.medium,
                      ),
                    ),
                    const SizedBox(width: AppSpace.space2),
                    Expanded(child: confirmButton),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<T?> showSingleButtonDialog<T>({
    required BuildContext context,
    String? title,
    String? description,
    String? confirmText,
    VoidCallback? onConfirm,
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpace.space8)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.space4,
              AppSpace.space6,
              AppSpace.space4,
              AppSpace.space4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSpace.space3),
                      child: AppText.title3(
                        title,
                        context: context,
                        color: context.theme.appColors.textDarkest,
                      ),
                    ),
                  ),
                if (description != null) ...[
                  const SizedBox(height: AppSpace.space1),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpace.space3),
                    child: AppText.body2(
                      description,
                      context: context,
                      color: context.theme.appColors.textDark,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpace.space4),
                AppFilledButton.primary(
                  context: context,
                  label: confirmText ?? 'Confirm'.tr,
                  style: AppButtonStyle.fullRounded,
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    onConfirm?.call();
                  },
                  size: AppButtonSize.medium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showDialogDontHavePermission() {
    UChatDialogV3.showSingleButtonDialog(
      context: Get.context!,
      title: 'You don’t have the permission to perform this action.'.tr,
      confirmText: 'Got it'.tr,
    );
  }
}
