import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/utils/dimensions.dart';

class MediaGalleryManageSetting extends StatelessWidget {
  final void Function()? onSelectMorePhotos;
  final void Function()? onChangeSetting;

  const MediaGalleryManageSetting({
    super.key,
    this.onSelectMorePhotos,
    this.onChangeSetting,
  });

  @override
  Widget build(BuildContext context) {
    return _buildManageSetting(context);
  }

  Widget _buildManageSetting(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.wr,
        vertical: 15.hr,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Limited access to photos'.tr,
            style: context.theme.appTexts.body1Bold,
          ),
          SizedBox(height: 5.hr),
          Padding(
            padding: EdgeInsets.only(right: 86.wr),
            child: Text(
              'If you need to access more photos, you can do it by change the access setting.'.tr,
              style: context.theme.appTexts.caption2Bold,
            ),
          ),
          SizedBox(height: 5.hr),
          IntrinsicWidth(
            child: buildButton(
              context,
              title: 'Manage'.tr,
              onTap: () => _showActionSheetButton(context),
              textColor: context.theme.appColors.textSuccessInverse,
              buttonColor: context.theme.appColors.buttonPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(
    BuildContext context, {
    String? title,
    Color? textColor,
    Color? buttonColor,
    Function()? onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap ?? () {},
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all<Color>(
          buttonColor ?? Colors.white,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.hr),
            ),
          ),
        ),
      ),
      child: Center(
        child: Text(
          title ?? '',
          style: context.theme.appTexts.caption1Bold.copyWith(
            color: textColor ?? context.theme.appColors.textPrimary,
          ),
        ),
      ),
    );
  }

  void _showActionSheetButton(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext _) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () => onSelectMorePhotos?.call(),
            child: Text(
              'Select more photos...'.tr,
              style: context.theme.appTexts.body2Bold.copyWith(
                color: context.theme.appColors.textPrimary,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => onChangeSetting?.call(),
            child: Text(
              'Change setting'.tr,
              style: context.theme.appTexts.body2Bold.copyWith(
                color: context.theme.appColors.textPrimary,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Get.back(),
          child: Text(
            'Cancel'.tr,
            style: context.theme.appTexts.body2Bold.copyWith(color: context.theme.appColors.textError),
          ),
        ),
      ),
    );
  }
}
