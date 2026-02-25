import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/event_bus/events/assign_admin_event.dart';
import 'package:uchat/core/event_bus/events/ownership_transferred_event.dart';
import 'package:uchat/core/event_bus/events/revoke_admin_event.dart';
import 'package:uchat/core/event_bus/events/update_admin_permission_event.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/chat_room/data/models/requests/change_room_photo_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reactions_in_room_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_reactions_by_room_id_use_case.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_owner_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_next_owner_suggestion_list_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/set_default_group_avatar_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_one_member_params.dart';
import 'package:uchat/features/chat_room_detail/domain/params/leave_group_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_next_owner_suggestion_list_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_room_invite_link_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/use_cases.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_group_type_setting_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_invite_link_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_owner_transfer_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/room_members_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_controller.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/extension/extension_getx.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomDetailGroupController extends ChatRoomDetailController {
  ChatRoomDetailGroupController({
    required super.tag,
  });

  final currentUserMemberData = Rxn<RoomMemberEntity>();

  final Rx<File> selectedAvatar = File('').obs;
  final selectedAvatarUrl = ''.obs;
  final randomDefaultGroupAvatar = ''.obs;
  StreamSubscription? _ownershipTransferredSubscription;
  StreamSubscription? _updateAdminPermissionSubscription;
  StreamSubscription? _revokeAdminPermissionSubscription;
  StreamSubscription? _assignAdminPermissionSubscription;

  final nextOwnerSuggestionList = Rx<List<RoomMemberEntity>>([]);
  final allAdminAndMembersCount = 0.obs;

  @override
  Future<void> initRoomDetailData() async {
    await super.initRoomDetailData();
    _listenRoomEvents();
    fetchRoomInviteLink();

    if (roomId != 'NEW_ROOM') {
      getCurrentUserMemberData();
    }
  }

  void _listenRoomEvents() {
    _ownershipTransferredSubscription =
        eventBus.on<OwnershipTransferredEvent>().listen((_) => getCurrentUserMemberData());

    _updateAdminPermissionSubscription =
        eventBus.on<UpdateAdminPermissionEvent>().listen((_) => getCurrentUserMemberData());

    _assignAdminPermissionSubscription = eventBus.on<AssignAdminEvent>().listen((_) => getCurrentUserMemberData());

    _revokeAdminPermissionSubscription = eventBus.on<RevokeAdminEvent>().listen((_) => getCurrentUserMemberData());
  }

  @override
  void onClose() {
    _ownershipTransferredSubscription?.cancel();
    _updateAdminPermissionSubscription?.cancel();
    _assignAdminPermissionSubscription?.cancel();
    _revokeAdminPermissionSubscription?.cancel();

    super.onClose();
  }

  Future<void> initNextOwnerSuggestion() async {
    final nextOwnerSuggestionModel = await GetIt.I<GetNextOwnerSuggestionListUseCase>().call(
      GetNextOwnerSuggestionListRequest(
        roomId: roomId,
      ),
    );

    nextOwnerSuggestionList.value.assignAll(nextOwnerSuggestionModel.suggestionMembers);
    allAdminAndMembersCount.value = nextOwnerSuggestionModel.countMembers;
  }

  void handleOwnerTransfer(RoomMemberEntity member) async {
    try {
      await GetIt.I<ChangeGroupOwnerUseCase>().call(
        ChangeGroupOwnerRequest(
          roomId: roomId,
          newOwnerId: member.account.id ?? '',
        ),
      );

      Get.close(1);

      showDialogLeaveGroup();
    } catch (e, stackTrace) {
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
      useLogger().e('handleOwnerTransfer error.', e, stackTrace);
    }
  }

  void getCurrentUserMemberData() async {
    try {
      final memberData = await GetIt.I<GetOneMemberUseCase>().call(GetOneMemberParams(
        roomId: room()?.id ?? '',
        accountId: UserController.instance.currentUser()?.id ?? '',
      ));

      currentUserMemberData.forceUpdate(memberData);
    } catch (e, stackTrace) {
      _log.e('getCurrentUserMemberData error.', e, stackTrace);
    }
  }

  void handleOpenGroupTypeSettingScreen() {
    Get.toNamed(
      Routes.roomDetailGroupTypeSetting.replaceAll(':id', roomId),
      arguments: ChatRoomDetailGroupTypeSettingArgument(
        roomId: roomId,
        groupType: room()?.accessType ?? RoomAccessType.private,
      ),
    );
  }

  Future<void> handleOpenGroupInviteLinkScreen() async {
    final roomInviteLink = await GetIt.I<GetRoomInviteLinkUseCase>().call(
      GetRoomInviteLinkUseCaseParams(roomId: roomId),
    );
    await Get.toNamed(
      Routes.roomDetailGroupInviteLink.replaceAll(':id', roomId),
      arguments: ChatRoomDetailInviteLinkArgument(
        roomId: roomId,
        groupType: room()?.accessType ?? RoomAccessType.private,
        roomInviteLink: roomInviteLink ??
            RoomInviteLinkEntity(
              roomId: roomId,
              enable: InviteLinkStatus.off,
              inviteLink: null,
            ),
      ),
    );
  }

  void handleOpenRoomMemberView() {
    Get.toNamed(
      Routes.roomDetailMember.replaceAll(':id', roomId),
      arguments: RoomMemberArgument(
        roomId: roomId,
      ),
    );
  }

  void handleOpenAdministratorScreen() {
    Get.toNamed(
      Routes.roomDetailAdmin.replaceAll(':id', roomId),
      arguments: ChatRoomDetailAdminArgument(
        roomId: roomId,
      ),
    );
  }

  Future<void> handleOpenOwnerTransferScreen({bool isShowLeaveGroup = false}) async {
    final response = await Get.toNamed(
      Routes.roomDetailOwnerTransfer.replaceAll(':id', roomId),
      arguments: ChatRoomDetailOwnerTransferArgument(
        roomId: roomId,
        roomName: title,
        isShowLeaveGroup: isShowLeaveGroup,
      ),
    );

    if (isShowLeaveGroup == true && response == true) {
      showDialogLeaveGroup();
    }
  }

  void showDialogLeaveGroup() {
    if (UChatCallController.instance.roomIsCalling(room()?.id)) {
      ActionUnavailableDialog.show();
      return;
    }

    UChatNewDialog.showLeaveGroupDialog(
      context: Get.context!,
      onConfirm: handleConfirmLeaveGroup,
    );
  }

  void handleConfirmLeaveGroup() async {
    try {
      await UChatLoading.show(status: 'Processing...'.tr);
      await GetIt.I<LeaveGroupUseCase>().call(LeaveGroupParams(
        roomId: room()!.id!,
        onRoomDeleted: (roomId) {
          eventBus.fire(RoomDeleteEvent(roomId: roomId));
        },
      ));
      await UChatLoading.success(message: 'Leave.'.tr);

      Get.until((route) => route.settings.name == Routes.home);
      await GetIt.I<RemoveReactionsByRoomIdUseCase>().call(
        RemoveReactionsByRoomIdRequest(
          roomId: room()?.id ?? '',
        ),
      );
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleConfirmLeaveGroup error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }
  }

  void handleOpenEditRoomDetail() {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickEditNameRoomdetails,
      eventProperties: EventProperty.clickEditNameRoomDetails('groups'),
    );
    Get.toNamed(
      Routes.roomDetailGroupEditName.replaceAll(':id', roomId),
    );
  }

  Future<void> handleReportGroupPressed({
    required BuildContext context,
    bool callBackOnOpen = false,
  }) async {
    ReportType reportType;

    reportType = ReportType.reportGroup;

    GetIt.I<TaxonomyService>()
        .sendEvent(EventName.clickReportRoomdetails, eventProperties: EventProperty.clickReportRoomDetails('groups'));

    MainDialogController.handleOpenDialog(
      context: context,
      reportType: reportType,
      displayName: title,
      roomId: roomId,
      isOwnerInGroup: currentUserMemberData.value?.isOwner ?? false,
    );
  }

  /// Launch the group profile picker and process the result.
  Future<void> handleGroupAvatarChange(BuildContext context) async {
    // Determine which image is currently in use (if any)
    final noLocalOrNetworkSelected = selectedAvatar.value.path.isEmpty && selectedAvatarUrl.value.isEmpty;
    final isUsingRandomDefault = noLocalOrNetworkSelected && randomDefaultGroupAvatar.value.isNotEmpty;
    String? currentSelectedUrl;
    if (selectedAvatarUrl.value.isNotEmpty) {
      currentSelectedUrl = selectedAvatarUrl.value;
    } else if (isUsingRandomDefault) {
      currentSelectedUrl = randomDefaultGroupAvatar.value;
    }

    // Open the group profile picker screen.
    final result = await Get.toNamed(
      Routes.groupProfilePicker,
      arguments: {
        'randomDefaultGroupAvatar': randomDefaultGroupAvatar.value,
        'isUsingRandomDefault': isUsingRandomDefault,
        'currentSelectedUrl': currentSelectedUrl,
      },
    );

    if (result != null) {
      if (result is File) {
        await handleSelectImage(context, result);
      } else if (result is String) {
        // User picked a default image from the grid.
        selectedAvatarUrl.value = result;
        selectedAvatar.value = File('');
      } else if (result is MediaGalleryResult) {
        // User picked an image from the gallery.
        final image = result.images.firstOrNull;
        final file = await image?.file;
        await handleSelectImage(context, file);
      }

      // After processing the selection, update the group avatar.
      await updateGroupAvatar();
    }
  }

  /// Crop the image and update the selectedAvatar.
  Future<void> handleSelectImage(BuildContext context, File? file) async {
    if (file == null) return;
    final croppedFile = await _cropImage(context, file);
    if (croppedFile != null) {
      selectedAvatar(croppedFile);
      selectedAvatarUrl.value = '';
    }
  }

  Future<File?> _cropImage(BuildContext context, File imageFile) async {
    final cropped = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 100,
      maxHeight: 1024,
      maxWidth: 1024,
      uiSettings: [
        AndroidUiSettings(
          backgroundColor: Colors.black,
          toolbarWidgetColor: context.theme.appColors.textPrimaryInverse,
          toolbarColor: Colors.black,
          toolbarTitle: '',
          hideBottomControls: true,
          showCropGrid: true,
          lockAspectRatio: true,
          initAspectRatio: CropAspectRatioPreset.square,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          cropStyle: CropStyle.rectangle,
        ),
        IOSUiSettings(
          cropStyle: CropStyle.rectangle,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          doneButtonTitle: 'Done'.tr,
          cancelButtonTitle: 'Cancel'.tr,
          rotateButtonsHidden: true,
          resetButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (cropped == null) return null;
    return File(cropped.path);
  }

  Future<void> updateGroupAvatar() async {
    await UChatLoading.show(status: 'Updating avatar...'.tr);

    try {
      // If a file has been selected, update the avatar using the file upload use case.
      if (selectedAvatar.value.path.isNotEmpty) {
        await GetIt.I<ChangeRoomPhotoUseCase>().call(
          ChangeRoomPhotoRequest(
            file: selectedAvatar.value,
            roomId: room()?.id ?? '',
          ),
        );
      }
      // Else if a default avatar URL is selected, update it via the default avatar use case.
      else if (selectedAvatarUrl.value.isNotEmpty) {
        final fileName = selectedAvatarUrl.value.split('/').last;
        await GetIt.I<SetDefaultGroupAvatarUseCase>().call(
          SetDefaultGroupAvatarRequest(
            roomId: room()?.id ?? '',
            fileName: fileName,
          ),
        );
      }

      await UChatLoading.hide();
      room.refresh(); // Update UI based on the refreshed room data.
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e.type == 'ERR_GENERATE_GROUP_AVATAR') {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        _log.e('updateGroupAvatar error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      _log.e('updateGroupAvatar error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  void handleOpenGroupPermissionsScreen() {
    Get.toNamed(
      Routes.roomDetailGroupPermissions.replaceAll(':id', roomId),
    );
  }

  Future<void> fetchRoomInviteLink() async {
    try {
      if (room.value?.isGroup == false) return;

      if (currentUserMemberData.value?.ableToAccessGroupTypeInviteLinkSetting != true) return;

      await GetIt.I<GetRoomInviteLinkUseCase>().call(
        GetRoomInviteLinkUseCaseParams(roomId: roomId, fromServer: true),
      );
    } on ApiException catch (e, stackTrace) {
      _log.e('fetchRoomInviteLink error.', e, stackTrace);
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('fetchRoomInviteLink error.', e, stackTrace);
    } catch (e, stackTrace) {
      _log.e('fetchRoomInviteLink error.', e, stackTrace);
    }
  }
}
