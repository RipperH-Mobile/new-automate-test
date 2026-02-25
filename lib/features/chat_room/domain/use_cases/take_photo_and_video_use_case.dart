import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/core/domain/services/meta_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/camera/app_take_photo_and_video.dart';

class TakePhotoAndVideoUseCase extends SimpleUseCase<FileInfoModel?, String> {
  TakePhotoAndVideoUseCase();

  @override
  Future<FileInfoModel?> call(String roomId) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        eventBus.fire(PasscodePreventEvent(preventActivate: true));
      });

      if (!await PermissionController.instance.checkCameraPermission() ||
          !await PermissionController.instance.checkMicrophonePermission()) {
        return null;
      }

      final device = GetIt.I<MetaService>().deviceName;
      File? file;
      if (device?.toLowerCase().contains('iphone18') == true) {
        file = await AppTakePhotoAndVideo.showOldCameraVersion(
          untilPredicate: (route) => route.settings.name == Routes.chatRoomDirect.replaceAll(':id', roomId),
        );
      } else {
        file = await AppTakePhotoAndVideo.show(
          untilPredicate: (route) => route.settings.name == Routes.chatRoomDirect.replaceAll(':id', roomId),
        );
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        eventBus.fire(PasscodeTimerCancelEvent());
      });

      if (file != null) {
        return await FileInfoModel.fromFile(file, 0);
      }
      return null;
    } on PlatformException catch (e, stackTrace) {
      if (e.code == 'camera_access_denied') {
        UChatDialog.showExceptionDialog(
          description: 'Cannot access camera, because permission is denied.'.tr,
          showReportBugWidget: false,
        );
      } else {
        useLogger().e('PlatformException TakePhotoAndVideoUseCase error :', e, stackTrace);
      }
      return null;
    } catch (e, stackTrace) {
      useLogger().e('TakePhotoAndVideoUseCase error :', e, stackTrace);
      return null;
    }
  }
}
