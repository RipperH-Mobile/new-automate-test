import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:uchat/core/event_bus/event_bus.dart';

import 'package:uchat/widgets/camera/app_take_photo_and_video.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets.dart';

class TakePhotoUseCase extends SimpleUseCase<File?, bool Function(Route<dynamic>)> {
  TakePhotoUseCase();

  @override
  Future<File?> call(bool Function(Route<dynamic>) untilPredicate) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        eventBus.fire(PasscodePreventEvent(preventActivate: true));
      });

      final file = await AppTakePhotoAndVideo.show(
        untilPredicate: untilPredicate,
        isHideVideo: true,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        eventBus.fire(PasscodeTimerCancelEvent());
      });

      return file;
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied') {
        UChatDialog.showExceptionDialog(
          description: 'Cannot access camera, because permission is denied.'.tr,
          showReportBugWidget: false,
        );
      }
    }
    return null;
  }
}
