import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/use_cases.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/accept_room_handle_accept_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/reject_room_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/reject_group_invite_request.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class GroupInviteController extends GetxController {
  final GetRoomInviteListUseCase getRoomInviteListUseCase;

  GroupInviteController({
    required this.getRoomInviteListUseCase,
  });

  final roomInviteList = <RoomInviteEntity>[].obs;
  final selectedGroups = <RoomInviteEntity>[].obs;

  @override
  void onInit() async {
    await fetchGroupInviteList();

    super.onInit();
  }

  void handleBack() {
    fireRequireGroupInviteCountUpdateEvent();
    Get.back();
  }

  void handleAccept() async {
    try {
      UChatLoading.show(status: 'Accepting...'.tr);

      for (int i = 0; i < selectedGroups.length; i++) {
        String? id = selectedGroups[i].id;
        if (id == null) {
          return;
        }
        await GetIt.I<AcceptRoomHandleAcceptUseCase>().call(AcceptGroupInviteRequest(
          roomId: id,
        ));
      }

      fireRequireGroupInviteCountUpdateEvent();
      await clearSelectedMembers();
      UChatLoading.success(message: 'Accepted!'.tr);
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleAccept error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleReject() async {
    try {
      UChatLoading.show(status: 'Rejecting...'.tr);
      for (int i = 0; i < selectedGroups.length; i++) {
        String? id = selectedGroups[i].id;
        if (id == null) {
          return;
        }

        await GetIt.I<RejectRoomUseCase>().call(RejectGroupInviteRequest(roomId: id));
      }

      fireRequireGroupInviteCountUpdateEvent();
      await clearSelectedMembers();
      UChatLoading.success(message: 'Rejected!'.tr);
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleReject error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleSelectCheckbox(RoomInviteEntity group) {
    bool isSelected = selectedGroups.contains(group);

    if (isSelected) {
      selectedGroups.remove(group);
    } else {
      selectedGroups.add(group);
    }
  }

  Future<void> clearSelectedMembers() async {
    selectedGroups.clear();
    await fetchGroupInviteList();
  }

  Future<void> fetchGroupInviteList() async {
    _log.d('fetchGroupInviteList');

    try {
      final inviteList = await getRoomInviteListUseCase.call(NoParams());

      if (inviteList?.rooms != null) {
        roomInviteList(inviteList!.toEntity().rooms);
      }
    } catch (e, stackTrace) {
      _log.e('fetchGroupInviteList error.', e, stackTrace);
    }
  }

  void fireRequireGroupInviteCountUpdateEvent() {
    eventBus.fire(RequireGroupInviteUpdateEvent());
  }
}
