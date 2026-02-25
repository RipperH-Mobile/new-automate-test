import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_group_permission_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_one_member_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_one_member_use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class ChatRoomDetailGroupPermissionsController extends GetxController {
  final String roomId;
  final UserEntity? currentUser;
  final GetGroupPermissionUseCase getGroupPermissionUseCase;
  final UpdateGroupPermissionUseCase updateGroupPermissionUseCase;
  final WatchGroupPermissionUseCase watchGroupPermissionUseCase;
  final GetOneMemberUseCase getCurrentMemberUseCase;

  StreamSubscription<GroupPermissionEntity>? _permissionSubscription;

  ChatRoomDetailGroupPermissionsController({
    required this.roomId,
    required this.currentUser,
    required this.getGroupPermissionUseCase,
    required this.updateGroupPermissionUseCase,
    required this.watchGroupPermissionUseCase,
    required this.getCurrentMemberUseCase,
  });

  final isLoading = true.obs;
  final isEditablePermissions = true.obs;

  final customizablePermissions = false.obs;
  final applyToAdmins = false.obs;
  final sendMessages = true.obs;
  final sendMedia = true.obs;
  final mentionAll = true.obs;
  final editOwnMessages = true.obs;
  final unsendOwnMessages = true.obs;
  final useEmojiReactions = true.obs;
  final addDeleteAlbum = true.obs;

  final Map<String, bool> _initialValues = {};
  final hasPermissionChanges = false.obs;
  final canSetToDefault = false.obs;

  @override
  Future<void> onInit() async {
    await _initEditablePermissions();
    await _fetchPermissions();
    _watchPermissionsChanged();
    _watchServerPermissions();
    super.onInit();
  }

  @override
  void onClose() {
    _permissionSubscription?.cancel();
    super.onClose();
  }

  void toggleCustomizablePermissions(bool? value) {
    customizablePermissions.value = !customizablePermissions.value;
  }

  void toggleApplyToAdmins(bool? value) {
    applyToAdmins.value = value ?? !applyToAdmins.value;
  }

  void toggleSendMessages(bool? value) {
    sendMessages.value = value ?? !sendMessages.value;
  }

  void toggleSendMedia(bool? value) {
    sendMedia.value = value ?? !sendMedia.value;
  }

  void togglementionAll(bool? value) {
    mentionAll.value = value ?? !mentionAll.value;
  }

  void toggleEditOwnMessages(bool? value) {
    editOwnMessages.value = value ?? !editOwnMessages.value;
  }

  void toggleUnsendOwnMessages(bool? value) {
    unsendOwnMessages.value = value ?? !unsendOwnMessages.value;
  }

  void toggleUseEmojiReactions(bool? value) {
    useEmojiReactions.value = value ?? !useEmojiReactions.value;
  }

  void toggleAddDeleteAlbum(bool? value) {
    addDeleteAlbum.value = value ?? !addDeleteAlbum.value;
  }

  void onBack() {
    if (!isEditablePermissions.value || !hasPermissionChanges.value) {
      return Get.back();
    }

    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Discard settings?'.tr,
      description: 'Are you sure you want to discard this setting? Any changes you\'ve made will not be saved.'.tr,
      confirmTextColor: Get.context?.theme.appColors.textError,
      cancelText: 'Cancel'.tr,
      confirmText: 'Discard'.tr,
      onConfirm: () async {
        await Future.delayed(const Duration(milliseconds: 250));
        Get.back();
      },
    );
  }

  void onDone() async {
    if (!hasPermissionChanges.value) {
      Get.back();
      return;
    }

    try {
      final permissionEntity = GroupPermissionEntity(
        roomId: roomId,
        enable: customizablePermissions.value,
        applyToAdmin: applyToAdmins.value,
        canSendMessages: sendMessages.value,
        canSendMedia: sendMedia.value,
        canMentionAll: mentionAll.value,
        canEditOwnMessage: editOwnMessages.value,
        canUnsendOwnMessage: unsendOwnMessages.value,
        canReactions: useEmojiReactions.value,
        canAddDeleteAlbum: addDeleteAlbum.value,
      );

      final params = UpdateGroupPermissionParams(
        permission: permissionEntity,
        persistences: {
          GroupPermissionPersistence.local,
          GroupPermissionPersistence.server,
        },
      );
      await updateGroupPermissionUseCase(params);
      AppToast.showToast(
        context: Get.context!,
        message: 'You\'ve changed group permissions.'.tr,
        icon: Icon(
          Icons.check_circle_rounded,
          size: AppSize.size6,
          color: Get.context?.theme.appColors.iconInverse,
          blendMode: BlendMode.srcIn,
        ),
      );
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
    } catch (e) {
      await UChatLoading.hide();

      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  void setToDefault() {
    final defaultPermission = GroupPermissionEntity(roomId: roomId);
    _setPermissionValues(defaultPermission);
  }

  Future<void> _fetchPermissions() async {
    try {
      final params = GetGroupPermissionParams(
        roomId: roomId,
        persistences: {GroupPermissionPersistence.server},
      );
      final permission = await getGroupPermissionUseCase(params) ?? GroupPermissionEntity(roomId: roomId);
      _setPermissionValues(permission);
    } catch (_) {
      setToDefault();
    } finally {
      isLoading.value = false;
      _storeInitialValues();
    }
  }

  void _setPermissionValues(GroupPermissionEntity permission) {
    customizablePermissions.value = permission.enable;
    applyToAdmins.value = permission.applyToAdmin;
    sendMessages.value = permission.canSendMessages;
    sendMedia.value = permission.canSendMedia;
    mentionAll.value = permission.canMentionAll;
    editOwnMessages.value = permission.canEditOwnMessage;
    unsendOwnMessages.value = permission.canUnsendOwnMessage;
    useEmojiReactions.value = permission.canReactions;
    addDeleteAlbum.value = permission.canAddDeleteAlbum;
  }

  void _storeInitialValues() {
    _initialValues['customizablePermissions'] = customizablePermissions.value;
    _initialValues['applyToAdmins'] = applyToAdmins.value;
    _initialValues['sendMessages'] = sendMessages.value;
    _initialValues['sendMedia'] = sendMedia.value;
    _initialValues['mentionAll'] = mentionAll.value;
    _initialValues['editOwnMessages'] = editOwnMessages.value;
    _initialValues['unsendOwnMessages'] = unsendOwnMessages.value;
    _initialValues['useEmojiReactions'] = useEmojiReactions.value;
    _initialValues['addDeleteAlbum'] = addDeleteAlbum.value;
  }

  void _watchPermissionsChanged() {
    _checkForPermissionsChanges();

    ever(customizablePermissions, (value) => _checkForPermissionsChanges());
    ever(applyToAdmins, (value) => _checkForPermissionsChanges());
    ever(sendMessages, (value) => _checkForPermissionsChanges());
    ever(sendMedia, (value) => _checkForPermissionsChanges());
    ever(mentionAll, (value) => _checkForPermissionsChanges());
    ever(editOwnMessages, (value) => _checkForPermissionsChanges());
    ever(unsendOwnMessages, (value) => _checkForPermissionsChanges());
    ever(useEmojiReactions, (value) => _checkForPermissionsChanges());
    ever(addDeleteAlbum, (value) => _checkForPermissionsChanges());
  }

  void _checkForPermissionsChanges() {
    _verifySetToDefaultChanged();
    _verifyPermissionsChanged();
  }

  void _verifySetToDefaultChanged() {
    canSetToDefault.value = customizablePermissions.value != true ||
        applyToAdmins.value != false ||
        sendMessages.value != true ||
        sendMedia.value != true ||
        mentionAll.value != true ||
        editOwnMessages.value != true ||
        unsendOwnMessages.value != true ||
        useEmojiReactions.value != true ||
        addDeleteAlbum.value != true;
  }

  void _verifyPermissionsChanged() {
    hasPermissionChanges.value =
        customizablePermissions.value != (_initialValues['customizablePermissions'] ?? false) ||
            applyToAdmins.value != (_initialValues['applyToAdmins'] ?? false) ||
            sendMessages.value != (_initialValues['sendMessages'] ?? true) ||
            sendMedia.value != (_initialValues['sendMedia'] ?? true) ||
            mentionAll.value != (_initialValues['mentionAll'] ?? true) ||
            editOwnMessages.value != (_initialValues['editOwnMessages'] ?? true) ||
            unsendOwnMessages.value != (_initialValues['unsendOwnMessages'] ?? true) ||
            useEmojiReactions.value != (_initialValues['useEmojiReactions'] ?? true) ||
            addDeleteAlbum.value != (_initialValues['addDeleteAlbum'] ?? true);
  }

  void _watchServerPermissions() {
    _permissionSubscription?.cancel();
    _permissionSubscription =
        watchGroupPermissionUseCase.call(WatchGroupPermissionParams(roomId: roomId)).listen(_setPermissionValues);
  }

  Future<void> _initEditablePermissions() async {
    final roomMember = await getCurrentMemberUseCase.call(
      GetOneMemberParams(
        roomId: roomId,
        accountId: currentUser?.id ?? '',
      ),
    );

    isEditablePermissions.value = roomMember?.ableSetGroupPermission ?? false;
  }
}
