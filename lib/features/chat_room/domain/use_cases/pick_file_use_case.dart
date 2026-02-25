import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/no_permission_exception.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class PickFileUseCase extends UseCase<dynamic, NoParams> {
  @override
  Future<Either<Exception, FileInfoModel>> call(NoParams params) async {
    if (UChatScreenUtil.instance.isMobile) {
      bool granted = await PermissionController.instance.checkGalleryPermission();
      if (!granted) {
        UChatDialog.showPermissionPermanentlyDeniedWarningDialog();
        final permission = await PermissionController.instance.getGalleryPermission();
        return Left(NoPermissionException(permissionState: permission));
      }
      eventBus.fire(PasscodePreventEvent(preventActivate: true));
    }

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result == null) return Left(NullResponseException());
      String? path = result.files.first.path;

      if (path == null) return Left(NullResponseException());

      final fileInfo = await FileInfoModel.fromFile(File(path), 0);
      final fileSize = await fileInfo.size;
      if (fileSize > UChatConstant.fileSizeLimit) {
        UChatNewDialog.showFileTooLargeDialog(context: Get.context!);
        return Left(Exception('File too large'));
      }

      return Right(fileInfo);
    } on PlatformException catch (e, stackTrace) {
      if (e.code.contains('unknown_path') == true) {
        // This error happens on some Android device and some files. When user try to select file from Google drive.
        _log.e('handleSelectFile PlatformException unknown_path error.', e, stackTrace);
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'Unable to open File'.tr,
          description:
              'This file type is not supported. Check the supported format or try opening it with another app'.tr,
          confirmText: 'Got it'.tr,
          confirmTextColor: Get.context!.theme.appColors.textPrimary,
        );
        return Left(Exception('Unknown path'));
      }
      _log.e('PickFileUseCase PlatformException.', e, stackTrace);
      return Left(e);
    } catch (e, stackTrace) {
      _log.e('PickFileUseCase error.', e, stackTrace);
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Unable to upload'.tr,
        description:
            "Cannot upload the file because \nit's not  on your device. Please make \nsure the file is on your device and try \nagain"
                .tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.context!.theme.appColors.textPrimary,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }
}
