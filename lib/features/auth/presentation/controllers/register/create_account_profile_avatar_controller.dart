import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/platform_document_version_entity.dart';
import 'package:uchat/core/domain/enums/platform_document.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/core/domain/services/platform_document_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/auth/data/models/requests/auth_register_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/register_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_profile_avatar_arguments.dart';
import 'package:uchat/features/media_gallery/domain/use_cases/get_one_image_gallery_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class CreateAccountProfileAvatarController extends GetxController {
  final CreateAccountProfileAvatarArguments args;

  /// The currently selected image (from library or camera).
  final Rx<File?> selectedAvatar = Rx<File?>(null);

  /// If user has selected an image => enable “Done” button
  RxBool isButtonEnabled = false.obs;

  final AuthServerRepository authServerRepository;
  final UserLocalRepository userLocalRepository;

  CreateAccountProfileAvatarController(
      {required this.args, required this.authServerRepository, required this.userLocalRepository});

  @override
  void onInit() {
    // Whenever selectedAvatar changes, update isButtonEnabled
    ever<File?>(selectedAvatar, (file) {
      isButtonEnabled.value = (file != null);
    });
    super.onInit();
  }

  Future<void> acceptTermAndCondition() async {
    final versionTerm = await ConfigDb.instance.general.getString(key: ConfigDb.termVersionKey());
    final versionList = versionTerm!.split('.');
    try {
      await GetIt.I<PlatformDocumentService>().acceptTermAndCondition(
        PlatformDocumentType.termAndConditionWithPrivacy,
        PlatformDocumentVersionEntity(
          major: int.parse(versionList[0]),
          minor: int.parse(versionList[1]),
          patch: int.parse(versionList[2]),
        ),
      );
    } catch (e, stackTrace) {
      _log.e('acceptTermAndCondition error', e, stackTrace);
    }
  }

  /// User tapped "Choose from library"
  Future<void> onChooseFromLibrary(BuildContext context) async {
    final mediaResult = await GetIt.I<GetOneImageGalleryUseCase>().call(NoParams());

    if (mediaResult == null) {
      return;
    }

    if (mediaResult.imageCount > 0) {
      final pickedFile = await mediaResult.images.first.file;
      if (pickedFile == null) {
        return;
      }

      // Crop the image
      final croppedFile = await _cropImage(pickedFile);
      // Store to selectedAvatar if cropping succeeded
      if (croppedFile != null) {
        selectedAvatar.value = croppedFile;
      }
      GetIt.I<TaxonomyService>().sendEvent(EventName.uploadProfile);
    }
  }

  /// Called when user taps “Take Photo”
  Future<void> onTakePhoto(BuildContext context) async {
    // 1) Check camera permission
    final cameraGranted = await PermissionController.instance.requestCameraPermissionDirect(context);
    if (!cameraGranted) {
      // user denied => do nothing
      return;
    }

    // 2) If granted => pick from camera
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      final File originalFile = File(picked.path);
      final croppedFile = await _cropImage(originalFile);
      if (croppedFile != null) {
        selectedAvatar.value = croppedFile;
      }
      GetIt.I<TaxonomyService>().sendEvent(EventName.uploadProfile);
    }
  }

  /// Crop the selected image using image_cropper
  Future<File?> _cropImage(File imageFile) async {
    final ctx = Get.context!;
    final cropped = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1080,
      maxHeight: 1080,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          backgroundColor: Colors.black,
          toolbarWidgetColor: ctx.theme.appColors.textPrimaryInverse,
          toolbarColor: Colors.black,
          toolbarTitle: '',
          hideBottomControls: true,
          showCropGrid: true,
          lockAspectRatio: true,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        IOSUiSettings(
          rotateButtonsHidden: true,
          resetButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (cropped == null) {
      // user canceled cropping => return null
      return null;
    }
    return File(cropped.path);
  }

  /// If user wants to remove the current picture
  void removePicture() {
    selectedAvatar.value = null;
  }

  /// Final step: Press "Done" => create the account
  Future<void> onContinue() async {
    // Show loading
    await UChatLoading.show(status: 'Please wait...');

    // 1) Build AuthRegisterRequest
    final request = AuthRegisterRequest(
      actionToken: args.actionToken,
      phoneNumber: args.phoneNumber,
      password: args.password,
      displayName: args.displayName,
      username: args.userID,
      avatarPhotoFile: selectedAvatar.value,
    );

    // 2) Call register
    try {
      final res = await GetIt.I<RegisterUseCase>().call(request);
      // Store user locally
      try {
        final userEntity = res.toUserEntity();
        // We have a successfully stored user => set current user in memory
        await UserController.instance.setCurrentUser(
          userEntity,
          token: userEntity.token ?? '',
        );

        // Accept T&C
        await acceptTermAndCondition();

        // Hide loading and navigate
        await UChatLoading.hide();
        GetIt.I<TaxonomyService>().sendEvent(EventName.registerCompleted);
        Get.offAllNamed(Routes.home);
      } catch (e) {
        await UChatLoading.hide();
        // If something went wrong locally (e.g., DB error)
        handleException(e, onUnknownException: () {
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
          );
          _log.e('Error storing user locally:', e);
        });
      }
    } catch (e) {
      await UChatLoading.hide();
      if (e is ApiException) {
        if (['JsonWebTokenError', 'TokenExpiredError'].contains(e.type)) {
          await UChatDialog.showExceptionDialog(description: e.message.tr);
          Get.offAllNamed(Routes.welcome);
          return;
        } else if (e.type == 'ERR_ACCOUNT_ACTION_TOKEN_EXPIRED') {
          await UChatDialog.showExceptionDialog(
            title: 'Transaction exceeded the allotted time.'.tr,
            description: 'You have exceeded the time limit for creating personal data. Please try again.'.tr,
          );
          Get.offAllNamed(Routes.welcome);
          return;
        } else {
          _log.e('onContinue api exception error', e);
          // Show generic error
          await UChatDialog.showExceptionDialog(description: e.message.tr);
        }
      } else {
        // If it's some other unknown Exception...
        handleException(
          e,
          onUnknownException: () {
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
              e: ExceptionHandler.handle(e),
            );
            _log.e('onContinue error Unknown exception type:', e);
          },
        );
      }
    }
  }
}
