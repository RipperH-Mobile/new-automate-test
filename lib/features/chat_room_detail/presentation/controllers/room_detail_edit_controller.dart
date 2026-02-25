import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/change_room_photo_request.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_access_type_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_room_name_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/set_default_group_avatar_request.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/use_cases.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/fetch_default_group_avatar_use_case.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/data/models/requests/update_nickname_request.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/update_nickname_use_case.dart';
import 'package:uchat/features/media_gallery/media_gallery.dart';
import 'package:uchat/screens/desktop_crop/desktop_crop_controller.dart';
import 'package:uchat/screens/desktop_crop/desktop_crop_screen.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class RoomDetailEditController extends GetxController with GetSingleTickerProviderStateMixin {
  final ChangeGroupAccessTypeUseCase changeGroupAccessTypeUseCase;
  final ChangeRoomNameUseCase changeRoomNameUseCase;
  final ChangeRoomPhotoUseCase changeRoomPhotoUseCase;
  final SetDefaultGroupAvatarUseCase setDefaultGroupAvatarUseCase;

  String roomId;

  RoomDetailEditController({
    required this.changeGroupAccessTypeUseCase,
    required this.changeRoomNameUseCase,
    required this.changeRoomPhotoUseCase,
    required this.setDefaultGroupAvatarUseCase,
    this.roomId = '',
  });

  final roomDb = GetIt.I<RoomDb>();
  final roomMemberDb = GetIt.I<RoomMemberDb>();

  final nameTextController = TextEditingController();
  final nameText = ''.obs;
  final nameFocusNode = FocusNode();
  final nameTextCount = 0.obs;
  final canEditGroup = false.obs;

  final room = Rx<RoomCollection?>(null);
  final contact = Rx<ContactCollection?>(null);
  final accessTypePrivate = true.obs;
  final selectedAvatar = Rx<File?>(null);
  final title = ''.obs;

  final friendAccountId = ''.obs;
  final maxLengthName = 50.obs;

  /// List of default group avatar images from server
  final defaultGroupAvatarImages = <String>[].obs;
  final selectedDefaultAvatar = ''.obs;

  /// Camera
  /// https://pub.dev/packages/camera
  CameraController? cameraController;
  final availableCameraList = <CameraDescription>[].obs;
  final isCameraReady = false.obs;
  late AnimationController animatedControllerCameraIcon;

  @override
  void onInit() async {
    if (roomId.isEmpty) {
      roomId = Get.parameters['id'] ?? '';
    }

    if (roomId.isEmpty) {
      Get.back();
      return;
    }

    // Init animation controller
    animatedControllerCameraIcon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    initData();
    super.onInit();
  }

  @override
  void onClose() async {
    nameTextController.dispose();
    nameFocusNode.dispose();
    animatedControllerCameraIcon.dispose();
    await cameraController?.dispose();
    super.onClose();
  }

  ChatRoomController? get roomCtl {
    try {
      return Get.find<ChatRoomController>(tag: roomId);
    } catch (e, stackTrace) {
      _log.w('Get roomCtl error in RoomDetailEditController.', e, stackTrace);
      return null;
    }
  }

  bool get isDirectChat => roomCtl?.isDirectRoom ?? false;

  void getRoomToState() {
    final roomData = roomDb.getRoomSync(roomId);
    if (roomData == null) {
      Get.back();
      return;
    }

    room(roomData);
  }

  void getContactToState() {
    final friendAccountIdData = roomMemberDb.getFirstOtherInRoomSync(room()?.id ?? '');

    if (friendAccountIdData == null) {
      Get.back();
      return;
    }

    friendAccountId.value = friendAccountIdData.accountId!;
    final contactData = GetIt.I<GetContactSyncUseCase>().call(friendAccountIdData.accountId!);

    if (contactData == null) {
      Get.back();
      return;
    }

    contact(contactData.toCollection());
  }

  /// Init data
  /// - Get room data
  /// - Get contact data
  /// - Set title
  /// - Set name text
  /// - Set name text count
  /// - Set max length name
  /// - Set access type private
  Future<void> initData() async {
    handleFetchDefaultGroupAvatar();
    getRoomToState();
    if (room() != null) {
      if (room()!.isDirect) {
        getContactToState();
        if (contact() != null) {
          title(contact()?.nickname ?? '');
          final name = title().trim();
          nameTextController.text = name;
          nameText.value = name;
          nameTextCount.value = name.characters.length;
          maxLengthName.value = 20;
        }
      } else {
        title(room()!.roomName);
        accessTypePrivate(room()?.accessType == RoomAccessType.private);
        final name = title().trim();
        nameTextController.text = name;
        nameText.value = name;
        nameTextCount.value = name.characters.length;
      }
    }
  }

  /// Init camera
  /// - Get available camera list
  /// - Init camera controller with first camera in available camera list
  /// - Initialize camera controller with low resolution and disable audio
  /// - Set is camera ready to true when camera controller is initialized
  /// - Animate camera icon when camera controller is initialized
  Future<void> initCamera() async {
    availableCameraList.value = await availableCameras();
    if (availableCameraList.isEmpty) {
      return;
    }

    cameraController = CameraController(
      availableCameraList.first,
      ResolutionPreset.low,
      enableAudio: false,
    );

    await cameraController?.initialize();
    isCameraReady(true);
    animatedControllerCameraIcon.forward();
  }

  /// Dispose camera
  /// - Dispose camera controller
  /// - Set is camera ready to false
  /// - Reverse animate camera icon
  Future<void> disposeCamera() async {
    await cameraController?.dispose();
    isCameraReady(false);
    animatedControllerCameraIcon.reverse();
  }

  void onChangedName(String? text) {
    final text = nameTextController.value.text.trim();
    nameText(text);
    nameTextCount(text.characters.length);
    if (nameText() != room()?.title) {
      canEditGroup.value = true;
    } else {
      canEditGroup.value = false;
    }
  }

  void handleClearTextField() {
    nameTextController.clear();
    nameText('');
  }

  /// Handle open room detail select photo
  /// - Init camera
  /// - Navigate to room detail select photo
  /// - Dispose camera
  /// initialize camera controller with first camera in available camera list when open room detail select photo
  /// and dispose camera controller when close room detail select photo
  // Future<void> handleOpenRoomDetailSelectPhoto() async {
  //   initCamera();
  //   if (Platform.isMacOS || Platform.isWindows) {
  //     await UChatDialog.showCustomDialog<void, RoomDetailEditController>(
  //       init: RoomDetailEditController(
  //         roomId: room.value!.id!,
  //         changeGroupAccessTypeUseCase: getIt<ChangeGroupAccessTypeUseCase>(),
  //         changeRoomNameUseCase: getIt<ChangeRoomNameUseCase>(),
  //         changeRoomPhotoUseCase: getIt<ChangeRoomPhotoUseCase>(),
  //         setDefaultGroupAvatarUseCase: getIt<SetDefaultGroupAvatarUseCase>(),
  //       ),
  //       child: (_) => const RoomDetailSelectPhotoScreen(),
  //     );
  //   } else {
  //     await Get.toNamed(
  //       Routes.roomDetailSelectPhotoProfile.replaceAll(':id', roomId),
  //     );
  //   }
  //   disposeCamera();
  // }

  void selectImage(File? file) async {
    if (file != null) {
      selectedAvatar(file);
    }
  }

  /// Handle open room detail select photo
  /// It will fetch when open room detail edit screen
  Future<void> handleFetchDefaultGroupAvatar() async {
    try {
      final response = await GetIt.I<FetchDefaultGroupAvatarUseCase>().call(NoParams());

      defaultGroupAvatarImages.value = response;
    } catch (e, stackTrace) {
      _log.e('handleFetchDefaultGroupAvatar error', e, stackTrace);

      defaultGroupAvatarImages.value = [];
    }

    _log.d('Fetched defaultGroupAvatarImages: $defaultGroupAvatarImages');
  }

  Future<void> handleSelectPhotoFromGallery() async {
    final mediaResult = await GetIt.I<GetOneImageGalleryUseCase>().call(NoParams());
    if (mediaResult == null) {
      return;
    }

    if (mediaResult.imageCount > 0) {
      final file = await mediaResult.images.first.file;
      if (file == null) {
        return;
      }

      final file2 = await handleCropProfileImage(file);
      selectImage(file2);
      Get.back();
    }
  }

  Future<void> handleSelectPhotoFromGalleryDesktop() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result == null) return;
      String? path = result.files.single.path;

      if (path == null) return;

      final fileInfo = await FileInfoModel.fromFile(File(path), 0);
      final fileSize = await fileInfo.size;
      if (fileSize > UChatConstant.fileSizeLimit) {
        UChatDialog.showFileTooLargeDialog();
        return;
      }
      if (result.files.firstOrNull != null) {
        final fileImage = File(result.files.firstOrNull!.path ?? '');
        Get.back();
        final resultImageCrop = await UChatDialog.showCustomDialog<File, DesktopCropController>(
          init: DesktopCropController(
            file: fileImage,
          ),
          child: (_) => const DesktopCropScreen(),
        );
        selectImage(
          resultImageCrop,
        );
        if (resultImageCrop != null) {
          canEditGroup.value = true;
        } else {
          canEditGroup.value = false;
        }
      }
    } catch (e) {
      _log.e('handleSelectFile error: $e');
    }
  }

  Future<void> handleSelectDefaultPhoto(String url) async {
    _log.d('Selected default photo: $url');
    try {
      selectedDefaultAvatar(url);
      canEditGroup.value = true;
      Get.back();
    } catch (e, stackTrace) {
      _log.e('Call handleSelectDefaultPhoto error.', e, stackTrace);
    }
  }

  Future<void> handleSetDefaultGroupAvatarAsProfile({
    required String imageUrl,
  }) async {
    try {
      final fileName = imageUrl.split('/').last;

      await setDefaultGroupAvatarUseCase.call(SetDefaultGroupAvatarRequest(
        roomId: roomId,
        fileName: fileName,
      ));
      Get.back();
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('handleSetDefaultGroupAvatarAsProfile error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  Future<File?> handleCropProfileImage(File file) async {
    eventBus.fire(PasscodePreventEvent(preventActivate: true));

    final croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 100,
      maxHeight: 1024,
      maxWidth: 1024,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Profile Image'.tr,
          initAspectRatio: CropAspectRatioPreset.square,
          cropStyle: CropStyle.circle,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          aspectRatioPickerButtonHidden: true,
          cropStyle: CropStyle.circle,
          doneButtonTitle: 'Done'.tr,
          cancelButtonTitle: 'Cancel'.tr,
          resetButtonHidden: true,
        ),
      ],
    );

    if (croppedImage == null) return null;

    File fileImage = File(croppedImage.path);
    return fileImage;
  }

  /// to check if user can confirm or not when edit room detail
  /// - if room is [direct room], user can confirm when name text is not empty
  /// - if room is [group room], user can confirm when name text is not empty or selected avatar is not null
  bool get isCanConfirm {
    if (roomCtl?.isDirectRoom ?? false) {
      return nameText.value.isNotEmpty;
    }

    return nameText.value.isNotEmpty || selectedAvatar() != null || selectedDefaultAvatar().isNotEmpty;
  }

  void handleEditRoomDetail() async {
    try {
      if (!isCanConfirm) {
        return;
      }

      await UChatLoading.show(status: 'Updating...');

      if (room()!.isDirect) {
        handleUpdateDirectRoom();
      } else {
        handleUpdateGroupRoom();
      }

      await UChatLoading.success(message: 'Updated'.tr);
      Get.back();
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
      );
      _log.e('Call handleEditRoomDetail error.', e, stackTrace);
    }
  }

  Future<void> handleUpdateDirectRoom() async {
    try {
      await GetIt.I<UpdateNicknameUseCase>().call(
        UpdateNicknameRequest(
          isOriginalName: nameText.value.isEmpty,
          friendAccountId: friendAccountId.value,
          nickname: nameText.value.isEmpty ? null : nameText.value,
        ),
      );
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('handleUpdateDirectRoom error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  Future<void> handleUpdateGroupRoom() async {
    try {
      if (nameText.value.isNotEmpty) {
        await changeRoomNameUseCase.call(
          ChangeRoomNameRequest(
            roomId: roomId,
            roomName: nameText.value,
          ),
        );
        GetIt.I<TaxonomyService>()
            .sendEvent(EventName.editNameSuccessfully, eventProperties: EventProperty.editNameSuccessfully('groups'));
      }

      if (selectedAvatar() != null) {
        await changeRoomPhotoUseCase.call(
          ChangeRoomPhotoRequest(
            file: selectedAvatar()!,
            roomId: roomId,
          ),
        );
        await UChatLoading.hide();
      }

      if (selectedDefaultAvatar().isNotEmpty) {
        final fileName = selectedDefaultAvatar().split('/').last;
        await setDefaultGroupAvatarUseCase.call(SetDefaultGroupAvatarRequest(
          roomId: roomId,
          fileName: fileName,
        ));
      }

      if (accessTypePrivate() != (room()!.accessType == RoomAccessType.private)) {
        await changeGroupAccessTypeUseCase.call(
          ChangeGroupAccessTypeRequest(
            roomId: roomId,
            accessType: accessTypePrivate() ? RoomAccessType.private : RoomAccessType.public,
          ),
        );
      }

      Get.back();
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e.type == 'ERR_PERMISSION_DENIED') {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        _log.e('handleUpdateGroupRoom error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      _log.e('handleUpdateGroupRoom error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  Future<void> handleBack() async {
    if (nameText.isNotEmpty || selectedAvatar() != null || selectedDefaultAvatar().isNotEmpty) {
      String description;
      if (room()?.isDirect == true) {
        description = 'Do you want to discard editing names?'.tr;
      } else {
        description = 'Do you want to discard editing names and photos?'.tr;
      }
      final result = await UChatDialog.showDialog(
        title: 'Cancel name edit'.tr,
        description: description,
        confirmText: 'Discard'.tr,
        confirmButtonColor: UChatDialog.redDialogButtonColor,
      );

      if (result) {
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  void handleToggleAccessTypePrivate() {
    accessTypePrivate(!accessTypePrivate());
  }
}
