import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/events/update_room_invite_link_event.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/revoke_room_invite_link_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_invite_link_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_invite_link_qr_code_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_invite_link_setting_argument.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/extension/extension_link_preview.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomDetailGroupInviteLinkIds {
  static const String inviteLinkSection = 'invite_link_section';
  static const String inviteLinkStatus = 'invite_link_status';
  static const String inviteLinkPreview = 'invite_link_preview';
}

class ChatRoomDetailGroupInviteLinkController extends GetxController {
  late String roomId;
  RoomAccessType roomAccessType = RoomAccessType.private;
  InviteLinkStatus inviteLinkStatus = InviteLinkStatus.on;
  String? inviteLink;

  StreamSubscription? _updateRoomInviteLinkSubscription;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is! ChatRoomDetailInviteLinkArgument) {
      Get.back();
    } else {
      final args = Get.arguments as ChatRoomDetailInviteLinkArgument;
      roomId = args.roomId;
      roomAccessType = args.groupType;
      inviteLinkStatus = args.roomInviteLink.enable;
      inviteLink = args.roomInviteLink.inviteLink;
    }

    _updateRoomInviteLinkSubscription = eventBus.on<UpdateRoomInviteLinkEvent>().listen(listenOnUpdateRoomInviteLink);
  }

  @override
  void onClose() {
    _updateRoomInviteLinkSubscription?.cancel();
    super.onClose();
  }

  void onBack() {
    Get.back();
  }

  Future<void> listenOnUpdateRoomInviteLink(UpdateRoomInviteLinkEvent event) async {
    if (event.roomInviteLink.roomId != roomId) {
      return;
    }

    inviteLinkStatus = event.roomInviteLink.enable;
    inviteLink = event.roomInviteLink.inviteLink;

    update([
      ChatRoomDetailGroupInviteLinkIds.inviteLinkStatus,
      ChatRoomDetailGroupInviteLinkIds.inviteLinkSection,
      ChatRoomDetailGroupInviteLinkIds.inviteLinkPreview,
    ]);
  }

  Future<void> onGoToInviteLinkStatusSetting() async {
    final result = await Get.toNamed(
      Routes.roomDetailGroupInviteLinkSetting.replaceAll(':roomId', roomId),
      arguments: ChatRoomDetailInviteLinkSettingArgument(
        roomId: roomId,
        inviteLinkStatus: inviteLinkStatus,
      ),
    );

    if (result == null) {
      return;
    }

    if (result is RoomInviteLinkEntity) {
      inviteLinkStatus = result.enable;
      inviteLink = result.inviteLink;

      update([
        ChatRoomDetailGroupInviteLinkIds.inviteLinkStatus,
        ChatRoomDetailGroupInviteLinkIds.inviteLinkSection,
        ChatRoomDetailGroupInviteLinkIds.inviteLinkPreview,
      ]);
    }
  }

  void onCopyInviteLink(BuildContext context) {
    if (inviteLink == null) {
      return;
    }

    try {
      GetIt.I<VibrateUtil>().vibrateSelection();
      Clipboard.setData(ClipboardData(text: inviteLink!));
      AppToast.showCopyToClipboardToast(context: context, message: 'Copied message to clipboard'.tr);
    } catch (e, stackTrace) {
      _log.e('Error on copy invite link to clipboard', e, stackTrace);
    }
  }

  Future<void> onShareInviteLink() async {
    try {
      GetIt.I<VibrateUtil>().vibrateSelection();
      final messageLinks = await inviteLink.toMessageLinks();

      await GetIt.I<SharingService>().share(
        data: ShareBottomSheetDataEntity(
          newMessage: MessageCollection(
            type: MessageType.text,
            message: inviteLink,
            links: messageLinks,
          ),
        ),
      );
    } catch (e, stackTrace) {
      _log.e('Error on share invite link', e, stackTrace);
    }
  }

  Future<void> onGetQRCode() async {
    if (inviteLink == null) {
      return;
    }

    Get.toNamed(
      Routes.roomDetailGroupInviteLinkQrCode.replaceAll(':roomId', roomId),
      arguments: ChatRoomDetailInviteLinkQrCodeArgument(
        roomId: roomId,
        inviteLink: inviteLink!,
      ),
    );
  }

  Future<void> onRevokeLink() async {
    if (inviteLinkStatus == InviteLinkStatus.off) {
      return;
    }

    UChatNewDialog.showConfirmRevokeInviteLinkDialog(
      context: Get.context!,
      onConfirm: () async {
        try {
          GetIt.I<VibrateUtil>().vibrateSelection();

          final updatedInviteLink = await GetIt.I<RevokeRoomInviteLinkUseCase>().call(
            RevokeRoomInviteLinkParams(roomId: roomId),
          );
          if (updatedInviteLink == null) {
            UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
            return;
          }

          inviteLinkStatus = updatedInviteLink.enable;
          inviteLink = updatedInviteLink.inviteLink;

          update([
            ChatRoomDetailGroupInviteLinkIds.inviteLinkStatus,
            ChatRoomDetailGroupInviteLinkIds.inviteLinkSection,
            ChatRoomDetailGroupInviteLinkIds.inviteLinkPreview,
          ]);
          AppToast.showRevokedInviteLinkToast(context: Get.context!);
        } on ApiException catch (e, stackTrace) {
          if (e.exceptionType == ApiExceptionType.permissionDenied) {
            UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
          } else {
            _log.e('Error on revoke invite link', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
          }
        } on FailedHostLookupException catch (e, stackTrace) {
          _log.e('Error on revoke invite link', e, stackTrace);
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('Error on revoke invite link', e, stackTrace);
        }
      },
    );
  }
}
