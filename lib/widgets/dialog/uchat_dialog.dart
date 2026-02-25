import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/report_type.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/accounts_center/presentation/arguments/account_setting_arguments.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/screens/premium_packages/compare/controllers/premium_package_compare_controller.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/dimensions.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/file_info_dialog.dart';
import 'package:uchat/widgets/dialog/report/report_controller.dart';
import 'package:uchat/widgets/file_info/file_info_list.dart';

final _log = useLogger();

typedef UChatDialogChild = Widget Function(bool Function()? fullScreenToggle);
typedef UChatDialogChildBuilder = Widget Function(void Function()? fullScreenToggle, Widget? child);

class DialogController extends GetxController {
  final isDisable = true.obs;

  void setIsDisable({required bool value}) {
    isDisable.value = value;
  }
}

@Deprecated('Use UChatNewDialog instead')
class UChatDialog {
  static Color blueDialogButtonColor = UTheme.color.primary;
  static const Color blackDialogButtonColor = Color(0xFF4D4D4D);
  static const Color redDialogButtonColor = Color(0xFFFF1552);
  static const Color yellowDialogButtonColor = Color(0xFFFFAA3A);
  static const Color darkBlueDialogButtonColor = Color(0xFF0D3E78);
  static const Color veryDarkBlueDialogButtonColor = Color(0xFF03244A);
  static Color barrierColor = Colors.black.withValues(alpha: 0.5);

  static TextStyle defaultConfirmButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle defaultCancelButtonTextStyle = const TextStyle(
    color: Color(0xFF808080),
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle defaultDescriptionTextStyle = const TextStyle(
    color: Color(0xFF808080),
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static Future<C?> showCustomDialog<C extends Object?, CR extends GetxController>({
    required final UChatDialogChild child,
    bool barrierDismissible = true,
    CR? init,
    String? tag,
    bool global = true,
    bool autoRemoveCtl = true,
    final void Function(GetBuilderState<CR> state)? initState,
    final void Function(GetBuilderState<CR> state)? dispose,
    final void Function(GetBuilderState<CR>)? didChangeDependencies,
    bool isPage = true,
    Color? bgDialogColor,
    double? cDialogWidth,
    double? cDialogHeight,
    EdgeInsets? cDialogPadding,
    bool? disableBoxConstraints,
    Color? barrierColor,
    final void Function()? onTapOutSide,
  }) async {
    final result = await Get.dialog<C>(
      _create(
        child: (fullScreenToggle) => init == null
            ? child(fullScreenToggle)
            : GetBuilder<CR>(
                autoRemove: autoRemoveCtl,
                init: init,
                tag: tag,
                global: global,
                initState: initState ?? (state) {},
                dispose: dispose,
                didChangeDependencies: didChangeDependencies,
                builder: (CR controller) {
                  return child(fullScreenToggle);
                },
              ),
        isPage: isPage,
        backgroundColor: bgDialogColor,
        cDialogWidth: cDialogWidth,
        cDialogHeight: cDialogHeight,
        cDialogPadding: cDialogPadding,
        disableBoxConstraints: disableBoxConstraints,
      ),
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
    );

    if (result == null && onTapOutSide != null) {
      onTapOutSide();
    }

    return result;
  }

  /// Display 2 button (cancel and confirm) dialog.
  static Future<bool> showDialog({
    // Icon at the top of dialog
    String? headerIconPath,
    double headerIconSize = 62,
    EdgeInsets headerIconPadding = const EdgeInsets.only(top: 14, bottom: 28),
    required String title,
    TextStyle? titleTextStyle,
    // Padding between title and description
    double? descriptionTopPadding,
    Widget? customDescription,
    String description = '',
    TextStyle? descriptionTextStyle,
    String? confirmText,
    TextStyle? confirmButtonTextStyle,
    Color? confirmButtonColor,
    String? cancelText,
    TextStyle? cancelButtonTextStyle,
    Color? cancelButtonColor,
    bool showCloseButton = false,
    bool barrierDismissible = true,
    bool showConfirmButton = true,
    bool showCancelButton = true,
    // Call Get.back on press confirm button or not
    bool closeDialogOnConfirm = true,
    bool closeDialogOnCancel = true,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    // Widget below confirm / cancel button
    Widget? bottomContent,
    // For sticker gift
    String? stickerPackName,
    String? stickerPackId,
    String? stickerFileId,
    Widget? customCenterContent,
    Color? backgroundColor,
    bool? showBackButton,
    Color? closeIconBgColor,
    Color? closeIconColor,
    Axis buttonDirection = Axis.horizontal,
    void Function()? functionBackButton,
    String? imagePreview,
  }) async {
    final result = await Get.dialog<bool>(
      _create(
        headerIconPath: headerIconPath,
        headerIconSize: headerIconSize,
        headerIconPadding: headerIconPadding,
        title: title,
        titleTextStyle: titleTextStyle,
        descriptionTopPadding: descriptionTopPadding,
        customDescription: customDescription,
        description: description,
        descriptionTextStyle: descriptionTextStyle,
        confirmText: confirmText,
        confirmButtonTextStyle: confirmButtonTextStyle,
        confirmButtonColor: confirmButtonColor,
        cancelText: cancelText,
        cancelButtonTextStyle: cancelButtonTextStyle,
        cancelButtonColor: cancelButtonColor,
        showCloseButton: showCloseButton,
        showConfirmButton: showConfirmButton,
        showCancelButton: showCancelButton,
        closeDialogOnConfirm: closeDialogOnConfirm,
        closeDialogOnCancel: closeDialogOnCancel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        bottomContent: bottomContent,
        customCenterContent: customCenterContent,
        backgroundColor: backgroundColor,
        showBackButton: showBackButton,
        closeIconBgColor: closeIconBgColor,
        closeIconColor: closeIconColor,
        functionBackButton: functionBackButton,
        buttonDirection: buttonDirection,
        imagePreview: imagePreview,
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
    );
    return result ?? false;
  }

  /// Display 2 button (cancel and confirm) dialog.
  static Future<bool> showDialogWithObx({
    // Icon at the top of dialog
    String? headerIconPath,
    double headerIconSize = 62,
    EdgeInsets headerIconPadding = const EdgeInsets.only(top: 14, bottom: 28),
    required String title,
    TextStyle? titleTextStyle,
    // Padding between title and description
    double? descriptionTopPadding,
    String description = '',
    TextStyle? descriptionTextStyle,
    String? confirmText,
    TextStyle? confirmButtonTextStyle,
    Color? confirmButtonColor,
    String? cancelText,
    TextStyle? cancelButtonTextStyle,
    Color? cancelButtonColor,
    bool showCloseButton = false,
    bool barrierDismissible = true,
    bool showConfirmButton = true,
    // Call Get.back on press confirm button or not
    bool closeDialogOnConfirm = true,
    bool closeDialogOnCancel = true,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    // Widget below confirm / cancel button
    Widget? bottomContent,
    // For sticker gift
    String? stickerPackName,
    String? stickerPackId,
    String? stickerFileId,
    Widget? customCenterContent,
    Color? backgroundColor,
    bool? showBackButton,
    void Function()? functionBackButton,
    //use tag when you need to disable or enable button and tag need to the same String as when you Get.find(tag:tag)
    String? tag,
  }) async {
    final result = await Get.dialog<bool>(
      GetBuilder<DialogController>(
          init: DialogController(),
          tag: tag,
          builder: (controller) {
            return Obx(() {
              return _create(
                headerIconPath: headerIconPath,
                headerIconSize: headerIconSize,
                headerIconPadding: headerIconPadding,
                title: title,
                titleTextStyle: titleTextStyle,
                descriptionTopPadding: descriptionTopPadding,
                description: description,
                descriptionTextStyle: descriptionTextStyle,
                confirmText: confirmText,
                confirmButtonTextStyle: controller.isDisable()
                    ? UChatDialog.defaultCancelButtonTextStyle.copyWith(
                        color: const Color(0xFFFFFFFF).withValues(alpha: 0.2),
                      )
                    : confirmButtonTextStyle,
                confirmButtonColor: controller.isDisable() ? const Color(0xFF16181F) : confirmButtonColor,
                cancelText: cancelText,
                cancelButtonTextStyle: cancelButtonTextStyle,
                cancelButtonColor: cancelButtonColor,
                showCloseButton: showCloseButton,
                showConfirmButton: showConfirmButton,
                closeDialogOnConfirm: closeDialogOnConfirm,
                closeDialogOnCancel: closeDialogOnCancel,
                onConfirm: controller.isDisable() ? null : onConfirm,
                onCancel: onCancel,
                bottomContent: bottomContent,
                customCenterContent: customCenterContent,
                backgroundColor: backgroundColor,
                showBackButton: showBackButton,
                functionBackButton: functionBackButton,
              );
            });
          }),
      barrierDismissible: barrierDismissible,
    );
    return result ?? false;
  }

  /// Same as [showDialog] but with 1 button by default.
  static Future<bool> showAlertDialog({
    String? headerIconPath,
    double headerIconSize = 62,
    EdgeInsets headerIconPadding = const EdgeInsets.only(top: 14, bottom: 28),
    String? title,
    TextStyle? titleTextStyle,
    double? descriptionTopPadding,
    String description = '',
    TextStyle? descriptionTextStyle,
    String? buttonText,
    TextStyle? buttonTextStyle,
    Color? buttonColor,
    bool showCloseButton = false,
    bool barrierDismissible = true,
    bool closeDialogOnConfirm = true,
    VoidCallback? onPressed,
    Widget? bottomContent,
    bool canPopScope = true,
    String? imagePreview,
    bool showCancelButton = true,
  }) async {
    final result = await Get.dialog<bool>(
      PopScope(
        canPop: canPopScope,
        child: _create(
          headerIconPath: headerIconPath,
          headerIconSize: headerIconSize,
          headerIconPadding: headerIconPadding,
          title: title ?? 'Alert'.tr,
          titleTextStyle: titleTextStyle,
          descriptionTopPadding: descriptionTopPadding,
          description: description,
          descriptionTextStyle: descriptionTextStyle,
          confirmText: null,
          confirmButtonTextStyle: null,
          confirmButtonColor: null,
          cancelText: buttonText,
          cancelButtonTextStyle: buttonTextStyle ?? defaultConfirmButtonTextStyle,
          cancelButtonColor: buttonColor ?? UTheme.color.primary,
          showCloseButton: showCloseButton,
          showConfirmButton: false,
          onCancel: onPressed,
          bottomContent: bottomContent,
          closeDialogOnCancel: closeDialogOnConfirm,
          imagePreview: imagePreview,
          showCancelButton: showCancelButton,
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
    return result ?? false;
  }

  /// Display error dialog
  static Future<bool> showExceptionDialog({
    String? title,
    String? description,
    Widget? customDescriptionText,
    // If true, Show text and button for user to report bug.
    bool showReportBugWidget = true,
  }) async {
    Widget? reportBugWidget;
    if (showReportBugWidget) {
      reportBugWidget = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 12.spMin,
          ),
          const Icon(
            Icons.error_outline,
            color: Colors.grey,
          ),
          SizedBox(
            width: 12.spMin,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'If there is any problem please '.tr,
                style: DefaultTextStyle.of(Get.context!).style.copyWith(
                      color: const Color(0xFF808080),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'contact us'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () => reportBug(),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    final result = await Get.dialog<bool>(
      _create(
        title: title ?? 'Error'.tr,
        description:
            description ?? 'Something went wrong. Please check your Internet connection or try again later.'.tr,
        headerIconPath: UChatAssetPath.yellowWarningIcon,
        cancelText: 'Understood'.tr,
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: Colors.white,
        ),
        cancelButtonColor: UTheme.color.primary,
        showConfirmButton: false,
        bottomContent: reportBugWidget,
        customDescriptionText: customDescriptionText,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showBlockUserDialog({
    required bool isBlocked,
    required String userDisplayName,
  }) async {
    late Widget content;

    if (isBlocked) {
      content = _create(
        title: 'Unblock user'.tr,
        description: 'Do you want to unblock @userDisplayName ?'.trParams({
          'userDisplayName': userDisplayName,
        }),
        confirmText: 'Unblock'.tr,
        confirmButtonColor: UTheme.color.primary,
      );
    } else {
      content = _create(
        headerIconPath: UChatAssetPath.blockUserDialogIcon,
        title: 'Block user'.tr,
        description:
            'Do you want to block @userDisplayName? You won\'t be able to contact this user through UChat. If you want to unblock this user, you can go to Settings > Friends > Blocked Accounts.'
                .trParams({
          'userDisplayName': userDisplayName,
        }),
        confirmText: 'Block'.tr,
        confirmButtonColor: yellowDialogButtonColor,
      );
    }

    final result = await Get.dialog<bool>(content);
    return result ?? false;
  }

  static Future<bool> showDeleteDialog({
    required String title,
    String? description,
  }) async {
    final result = await Get.dialog<bool>(
      _create(
        headerIconPath: UChatAssetPath.deleteUserDialogIcon,
        headerIconSize: 50.spMin,
        title: title,
        description: description ?? '',
        confirmText: 'Delete'.tr,
        confirmButtonColor: redDialogButtonColor,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showHideUserDialog({
    required bool isHidden,
    required String userDisplayName,
  }) async {
    final result = await Get.dialog<bool>(
      _create(
        title: isHidden ? 'Unhide user'.tr : 'Hide user'.tr,
        description:
            'Do you want to hide @userDisplayName from your friends list? If you want to stop hiding this user, you can go to settings.'
                .trParams({
          'userDisplayName': userDisplayName,
        }),
        confirmText: isHidden ? 'Unhide'.tr : 'Hide'.tr,
        confirmButtonColor: blackDialogButtonColor,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showDeleteChatDialog({String? description}) async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Delete chat'.tr,
        description: description ?? 'Confirm deletion of all conversation history?'.tr,
        descriptionTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        confirmText: 'Confirm'.tr,
        confirmButtonColor: redDialogButtonColor,
        showCloseButton: true,
      ),
    );

    return result ?? false;
  }

  static Future<bool> showDeleteBookmarkChatDialog({String? description}) async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Delete bookmark'.tr,
        customDescription: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Confirm deletion of all bookmarks.\nChat data will be '.tr,
            style: DefaultTextStyle.of(Get.context!).style.copyWith(
                  color: const Color(0xFF808080),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.spMin,
                ),
            children: [
              TextSpan(
                text: 'permanently deleted'.tr,
                style: TextStyle(
                  color: const Color(0xFFFF1552),
                  fontWeight: FontWeight.w600,
                  fontSize: 12.spMin,
                ),
              ),
            ],
          ),
        ),
        confirmText: 'Confirm'.tr,
        confirmButtonColor: redDialogButtonColor,
        showCloseButton: true,
      ),
    );

    return result ?? false;
  }

  static Future<bool> showUnlinkGoogleOrAppleIdDialog({bool isAppleId = false}) async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Unlink @type'.trParams({'type': isAppleId ? 'Apple id' : 'Google account'}),
        description: 'Confirm that you want to unlink this account from @type?'.trParams({
          'type': isAppleId ? 'Apple id' : 'Google account',
        }),
        descriptionTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        confirmText: 'Confirm'.tr,
        confirmButtonColor: redDialogButtonColor,
        showCloseButton: true,
      ),
    );

    return result ?? false;
  }

  static Future<bool> showLeaveGroupDialog() async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Leave the group'.tr,
        description:
            'If you leave the group, the entire chat history in the group will be deleted. Are you sure you want to leave the group?'
                .tr,
        confirmText: 'OK'.tr,
        confirmButtonColor: redDialogButtonColor,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showPhoneNumberErrorDialog() async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Invalid phone number'.tr,
        description: 'Invalid phone number. Please check and try again.'.tr,
        titleTextStyle: const TextStyle(
          color: Color(0xFFFF1552),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        descriptionTextStyle: const TextStyle(
          color: Color(0xFF4D4D4D),
          fontSize: 14,
        ),
        headerIconPath: UChatAssetPath.redCircleErrorIcon,
        cancelText: 'Okay'.tr,
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: Colors.white,
        ),
        cancelButtonColor: const Color(0xFF333333),
        showConfirmButton: false,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showPhoneNumberPermissionErrorDialog() async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Unable to change phone number'.tr,
        description:
            'You are unable to change your phone number at this time since you have accessed this device less than 24 hours ago.'
                .tr,
        titleTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        descriptionTextStyle: const TextStyle(
          color: Color(0xFF808080),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        cancelText: 'Understood'.tr,
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: const Color(0xFF666666),
        ),
        cancelButtonColor: const Color(0xFFF2F2F2),
        showConfirmButton: false,
      ),
    );
    return result ?? false;
  }

  static Future<DateTime?> showCalendarDatePicker(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    DateTimePickerLocale locale = DateTimePickerLocale.en_us;
    if (Get.locale?.languageCode == 'th') {
      locale = DateTimePickerLocale.th;
    }

    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      titleText: 'Birthdate selection'.tr,
      firstDate: DateTime.now().subYears(100),
      lastDate: DateTime.now().subYears(5),
      initialDate: initialDate,
      dateFormat: 'dd-MM-yyyy',
      locale: locale,
    );

    if (datePicked == null) return null;

    return datePicked.toLocal();
  }

  static Future<bool> showCountDownOTPDialog({
    required int secondStart,
    void Function()? resend,
    bool onlyPhoneNumberOTP = false,
  }) async {
    bool check = false;
    Timer? dialogTimer;
    final result = await Get.dialog<bool>(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          if (!check) {
            setState(() {
              check = true;
            });
            dialogTimer = Timer.periodic(
              const Duration(seconds: 1),
              (Timer timer) {
                if (secondStart <= 0) {
                  timer.cancel();
                } else {
                  setState(() {
                    secondStart--;
                  });
                }
              },
            );
          }

          return _create(
            showCloseButton: GetPlatform.isDesktop,
            title: 'Please wait'.tr,
            titleTextStyle: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            customDescriptionText: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'You have recently requested an OTP. Please wait '.tr,
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff808080),
                    ),
                children: [
                  TextSpan(
                    text: '@second seconds'.trParams({
                      'second': secondStart.toString(),
                    }),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: UTheme.color.redAccentButton,
                    ),
                  ),
                  TextSpan(
                    text: ' to requested again.'.tr,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff808080),
                    ),
                  ),
                ],
              ),
            ),
            confirmText: null,
            confirmButtonTextStyle: null,
            confirmButtonColor: null,
            cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
              color: Colors.white,
            ),
            cancelButtonColor: (secondStart == 0 && resend != null) ? UTheme.color.primary : const Color(0xFFFF1552),
            showConfirmButton: false,
            cancelText: onlyPhoneNumberOTP
                ? (secondStart == 0 && resend != null)
                    ? 'Resend'.tr
                    : 'Done'.tr
                : (secondStart == 0 && resend != null)
                    ? 'Resend'.tr
                    : 'Got it'.tr,
            onCancel: () {
              if (onlyPhoneNumberOTP) {
                if (secondStart == 0 && resend != null) {
                  resend.call();
                  return;
                } else {
                  return;
                }
              }
              if (secondStart == 0 && resend != null) {
                resend.call();
              } else {
                // Get.back();
              }
            },
          );
        },
      ),
      barrierDismissible: false,
    );

    dialogTimer?.cancel();
    return result ?? false;
  }

  static Future<bool> showImagePreviewDialog(
    AssetEntity assetEntity, {
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isSelected = false,
  }) async {
    final result = await Get.dialog<bool>(
      GestureDetector(
        onTap: () => Get.back(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            color: Colors.grey.shade200.withValues(alpha: 0.4),
            padding: EdgeInsets.symmetric(vertical: 30.spMin, horizontal: 30.spMin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxHeight: 652.spMin),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AssetEntityImage(
                          assetEntity,
                          isOriginal: false,
                          thumbnailSize: const ThumbnailSize.square(1000),
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150.spMin,
                              width: 150.spMin,
                              color: Colors.grey[350],
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      UChatAssetPath.thumbnailDefault,
                                      width: 100.spMin,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (assetEntity.type == AssetType.video)
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: Container(
                          height: 20.spMin,
                          width: 80.spMin,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(7.spMin)),
                          ),
                          child: Center(child: Text('VIDEO'.tr)),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 40.spMin),
                TextButton(
                  key: const ValueKey('confirm'),
                  style: TextButton.styleFrom(
                    backgroundColor: isSelected ? UTheme.color.redAccentButton : UTheme.color.primary,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(vertical: 12.spMin),
                    fixedSize: Size(230.spMin, 50.spMin),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.spMin),
                    ),
                  ),
                  onPressed: () {
                    onConfirm?.call();
                    Get.back<bool>(result: true);
                  },
                  child: Text(
                    isSelected ? 'Unselect'.tr : 'Select'.tr,
                    style: defaultConfirmButtonTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10.spMin),
                TextButton(
                  key: const ValueKey('cancel'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(vertical: 12.spMin),
                    fixedSize: Size(230.spMin, 50.spMin),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.spMin),
                    ),
                  ),
                  onPressed: () {
                    onCancel?.call();
                    Get.back<bool>(result: false);
                  },
                  child: Text(
                    'Close'.tr,
                    style: defaultConfirmButtonTextStyle.copyWith(
                      color: UTheme.color.redAccentButton,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      useSafeArea: false,
    );

    return result ?? false;
  }

  static Future<bool> showPopUpAfterConfirmation({
    required String userDisplayName,
    required String title,
    required String description,
    bool? barrierDismissible,
    Color buttonColor = const Color(0xFF333333),
    String cancelText = 'Okay',
    RouteSettings? routeSettings,
  }) async {
    final result = await Get.dialog<bool>(
      routeSettings: routeSettings,
      _create(
        title: title.tr,
        description: description.trParams({
          'userDisplayName': userDisplayName,
        }),
        titleTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        descriptionTextStyle: const TextStyle(
          color: Color(0xFF808080),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        cancelText: cancelText.tr,
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: Colors.white,
        ),
        cancelButtonColor: buttonColor,
        showConfirmButton: false,
      ),
      barrierDismissible: barrierDismissible ?? true,
    );
    return result ?? false;
  }

  static Future<bool> showInvalidQrDialog({
    String? title,
    String? description,
  }) async {
    final result = await Get.dialog<bool>(
      _create(
        title: title ?? 'Invalid QR code'.tr,
        description: description ?? 'Error occurred Please check your QR Code or try again later'.tr,
        headerIconPath: UChatAssetPath.invalidQrCodeIcon,
        cancelText: 'Okay'.tr,
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: Colors.white,
        ),
        cancelButtonColor: UTheme.color.primary,
        showConfirmButton: false,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showFileTooLargeDialog({
    String? title,
    String? description,
  }) async {
    final result = await Get.dialog<bool>(
      _create(
        title: title ?? 'File is too large'.tr,
        description: description ??
            'The file you\'re sending is too large. Please select a file that is not larger than @size and try again.'
                .trParams({
              'size': FileService.instance.fileSizeStr(UChatConstant.fileSizeLimit),
            }),
        headerIconSize: 80.spMin,
        headerIconPath: UChatAssetPath.fileTooLargeIcon,
        cancelText: 'Okay'.tr,
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: Colors.white,
        ),
        cancelButtonColor: UTheme.color.primary,
        showConfirmButton: false,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showLogoutMasterAccountDialog() async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Logout'.tr,
        titleTextStyle: const TextStyle(
          color: Color(0xFFFF1552),
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        description:
            'This account is the primary account. If you sign out of this account, all other accounts you\'ve added will also be signed out and cannot be recovered.'
                .tr,
        cancelButtonColor: const Color(0xFFF2F2F2),
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: const Color(0xFF808080),
        ),
        confirmText: 'Confirm'.tr,
        confirmButtonColor: const Color(0xFFFF1552),
      ),
    );
    return result ?? false;
  }

  static Future<bool?> showLogoutOtherAccountDialog(String userName) async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Sign out of the @value'.trParams({
          'value': userName,
        }),
        titleTextStyle: const TextStyle(
          color: Color(0xFFFF1552),
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        description: 'How would you like to sign out of this device?'.tr,
        cancelText: 'Sign out of all accounts'.tr,
        cancelButtonColor: const Color(0xFFFFE8ED),
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: const Color(0xFFFF1552),
        ),
        confirmText: 'Sign out of this account only'.tr,
        confirmButtonColor: const Color(0xFFFF1552),
        buttonDirection: Axis.vertical,
      ),
    );
    return result;
  }

  static Future<bool> showLimitAccount() async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'The account has reached its limit'.tr,
        description: 'You cannot add more accounts because you have reached the maximum limit'.tr,
        titleTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        descriptionTextStyle: const TextStyle(
          color: Color(0xFF808080),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        cancelText: 'Okay'.tr,
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: Colors.white,
        ),
        cancelButtonColor: const Color(0xFF333333),
        showConfirmButton: false,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showAlreadyAccount(String accountName) async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'The account already exists'.tr,
        description:
            'You have already added this account. The system will automatically switch to using the @value account'
                .trParams(
          {
            'value': accountName,
          },
        ),
        titleTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        descriptionTextStyle: const TextStyle(
          color: Color(0xFF808080),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        cancelText: 'Okay'.tr,
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: Colors.white,
        ),
        cancelButtonColor: const Color(0xFF333333),
        showConfirmButton: false,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showAccountNotRegister() async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Not registered yet'.tr,
        description: 'You have not registered with such an account yet. Please register before adding the account.'.tr,
        titleTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        descriptionTextStyle: const TextStyle(
          color: Color(0xFF808080),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        cancelText: 'Return to the account center'.tr,
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: Colors.white,
        ),
        cancelButtonColor: const Color(0xFF333333),
        showConfirmButton: false,
      ),
    );
    return result ?? false;
  }

  static Future<bool> showRemoveAccountFromDevice() async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Delete Account'.tr,
        description: 'Do you want to remove this account from the device?'.tr,
        confirmText: 'Confirm'.tr,
        titleTextStyle: const TextStyle(
          color: Color(0xFFFF1552),
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        confirmButtonColor: const Color(0xFFFF1552),
      ),
    );
    return result ?? false;
  }

  static Future<bool> showRemoveEmailDialog() async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Remove an email'.tr,
        description: 'Do you want to remove email ?'.tr,
        cancelButtonColor: const Color(0xFFF2F2F2),
        cancelButtonTextStyle: defaultCancelButtonTextStyle.copyWith(
          color: const Color(0xFF808080),
        ),
        confirmText: 'Okay'.tr,
        confirmButtonColor: const Color(0xFFFF1552),
        confirmButtonTextStyle: const TextStyle(color: Colors.white),
      ),
    );
    return result ?? false;
  }

  static Future<void> showPermissionPermanentlyDeniedWarningDialog() async {
    await UChatDialog.showPopUpAfterConfirmation(
      userDisplayName: '',
      title: 'Request permission',
      description: 'Please authorized the requested permissions in your device settings to ensure full access',
    );
  }

  static Future<bool?> showPermissionDialog({
    required String iconPath,
    required String title,
    required String description,
    required Function onGrantPressed,
  }) async {
    return Get.defaultDialog<bool>(
      title: '',
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.spMin,
        vertical: 8.spMin,
      ),
      content: SizedBox(
        width: 300.spMin,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.spMin),
              child: Image.asset(
                iconPath,
                width: 60.spMin,
                cacheWidth: 60.spMin.cacheSize,
              ),
            ),
            SizedBox(height: 16.spMin),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.spMin),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF1A1A1A),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 12.spMin),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.spMin),
              child: Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF808080),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.spMin),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: UTheme.color.blueCi,
                borderRadius: BorderRadius.circular(8.spMin),
              ),
              child: TextButton(
                onPressed: () {
                  onGrantPressed();
                  Get.back(result: true);
                },
                child: Text(
                  'Continue'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Hide later button for iOS because of AppStore guideline.
            if (!GetPlatform.isIOS) SizedBox(height: 12.spMin),
            if (!GetPlatform.isIOS)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(8.spMin),
                ),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Later'.tr,
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  static void reportBug() {
    ReportController.handleOpenDialog(
      context: Get.context!,
      reportType: ReportType.reportBug,
      callBackOnOpen: true,
    );
  }

  static Future<void> showGotFreeSticker({
    required String stickerPackId,
    String? stickerPackName,
    String? stickerFileId,
    bool showConfirmButton = false,
    bool isSendGift = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? currentContactName,
    String? confirmText,
    String? title,
    String? description,
    bool closeDialogOnConfirm = true,
  }) async {
    try {
      await Get.dialog<bool>(
        _create(
          headerIcon: StickerItemPreview(
            packId: stickerPackId,
            fileId: stickerFileId!,
            width: 100.spMin,
            height: 100.spMin,
          ),
          closeDialogOnConfirm: closeDialogOnConfirm,
          title: title ?? 'Got new sticker'.tr,
          description: description ??
              'Congratulations ! You got a new sticker\n(@stickerName)'.trParams(
                {
                  'stickerName': stickerPackName ?? 'Unknown'.tr,
                },
              ),
          cancelText: isSendGift ? 'Cancel'.tr : 'Okay'.tr,
          onCancel: onCancel,
          cancelButtonColor: isSendGift ? const Color(0xFFF2F2F2) : const Color(0xFFF0F6FF),
          cancelButtonTextStyle: isSendGift
              ? const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w600,
                )
              : TextStyle(
                  fontSize: 16,
                  color: blueDialogButtonColor,
                  fontWeight: FontWeight.w600,
                ),
          showConfirmButton: isSendGift ? true : false,
          confirmText: 'Send gift'.tr,
          onConfirm: onConfirm,
        ),
      );
    } catch (e, stackTrace) {
      _log.e('Call showGotFreeSticker error.', e, stackTrace);
    }
  }

  static Future<bool?> showBuySticker({
    required StoreStickerPackEntity stickerPack,
    required double coins,
  }) async {
    try {
      return await Get.dialog<bool>(
        _create(
          headerIcon: StickerItemPreview(
            packId: stickerPack.id,
            fileId: stickerPack.coverId,
            width: 100.spMin,
            height: 100.spMin,
          ),
          title: 'Buy "@stickerName"'.trParams({
            'stickerName': stickerPack.name,
          }),
          description: 'Confirm purchase of this sticker for @stickerPrice coins?\n(My coins: @coins)'.trParams({
            'stickerPrice': (stickerPack.price).toNumberFormat(),
            'coins': coins.toNumberFormat(),
          }),
        ),
      );
    } catch (e, stackTrace) {
      _log.e('Call showGotFreeSticker error.', e, stackTrace);
      return false;
    }
  }

  static Future<bool?> showNotEnoughCoinAlert() async {
    try {
      return await Get.dialog<bool>(
        _create(
          headerIconPath: UChatAssetPath.notEnoughCoin,
          title: 'Not enough coins'.tr,
          description: UserController.instance.enableCoin
              ? 'Unable to purchase this sticker due to insufficient coin balance.\nDo you want to purchase coins first?'
                  .tr
              : 'Unable to purchase this sticker due to insufficient coin balance. \ncoin purchase doesn\'t available please contact UChat Admin'
                  .tr,
          confirmButtonColor: yellowDialogButtonColor,
          confirmText: UserController.instance.enableCoin ? 'Buy coins'.tr : 'Okay'.tr,
          onConfirm: UserController.instance.enableCoin
              ? () {
                  Get.back();
                  InAppPurchaseController.instance.jumpToCoinStore();
                }
              : () {
                  Get.back();
                },
          closeDialogOnConfirm: false,
        ),
      );
    } catch (e, stackTrace) {
      _log.e('Call showGotFreeSticker error.', e, stackTrace);
      return false;
    }
  }

  static Future<bool?> showEmailOrPasswordNotSetDialog(String text) async {
    final dateTime = await ConfigDb.instance.authenticated.getDateTime(
      key: ConfigDb.getEmailPasswordNotSetDialogDateTimeConfigKey(),
    );
    if (dateTime?.isToday == true) return false;

    return await Get.dialog<bool>(
      _create(
        title: 'Account setting'.tr,
        description: 'For your account security, Please set your @text in settings > account'.trParams({
          'text': text,
        }),
        confirmText: 'Go to setting'.tr,
        cancelText: 'Later'.tr,
        closeDialogOnConfirm: false,
        onConfirm: () async {
          Get.back();
          final user = UserController.instance.currentUser();
          if (user != null) {
            await Get.toNamed(Routes.accountSetting, arguments: AccountSettingArguments(user: user));
          }
        },
        onCancel: () async {
          await ConfigDb.instance.authenticated.saveConfig(
            key: ConfigDb.getEmailPasswordNotSetDialogDateTimeConfigKey(),
            value: DateTime.now(),
          );
        },
      ),
      barrierDismissible: false,
    );
  }

  static Future<bool> showDeleteStickerConfirmDialog({
    String? title,
    String? description,
  }) async {
    final result = await Get.dialog<bool>(
      _create(
        title: 'Delete Sticker'.tr,
        description:
            'A sticker deleted will be moved to sticker list in setting. you can download the sticker in there anytime.'
                .tr,
        confirmButtonColor: const Color(0xFFFF1552),
      ),
    );
    return result ?? false;
  }

  /// Display 2 button (cancel and confirm) dialog for secret chat.
  static Future<bool> showSecretChatConfirmDialog({
    required String title,
    String? description,
    String? confirmText,
    String? cancelText,
    Color? backgroundColor,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    Color? closeIconBgColor,
    Color? closeIconColor,
    bool? showCloseButton,
    TextStyle? titleTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? confirmButtonTextStyle,
    TextStyle? cancelButtonTextStyle,
  }) async {
    final result = await UChatDialog.showDialog(
      title: title,
      description: description ?? '',
      confirmText: confirmText ?? 'Confirm'.tr,
      cancelText: cancelText,
      backgroundColor: backgroundColor ?? veryDarkBlueDialogButtonColor,
      confirmButtonColor: confirmButtonColor ?? redDialogButtonColor,
      cancelButtonColor: cancelButtonColor ?? darkBlueDialogButtonColor,
      closeIconBgColor: closeIconBgColor ?? darkBlueDialogButtonColor,
      closeIconColor: closeIconColor ?? const Color(0xFF77ACE5),
      showCloseButton: showCloseButton ?? true,
      titleTextStyle: titleTextStyle ??
          const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
      descriptionTextStyle: descriptionTextStyle ??
          const TextStyle(
            color: Color(0xFFCCCCCC),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
      confirmButtonTextStyle: confirmButtonTextStyle ??
          const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
      cancelButtonTextStyle: cancelButtonTextStyle ??
          const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
    );

    return result;
  }

  static Future<bool> showConfirmDialog({
    String? title,
    String? description,
    String? confirmText,
    Color confirmButtonColor = redDialogButtonColor,
    String? cancelText,
    Color cancelButtonColor = const Color(0xFFE6E6E6),
    bool showCloseButton = true,
  }) async {
    final result = await Get.dialog<bool>(
      _create(
        title: title ?? 'Confirm'.tr,
        description: description ?? 'Are you sure you want to do this?'.tr,
        confirmText: confirmText ?? 'Confirm'.tr,
        confirmButtonColor: confirmButtonColor,
        cancelText: cancelText ?? 'Cancel'.tr,
        cancelButtonColor: cancelButtonColor,
        showCloseButton: showCloseButton,
      ),
    );
    return result ?? false;
  }

  static Widget _create({
    Widget? headerIcon,
    String? headerIconPath,
    double headerIconSize = 62,
    EdgeInsets headerIconPadding = const EdgeInsets.only(top: 14, bottom: 28),
    String title = '',
    TextStyle? titleTextStyle,
    double? descriptionTopPadding,
    Widget? customDescription,
    String description = '',
    TextStyle? descriptionTextStyle,
    String? confirmText,
    TextStyle? confirmButtonTextStyle,
    Color? confirmButtonColor,
    String? cancelText,
    TextStyle? cancelButtonTextStyle,
    Color? cancelButtonColor,
    bool showCloseButton = false,
    bool showConfirmButton = true,
    bool showCancelButton = true,
    bool closeDialogOnConfirm = true,
    bool closeDialogOnCancel = true,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Widget? bottomContent,
    Widget? customDescriptionText,
    UChatDialogChild? child,
    bool isPage = false,
    double? cDialogWidth,
    double? cDialogHeight,
    EdgeInsets? cDialogPadding,
    Widget? customCenterContent,
    Color? backgroundColor,
    Color? closeIconBgColor,
    Color? closeIconColor,
    bool? showBackButton,
    bool? disableBoxConstraints,
    void Function()? functionBackButton,
    Axis buttonDirection = Axis.horizontal,
    String? imagePreview,
  }) {
    bool isMobile = UChatScreenUtil.instance.isMobile;

    final UChatDialogChild? childInUse;
    if (child != null) {
      childInUse = child;
    } else {
      final cancelButton = TextButton(
        key: const ValueKey('cancel'),
        style: TextButton.styleFrom(
          backgroundColor: cancelButtonColor ?? const Color(0xFFF2F2F2),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.symmetric(vertical: 12.spMin),
          fixedSize: Size.fromHeight(50.spMin),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          onCancel?.call();
          if (closeDialogOnCancel) {
            Get.back<bool>(result: false);
          }
        },
        child: Text(
          cancelText ?? 'Cancel'.tr,
          style: cancelButtonTextStyle ?? defaultCancelButtonTextStyle,
        ),
      );

      final confirmButton = TextButton(
        key: const ValueKey('confirm'),
        style: TextButton.styleFrom(
          backgroundColor: confirmButtonColor ?? UTheme.color.primary,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.symmetric(vertical: 12.spMin),
          fixedSize: Size.fromHeight(50.spMin),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          onConfirm?.call();
          if (closeDialogOnConfirm) {
            Get.back<bool>(result: true);
          }
        },
        child: Text(
          confirmText ?? 'Confirm'.tr,
          style: confirmButtonTextStyle ?? defaultConfirmButtonTextStyle,
        ),
      );
      childInUse = (_) => SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22.spMin,
                        vertical: 22.spMin,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (headerIconPath != null)
                            Padding(
                              padding: headerIconPadding,
                              child: SizedBox(
                                width: headerIconSize.spMin,
                                child: Image.asset(
                                  headerIconPath,
                                  cacheWidth: 70.cacheSize,
                                ),
                              ),
                            ),
                          if (headerIcon != null) headerIcon,
                          if (headerIconPath == null) SizedBox(height: 18.spMin),
                          if (imagePreview != null)
                            Image.asset(
                              imagePreview,
                              width: 84.spMin,
                              height: 84.spMin,
                            ),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: titleTextStyle ??
                                UTheme.textTheme.appBarTitle.copyWith(
                                  color: const Color(0xFF333333),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          if (customDescription != null) ...[
                            SizedBox(
                              height: descriptionTopPadding ?? 9.spMin,
                            ),
                            customDescription
                          ],
                          if (description.isNotEmpty) ...[
                            SizedBox(
                              height: descriptionTopPadding ?? 9.spMin,
                            ),
                            Text(
                              description,
                              textAlign: TextAlign.center,
                              style: descriptionTextStyle ?? defaultDescriptionTextStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            )
                          ],
                          if (customDescriptionText != null) ...[
                            SizedBox(height: 9.spMin),
                            customDescriptionText,
                          ],
                          SizedBox(
                            height: showCancelButton ? 30.spMin : 0,
                          ),
                          if (customCenterContent != null)
                            Flexible(
                              child: SingleChildScrollView(
                                child: customCenterContent,
                              ),
                            ),
                          if (buttonDirection == Axis.horizontal)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: showCancelButton ? cancelButton : const SizedBox.shrink(),
                                ),
                                if (showConfirmButton) ...[
                                  SizedBox(width: 10..spMin),
                                  Expanded(
                                    child: confirmButton,
                                  ),
                                ]
                              ],
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                confirmButton,
                                if (showConfirmButton) ...[
                                  SizedBox(height: 10.spMin),
                                  cancelButton,
                                ]
                              ],
                            ),
                          if (bottomContent != null) ...[
                            SizedBox(
                              height: 20.spMin,
                            ),
                            bottomContent,
                          ],
                        ],
                      ),
                    ),
                    if (showCloseButton)
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 13.spMin,
                            vertical: 12.spMin,
                          ),
                          child: CircleCloseButton(
                            closeIconColor: closeIconColor,
                            closeIconBackgroundColor: closeIconBgColor,
                          ),
                        ),
                      ),
                    if (showBackButton != null && showBackButton == true)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 12,
                          ),
                          child: InkWell(
                            child: Container(
                              width: 25.wr,
                              height: 25.wr,
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: UTheme.color.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/v2/back_icon.png',
                                width: 20.spMin,
                                height: 20.spMin,
                              ),
                            ),
                            onTap: () {
                              if (functionBackButton != null) {
                                functionBackButton();
                              }
                              // Get.back<bool>(result: false);
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
    }

    if (isMobile) {
      return Dialog(
        backgroundColor: backgroundColor,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(
          horizontal: 45.spMin,
          vertical: 24.spMin,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.spMin),
        ),
        child: childInUse(null),
      );
    } else {
      // Dialog width for desktop that is a page dialog
      double dialogWidth = cDialogWidth ?? 410.spMin;
      double dialogHeight = cDialogHeight ?? 596.spMin;

      final padding = cDialogPadding ??
          EdgeInsets.symmetric(
            horizontal: 45.spMin,
            vertical: 24.spMin,
          );

      if (isPage == false) {
        // Dialog width for desktop that is not a page dialog
        dialogWidth = 410.spMin * .8;
      }
      bool isFullScreen = false;
      return StatefulBuilder(builder: (context, setState) {
        return Dialog(
          backgroundColor: backgroundColor,
          elevation: 0,
          insetPadding: isFullScreen ? EdgeInsets.zero : padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isFullScreen ? 0 : 30.r),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: ClipRRect(
              borderRadius: isFullScreen ? BorderRadius.zero : BorderRadius.circular(20.r),
              child: disableBoxConstraints == true
                  ? childInUse!(() {
                      setState(() {
                        isFullScreen = !isFullScreen;
                      });
                      return isFullScreen;
                    })
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: dialogWidth,
                        maxHeight: dialogHeight,
                      ),
                      child: childInUse!(() {
                        setState(() {
                          isFullScreen = !isFullScreen;
                        });
                        return isFullScreen;
                      }),
                    ),
            ),
          ),
        );
      });
    }
  }

  static Future<void> showDownloadStickerFailed() {
    return UChatDialog.showAlertDialog(
      title: 'Warning!'.tr,
      description: 'The sticker that you want to download no longer available now'.tr,
      buttonText: 'Close'.tr,
    );
  }

  static Future<void> showActionTokenExpireDialog() {
    return UChatDialog.showAlertDialog(
      title: 'Failed to connect to system.'.tr,
      description: '(Please try again)'.tr,
      buttonText: 'OK'.tr,
    );
  }

  static Future<bool> showDialogQRCodeError() async {
    return await UChatDialog.showAlertDialog(
        title: 'Invalid QR code'.tr,
        description: 'An error has occurred.\nPlease check the QR code and try again.'.tr,
        buttonText: 'Got it'.tr,
        closeDialogOnConfirm: true,
        barrierDismissible: false,
        onPressed: () {},
        descriptionTextStyle: UChatDialog.defaultDescriptionTextStyle.copyWith(
          fontSize: 12.spMin,
        ),
        buttonTextStyle: UChatDialog.defaultCancelButtonTextStyle.copyWith(
          fontSize: 10.spMin,
          color: Colors.white,
        ),
        imagePreview: 'assets/images/qr_expire.png');
  }

  static Future<bool> showDialogQRCodeExpire({void Function()? onPressed}) async {
    return await UChatDialog.showAlertDialog(
        title: 'QR code has expired'.tr,
        description: 'An error has occurred.\nPlease check the QR code and try again.'.tr,
        buttonText: 'Got it'.tr,
        closeDialogOnConfirm: true,
        barrierDismissible: false,
        onPressed: onPressed,
        descriptionTextStyle: UChatDialog.defaultDescriptionTextStyle.copyWith(
          fontSize: 12,
        ),
        buttonTextStyle: UChatDialog.defaultCancelButtonTextStyle.copyWith(
          fontSize: 15,
          color: Colors.white,
        ),
        imagePreview: 'assets/images/qr_expire.png');
  }

  static Future showDialogVerifyPin(String value) async {
    return await UChatDialog.showCustomDialog(
        child: (_) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 12, right: 12),
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          size: 30,
                          Icons.cancel,
                          color: Color(0xffCCCCCC),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 50.spMin, right: 50.spMin),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'PC check'.tr,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xff333333)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.spMin, bottom: 8.spMin),
                        child: Text(
                          textAlign: TextAlign.center,
                          'To ensure the security of your account,\nplease verify your identity when logging in\nfrom a new device.'
                              .tr,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff808080)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 24.spMin),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Enter the code below into your mobile phone.'.tr,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff0057FF)),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        value,
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xff0057FF)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(22.spMin),
                  width: Get.width,
                  height: 90.spMin,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0xFFF2F2F2),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      'Cancel'.tr,
                      style: const TextStyle(
                        color: Color(0xFFB3B3B3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        bgDialogColor: Colors.white);
  }

  static Future showFileInfoDialog({required FileInfoList fileInfoList}) async {
    return UChatDialog.showCustomDialog(
      child: (_) => FileInfoDialog(
        fileInfoList: fileInfoList,
      ),
    );
  }

  // Premium dialog
  static Future<void> showBlockCrossPlatformProcess() {
    return UChatDialog.showExceptionDialog(
      title: 'Unable to process your request'.tr,
      description: '',
      customDescriptionText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'You have already subscribed to premium package on the '.tr,
          style: TextStyle(
            fontSize: 12.spMin,
            fontWeight: FontWeight.w400,
            color: const Color(0xff808080),
          ),
          children: [
            TextSpan(
              text: UserController.instance.isSubscribeGoogle ? 'Google Play.'.tr : 'App Store.'.tr,
              style: TextStyle(
                fontSize: 12.spMin,
                fontWeight: FontWeight.w600,
                color: const Color(0xff808080),
              ),
            ),
            TextSpan(
              text: ' Please check your subscription and try again'.tr,
              style: TextStyle(
                fontSize: 12.spMin,
                fontWeight: FontWeight.w400,
                color: const Color(0xff808080),
              ),
            ),
          ],
        ),
      ),
      showReportBugWidget: true,
    );
  }

  static Future<void> showUnknownProcessRequest() {
    return UChatDialog.showExceptionDialog(
      title: 'Unable to process your request'.tr,
      description: '',
      customDescriptionText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: ' Please check your subscription and try again'.tr,
          style: TextStyle(
            fontSize: 12.spMin,
            fontWeight: FontWeight.w400,
            color: const Color(0xff808080),
          ),
        ),
      ),
      showReportBugWidget: true,
    );
  }

  static Future<void> showDialogPinLimit() {
    bool isPremiumStoreEnable = UserController.instance.enablePremiumStore;

    return UChatDialog.showDialog(
      title: 'Pin Attempt Limit'.tr,
      titleTextStyle: TextStyle(
        fontSize: 18.spMin,
        fontWeight: FontWeight.w600,
      ),
      description: isPremiumStoreEnable
          ? 'You\'ve reached the Pin attempt limit. If you need more Pin attempts, please upgrade your plan.'.tr
          : 'You\'ve reached the Pin attempt limit. Upgrading your plan for more attempts will be available soon'.tr,
      descriptionTextStyle: TextStyle(
        color: const Color(0xFF808080),
        fontSize: 12.spMin,
        fontWeight: FontWeight.w400,
      ),
      showCloseButton: true,
      showConfirmButton: false,
      cancelText: isPremiumStoreEnable ? 'Upgrade plan'.tr : 'Got it'.tr,
      cancelButtonColor: UTheme.color.primary,
      cancelButtonTextStyle: TextStyle(
        color: UTheme.color.onPrimary,
        fontSize: 16.spMin,
        fontWeight: FontWeight.w600,
      ),
      barrierDismissible: true,
      onCancel: () async {
        Get.back();
        if (isPremiumStoreEnable != true) {
          return;
        }
        await Future.delayed(const Duration(milliseconds: 100));

        PremiumPackageCompareController? premiumPackageCompareController;
        if (!Get.isRegistered<PremiumPackageCompareController>()) {
          premiumPackageCompareController = Get.put(PremiumPackageCompareController());
        } else {
          premiumPackageCompareController = Get.find<PremiumPackageCompareController>();
        }

        final id = UserController.instance.currentUser()?.premiumPackage?.premiumPackageId;

        if (id != null) {
          premiumPackageCompareController?.handleOpenPremiumPackageDetailScreenFromDialog(id);
        }
      },
    );
  }

  static Future<bool> showDialogSendReasonSuccess() async {
    return await UChatDialog.showAlertDialog(
      title: 'Received your message '.tr,
      description:
          'We need to consider the reasons for violating the Terms and condition and will contact you later.'.tr,
      buttonText: 'Got it'.tr,
      closeDialogOnConfirm: true,
      barrierDismissible: false,
      onPressed: () {},
      descriptionTextStyle: UChatDialog.defaultDescriptionTextStyle.copyWith(
        fontSize: 12,
      ),
      buttonTextStyle: UChatDialog.defaultCancelButtonTextStyle.copyWith(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  static Future<bool> showUpgradePremiumDialog() async {
    return await UChatDialog.showDialog(
      title: 'Upgrade to create more'.tr,
      titleTextStyle: TextStyle(
        fontSize: 18.spMin,
        fontWeight: FontWeight.w600,
      ),
      description:
          'Your attempt limit has been reached. To continue using this please retry or upgrade your subscription to get more benefits from us!'
              .tr,
      descriptionTextStyle: TextStyle(
        color: const Color(0xFF808080),
        fontSize: 12.spMin,
        fontWeight: FontWeight.w400,
      ),
      showCloseButton: true,
      showConfirmButton: UserController.instance.enablePremiumStore,
      cancelText: 'Understood'.tr,
      cancelButtonColor: const Color(0xffF2F2F2),
      cancelButtonTextStyle: TextStyle(
        color: const Color(0xff808080),
        fontSize: 16.spMin,
        fontWeight: FontWeight.w600,
      ),
      confirmText: 'Upgrade plan'.tr,
      confirmButtonColor: UTheme.color.primary,
      confirmButtonTextStyle: TextStyle(
        color: UTheme.color.onPrimary,
        fontSize: 16.spMin,
        fontWeight: FontWeight.w600,
      ),
      barrierDismissible: true,
      onConfirm: () async {
        Get.back();
        await Future.delayed(const Duration(milliseconds: 200));
        // TODO (desktop premium store) Add go to premium store desktop version here.
        Get.toNamed(Routes.settingPremiumPacksStore);
      },
    );
  }
}
