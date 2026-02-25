import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/dimensions.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

@Deprecated('Use UChatDialog instead')
Future<void> showAlertDialog(
  String message, {
  String? title,
  String? buttonText,
  Color? titleColor,
  Color? messageColor,
  Color? buttonTextColor,
  Color? buttonBgColor,
  EdgeInsets? contentPadding,
  double? titleFontSize,
  double? messageFontSize,
  double? buttonFontSize,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool closeDialogOnConfirm = true,
  Widget? descriptionWidget,
}) async {
  await Get.defaultDialog(
    title: title ?? 'Alert'.tr,
    titleStyle: TextStyle(
      color: titleColor ?? Colors.black,
      fontSize: titleFontSize ?? 18,
    ),
    titlePadding: const EdgeInsets.only(top: 32, bottom: 8),
    content: Column(
      children: [
        /// Dialog message
        Padding(
          padding: contentPadding ?? const EdgeInsets.only(bottom: 20),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: messageColor ?? const Color(0xFF808080),
              fontSize: messageFontSize ?? 12,
            ),
          ),
        ),
        descriptionWidget ?? const SizedBox(),
        const SizedBox(height: 12),

        /// Button rows
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                key: const ValueKey('confirm'),
                style: TextButton.styleFrom(
                  backgroundColor: buttonBgColor ?? UTheme.color.primary,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
                  buttonText ?? 'Ok'.tr,
                  style: TextStyle(
                    color: buttonTextColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: buttonFontSize ?? 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    barrierDismissible: false,
    contentPadding: const EdgeInsets.only(
      left: 16,
      right: 16,
      top: 10,
      bottom: 8,
    ),
  );
}

Future<bool> showConfirmWidgetDialog(
  Widget child, {
  String? title,
  String? subTitle,
  String? textCancel,
  String? textConfirm,
  Color? confirmBgColor,
  Color? confirmTextColor,
  Color? cancelBgColor,
  Color? cancelTextColor,
  Color? titleColor,
  Color? subTitleColor,
  EdgeInsets? contentPadding,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  double? titleFontSize,
  double? subTitleFontSize,
  double? buttonFontSize,
  bool closeDialogOnConfirm = true,
  bool barrierDismissible = true,
}) async {
  return await Get.defaultDialog(
    title: '',
    content: Column(
      children: [
        /// Dialog message
        Padding(
          padding: contentPadding ?? const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              child,
              SizedBox(height: 25.hr),
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: titleColor ?? const Color(0xFF333333),
                  fontSize: titleFontSize ?? 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.hr),
              Text(
                subTitle ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: subTitleColor ?? const Color(0xFF808080),
                  fontSize: subTitleFontSize ?? 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        /// Button rows
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                key: const ValueKey('cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: cancelBgColor ?? const Color(0xFFF2F2F2),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  onCancel?.call();
                  Get.back<bool>(result: false);
                },
                child: Text(
                  textCancel ?? 'Cancel'.tr,
                  style: TextStyle(
                    color: cancelTextColor ?? const Color(0xFF808080),
                    fontWeight: FontWeight.w600,
                    fontSize: buttonFontSize ?? 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextButton(
                key: const ValueKey('confirm'),
                style: TextButton.styleFrom(
                  backgroundColor: confirmBgColor ?? UTheme.color.primary,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
                  textConfirm ?? 'Confirm'.tr,
                  style: TextStyle(
                    color: confirmTextColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: buttonFontSize ?? 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    barrierDismissible: barrierDismissible,
    contentPadding: contentPadding ??
        const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: 8,
        ),
  );
}

@Deprecated('Use UChatDialog instead')
Future<bool> showConfirmDialog(
  String message, {
  String? title,
  String? textCancel,
  String? textConfirm,
  Color? confirmBgColor,
  Color? confirmTextColor,
  Color? cancelBgColor,
  Color? cancelTextColor,
  Color? titleColor,
  Color? messageColor,
  EdgeInsets? contentPadding,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  double? titleFontSize,
  double? messageFontSize,
  double? buttonFontSize,
  bool closeDialogOnConfirm = true,
  bool barrierDismissible = true,
}) async {
  return await Get.defaultDialog(
    title: title ?? 'Confirmation?'.tr,
    titleStyle: UTheme.textTheme.appBarTitle.copyWith(
      color: titleColor ?? Colors.black,
      fontSize: titleFontSize ?? 18,
    ),
    titlePadding: const EdgeInsets.only(top: 32, bottom: 8),
    content: Column(
      children: [
        /// Dialog message
        Padding(
          padding: contentPadding ?? const EdgeInsets.only(bottom: 20),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: messageColor ?? const Color(0xFF808080),
              fontSize: messageFontSize ?? 12,
            ),
          ),
        ),
        const SizedBox(height: 12),

        /// Button rows
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                key: const ValueKey('cancel'),
                style: TextButton.styleFrom(
                  backgroundColor: cancelBgColor ?? const Color(0xFFF2F2F2),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  onCancel?.call();
                  Get.back<bool>(result: false);
                },
                child: Text(
                  textCancel ?? 'Cancel'.tr,
                  style: TextStyle(
                    color: cancelTextColor ?? const Color(0xFF808080),
                    fontWeight: FontWeight.w600,
                    fontSize: buttonFontSize ?? 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextButton(
                key: const ValueKey('confirm'),
                style: TextButton.styleFrom(
                  backgroundColor: confirmBgColor ?? UTheme.color.primary,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
                  textConfirm ?? 'Confirm'.tr,
                  style: TextStyle(
                    color: confirmTextColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: buttonFontSize ?? 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    barrierDismissible: barrierDismissible,
    contentPadding: contentPadding ??
        const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: 8,
        ),
  );
}

@Deprecated('Use UChatDialog instead')
Future<void> showInfoDialog(
  String message, {
  String? title,
  VoidCallback? onConfirm,
}) async {
  await Get.defaultDialog(
    title: title ?? 'Information'.tr,
    titleStyle: TextStyle(color: UTheme.color.info),
    titlePadding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
    middleText: message,
    barrierDismissible: false,
    confirm: TextButton(
      key: const ValueKey('confirm'),
      style: TextButton.styleFrom(
        backgroundColor: UTheme.color.primary,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        onConfirm?.call();
        Get.back<bool>(result: true);
      },
      child: Text(
        'OK'.tr,
        style: UTheme.textTheme.messageTitle.apply(color: UTheme.color.onPrimary),
      ),
    ),
    onConfirm: onConfirm ??
        () {
          Get.back();
        },
    contentPadding: const EdgeInsets.only(
      left: 15.0,
      right: 15.0,
      bottom: 15.0,
    ),
  );
}

Future<void> showFileOptionsDialog(String path, MessageFileModel file) async {
  await UChatDialog.showDialog(
    title: 'Can\'t open file'.tr,
    description: 'This file extension is not supported. You can share this file or download it to your device'.tr,
    cancelText: 'Download'.tr,
    confirmText: 'Share'.tr,
    onConfirm: () {
      GetIt.I<SharingService>().shareToOtherApp(files: [XFile(path, name: file.name)]);
    },
    onCancel: () {
      _downloadFile(file);
    },
    showCloseButton: true,
  );
}

Future<void> _downloadFile(MessageFileModel file) async {
  final bool hasPermission = await PermissionController.instance.requestPermission(Permission.storage);

  if (!hasPermission) {
    UChatDialog.showExceptionDialog(
      description: 'Cannot access storage, because permission is denied.'.tr,
      showReportBugWidget: false,
    );
    return;
  }

  if (file.url == null) {
    UChatNewDialog.showGeneralErrorDialog(
      context: Get.context!,
    );
    return;
  }

  final directory = await getExternalStorageDirectory();
  final savePath = '${directory!.path}/${file.name}';

  try {
    final Dio dio = Dio();
    await dio.download(file.url!, savePath);

    // TODO update ui to use UChatLoading
    UChatDialog.showDialog(description: 'File has been saved to $savePath.', title: 'Download Complete');
  } catch (e) {
    UChatDialog.showDialog(description: 'Failed to download the file. Please try again.', title: 'Download Error');
  }
}

// TODO refactor to use request permission function from PermissionController
// @Deprecated('Use request permission function from PermissionController instead')
// Future<bool> _requestStoragePermission() async {
//   PermissionStatus status = await Permission.storage.status;
//   if (!status.isGranted) {
//     status = await Permission.storage.request();
//   }
//   return status.isGranted;
// }
