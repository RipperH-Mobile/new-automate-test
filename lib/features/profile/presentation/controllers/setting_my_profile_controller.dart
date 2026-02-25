import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/features/media_gallery/media_gallery.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets.dart';

final _log = useLogger();

class SettingMyProfileController extends GetxController {
  final userCtl = Get.find<UserController>();

  StreamSubscription? _userUpdateSubscription;

  UserEntity? get user => userCtl.currentUser();
  final displayNamePreview = Rx<String?>(null);
  final descriptionPreview = Rx<String?>(null);
  final userIdPreview = Rx<String?>(null);
  final dBirthdatePreview = Rx<DateTime?>(null);
  final profilePreview = Rx<File?>(null);

  int get displayNameLength {
    if (displayNamePreview.value != user?.displayName) {
      return displayNamePreview.value?.effectiveLength ?? 0;
    }
    return 0;
  }

  int get descriptionLength {
    if (descriptionPreview.value != user?.originalStatusMessage) {
      return descriptionPreview.value?.effectiveLength ?? 0;
    }
    return 0;
  }

  @override
  void onInit() {
    clearData();
    displayNamePreview(user?.displayName);
    descriptionPreview(user?.originalStatusMessage);
    userIdPreview(user?.username);
    dBirthdatePreview(user?.dBirthdate);

    _initSubscription();

    super.onInit();
  }

  @override
  void onClose() {
    _userUpdateSubscription?.cancel();
    super.onClose();
  }

  void _initSubscription() {
    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) {
      if (event.user.id == user?.id) {
        _updateFromUserEvent(event.user);
      }
    });
  }

  void _updateFromUserEvent(UserEntity updatedUser) {
    userCtl.currentUser.value = updatedUser;
    displayNamePreview.value = updatedUser.displayName;
    descriptionPreview.value = updatedUser.originalStatusMessage;
    userIdPreview.value = updatedUser.username;
    dBirthdatePreview.value = updatedUser.dBirthdate;
    profilePreview.value = null;
  }

  void clearData() {
    displayNamePreview.value = user?.displayName;
    descriptionPreview.value = user?.originalStatusMessage;
    userIdPreview.value = user?.username;
    dBirthdatePreview.value = user?.dBirthdate;
    profilePreview.value = null;
  }

  String? get birthdatePreview {
    if (dBirthdatePreview() == null) {
      return null;
    }
    return dBirthdatePreview()!.toLocal().format('dd/MM/yyyy');
  }

  /*━━━━━━━━━━  HANDLE BACK AND SAVE   ━━━━━━━━━*/
  Future<void> saveNewChange() async {
    Get.back();
  }

  Future<void> _saveProfileImage(File file) async {
    _log.d('Upload profile image: $file');

    UpdateProfileImageRequest req = UpdateProfileImageRequest(file: file);

    // Upload file
    final res = await AccountService().uploadProfileImage(req);
    if (res != null) {
      userCtl.currentUser(
        user!.copyWith(
          avatarId: res.avatarId,
          avatarBlurhash: res.avatarBlurhash,
        ),
      );
    }
  }

  Future<void> _saveUsername(String newUsername) async {
    final req = UpdateUsernameRequest(
      username: newUsername,
    );

    final res = await AccountService().updateProfileUsername(req);
    if (res != null) {
      userCtl.currentUser(
        user!.copyWith(
          username: res.username,
        ),
      );
    }
  }

  Future<void> _saveStatus(String newStatus) async {
    final req = UpdateStatusMessageRequest(
      statusMessage: newStatus,
    );

    final res = await AccountService().updateProfileStatusMessage(req);
    if (res != null) {
      userCtl.currentUser(
        user!.copyWith(
          originalStatusMessage: res.statusMessage,
          forceClearStatusMessage: res.statusMessage == null,
        ),
      );
    }
  }

  Future<void> _saveDisplayName(String newDisplayName) async {
    final req = UpdateDisplayNameRequest(
      displayName: newDisplayName,
    );

    final res = await AccountService().updateProfileDisplayName(req);

    if (res != null) {
      userCtl.currentUser(
        user!.copyWith(
          displayName: res.displayName,
        ),
      );
    }
  }

  Future<void> _saveBirthdate(DateTime newBirthdate) async {
    final resp = await AccountService().updateProfileBirthdate(
      UpdateBirthdateRequest(
        birthdate: newBirthdate,
      ),
    );

    if (resp != null) {
      userCtl.currentUser(
        user!.copyWith(birthDate: resp.birthDate),
      );
    }
  }

  /*━━━━━━━━━━  HANDLE EDIT PROFILE  ━━━━━━━━━*/
  Future<void> onChooseFromLibrary(BuildContext context) async {
    final temp = profilePreview.value;
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
      // Store to profilePreview if cropping succeeded
      if (croppedFile != null) {
        try {
          profilePreview.value = croppedFile;
          await _saveProfileImage(croppedFile);
          eventBus.fire(UserUpdateEvent(user: user!));
          await UChatLoading.success(message: 'Success'.tr);
          GetIt.I<TaxonomyService>().sendEvent(
            EventName.profileUpdated,
            eventProperties: EventProperty.profileUpdate('picture'),
          );
        } catch (e, stackTrace) {
          profilePreview.value = temp; // Restore previous value on error
          await UChatLoading.success(message: 'Failed'.tr);
          handleException(e, onUnknownException: () async {
            _log.e('Save new change error.', e, stackTrace);
            await UChatLoading.failed();
          });
        }
      }
      GetIt.I<TaxonomyService>().sendEvent(EventName.uploadProfile);
    }
  }

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

  /*━━━━━━━━━━  HANDLE DISPLAY NAME  ━━━━━━━━━*/
  void handleEditDisplayName() async {
    final temp = displayNamePreview.value;
    final newDisplayName = await _showEditBottomSheet<String>(
      child: DisplayNameBottomSheet(
        initialValue: displayNamePreview.value ?? user?.displayName,
      ),
    );

    if (newDisplayName == displayNamePreview.value) {
      return;
    }

    // Only update if user actually saved a new name
    if (newDisplayName != null && newDisplayName.isNotEmpty) {
      try {
        // Save changes only for fields that actually changed
        displayNamePreview(newDisplayName);
        await _saveDisplayName(newDisplayName);
        eventBus.fire(UserUpdateEvent(user: user!));
        await UChatLoading.success(message: 'Success'.tr);
        GetIt.I<TaxonomyService>().sendEvent(
          EventName.profileUpdated,
          eventProperties: EventProperty.profileUpdate('name'),
        );
      } catch (e, stackTrace) {
        displayNamePreview(temp); // Restore previous value on error
        await UChatLoading.success(message: 'Failed'.tr);
        handleException(e, onUnknownException: () async {
          _log.e('Save new change error.', e, stackTrace);
          await UChatLoading.failed();
        });
      }
    }

    // Clean up the controller when done
    if (Get.isRegistered<SettingMyProfileDisplayNameController>()) {
      Get.delete<SettingMyProfileDisplayNameController>();
    }
  }

  void handleEditStatusMessage() async {
    final temp = descriptionPreview.value;
    final newStatusMessage = await _showEditBottomSheet<String>(
      child: StatusMessageBottomSheet(
        initialValue: descriptionPreview.value ?? user?.originalStatusMessage,
      ),
    );

    if (newStatusMessage == descriptionPreview.value) {
      return; // No change, exit early
    }

    // Update even if status message is empty (unlike display name)
    if (newStatusMessage != null) {
      try {
        descriptionPreview(newStatusMessage);
        await _saveStatus(newStatusMessage);
        eventBus.fire(UserUpdateEvent(user: user!));
        await UChatLoading.success(message: 'Success'.tr);
        GetIt.I<TaxonomyService>().sendEvent(
          EventName.profileUpdated,
          eventProperties: EventProperty.profileUpdate('status'),
        );
      } catch (e, stackTrace) {
        descriptionPreview(temp); // Restore previous value on error
        await UChatLoading.success(message: 'Failed'.tr);
        handleException(e, onUnknownException: () async {
          _log.e('Save new change error.', e, stackTrace);
          await UChatLoading.failed();
        });
      }
    }

    // Clean up the controller when done
    if (Get.isRegistered<SettingMyProfileStatusMessageController>()) {
      Get.delete<SettingMyProfileStatusMessageController>();
    }
  }

  /*━━━━━━━━━━  HANDLE PHONE NUMBER  ━━━━━━━━━*/
  void handleCopyPhoneNumber() {
    try {
      // Use the logic from UserController
      userCtl.copyPhoneNumberToClipboard(Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleCopyPhoneNumber error', e, stackTrace);
    }
  }

  /*━━━━━━━━━━  HANDLE UCHAT ID  ━━━━━━━━━*/
  void handleEditUsername() async {
    final temp = userIdPreview.value;
    final newUsername = await _showEditBottomSheet<String>(
      isFullScreen: user?.lastEditUsernameAt != null,
      child: UChatIdBottomSheet(
        initialValue: userIdPreview.value ?? user?.username,
      ),
    );

    if (newUsername == userIdPreview.value) {
      return; // No change, exit early
    }

    // Only update if user actually saved a new username
    if (newUsername != null && newUsername.isNotEmpty) {
      try {
        userIdPreview(newUsername);
        await _saveUsername(newUsername);
        eventBus.fire(UserUpdateEvent(user: user!));
        await UChatLoading.success(message: 'Success'.tr);
      } catch (e, stackTrace) {
        userIdPreview(temp); // Restore previous value on error
        await UChatLoading.success(message: 'Failed'.tr);
        handleException(e, onUnknownException: () async {
          _log.e('Save new change error.', e, stackTrace);
          await UChatLoading.failed();
        });
      }
    }

    // Clean up controller
    if (Get.isRegistered<SettingMyProfileUchatIdController>()) {
      Get.delete<SettingMyProfileUchatIdController>();
    }
  }

/*━━━━━━━━━━  HANDLE DATE OF BIRTH  ━━━━━━━━━*/
  String get formattedBirthdatePreview {
    final previewDate = dBirthdatePreview();
    if (previewDate == null) {
      // Check if user has existing birthdate
      final userBirthDate = user?.birthDate;
      if (userBirthDate == null || userBirthDate.isEmpty) {
        return 'Not set up'.tr;
      }

      try {
        DateTime dateTime = DateTime.parse(userBirthDate);
        return DateFormat('MMM dd, yyyy', Get.locale?.languageCode ?? 'en').format(dateTime);
      } catch (e) {
        return 'Not set up'.tr;
      }
    }

    // Format preview date
    return DateFormat('MMM dd, yyyy', Get.locale?.languageCode ?? 'en').format(previewDate);
  }

  void handleEditBirthdate() async {
    final temp = dBirthdatePreview.value;
    final newBirthdate = await _showEditBottomSheet<DateTime>(
      height: MediaQuery.of(Get.context!).size.height * 0.3,
      child: DateOfBirthBottomSheet(
        initialValue: dBirthdatePreview.value ?? user?.dBirthdate,
      ),
    );

    if (newBirthdate == dBirthdatePreview.value) {
      return; // No change, exit early
    }

    // Update if user selected a date (even if it's the same - requirement 2)
    if (newBirthdate != null) {
      try {
        dBirthdatePreview(newBirthdate);
        await _saveBirthdate(newBirthdate);
        eventBus.fire(UserUpdateEvent(user: user!));
        await UChatLoading.success(message: 'Success'.tr);
        GetIt.I<TaxonomyService>().sendEvent(
          EventName.profileUpdated,
          eventProperties: EventProperty.profileUpdate('date of birth'),
        );
      } catch (e, stackTrace) {
        dBirthdatePreview(temp); // Restore previous value on error
        await UChatLoading.success(message: 'Failed'.tr);
        handleException(e, onUnknownException: () async {
          _log.e('Save new change error.', e, stackTrace);
          await UChatLoading.failed();
        });
      }
    }

    // Clean up controller
    if (Get.isRegistered<SettingMyProfileDateOfBirthController>()) {
      Get.delete<SettingMyProfileDateOfBirthController>();
    }
  }

  /*━━━━━━━━━━  HANDLE OPEN BOTTOM SHEET  ━━━━━━━━━*/

  Future<T?> _showEditBottomSheet<T>({
    required Widget child,
    bool enableDrag = false,
    bool isFullScreen = false,
    double? height,
  }) async {
    return await Get.bottomSheet<T>(
      Container(
        // height of the bottom sheet
        height: height ??
            (isFullScreen
                ? MediaQuery.of(Get.context!).size.height - MediaQuery.of(Get.context!).padding.top
                : MediaQuery.of(Get.context!).size.height * 0.6 - MediaQuery.of(Get.context!).padding.top),
        decoration: BoxDecoration(
          color: Get.context!.theme.appColors.backgroundNeutralLightest,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppRadius.rounded2xl),
            topRight: Radius.circular(AppRadius.rounded2xl),
          ),
        ),
        child: child,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: enableDrag,
      isDismissible: false,
      settings: const RouteSettings(
        name: 'ProfileEditBottomSheet',
      ),
    );
  }
}
