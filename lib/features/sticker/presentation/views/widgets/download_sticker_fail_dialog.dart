import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/util.dart';

class DownloadStickerFailDialog extends StatelessWidget {
  const DownloadStickerFailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text('Can\'t download stickers'.tr),
        content: Text('Please try again later'.tr),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Close'.tr,
              style: TextStyle(color: UTheme.color.primary),
            ),
          ),
        ],
      );
    } else {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Can\'t download stickers'.tr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please try again later.'.tr),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(bottom: 16),
        actions: [
          Container(
            width: 90,
            decoration: BoxDecoration(
              color: UTheme.color.primary,
              borderRadius: BorderRadius.circular(20.5),
            ),
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Close'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }
  }
}
