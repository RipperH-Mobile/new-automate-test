import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/add_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingHelpCenterController extends GetxController {
  final isFriend = false.obs;
  final roomDb = GetIt.I<RoomDb>();
  final roomMemberDb = GetIt.I<RoomMemberDb>();
  final hasIdHelpCenter = false.obs;
  String? helpCenterAccountId = '';

  @override
  void onInit() async {
    await AppSettingsController.instance.fetchPublicConfig();
    final res = await ConfigDb().general.getString(
          key: ConfigDb.getOAAccountIdConfigKey(),
        );
    if (res == null || res == '-') {
      isFriend.value = false;
    } else {
      hasIdHelpCenter.value = true;
      helpCenterAccountId = res;
      final helpCenterFriend = await GetIt.I<GetContactUseCase>().call(ContactParams(accountId: res));
      if (helpCenterFriend != null) {
        isFriend.value = helpCenterFriend.isFriend;
      }
    }

    super.onInit();
  }

  void handleBack() {
    Get.back();
  }

  Future<void> handleAddHelpCenter() async {
    try {
      UChatLoading.show();
      final res = await GetIt.I<AddContactUseCase>().call(
        AddContactRequest(friendAccountId: helpCenterAccountId!),
      );
      isFriend.value = res.contact.isFriend;
      await UChatLoading.hide();
      await handleOpenChatOA();
    } on ApiFriendLimitExceedException catch (_) {
      await UChatLoading.hide();
      await UChatNewDialog.showFriendLimitExceededDialog();
    } on ApiOfficialAccountLimitExceedException catch (_) {
      await UChatLoading.hide();
      await UChatNewDialog.showOfficialAccountLimitExceededDialog();
    } on ApiException catch (e, stackTrace) {
      await UChatLoading.hide();
      _log.w('handleAdd Help Center Fail on ApiException', e, stackTrace);
      UChatDialog.showExceptionDialog(
        description: e.message.tr,
      );
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleAddHelpCenter error', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  Future<void> handleOpenChatOA() async {
    UChatLoading.show();

    final id = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(helpCenterAccountId ?? '');
    var room = await roomDb.getRoom(id ?? '');

    if (room == null) {
      final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
        OpenDirectChatRequest(friendAccountId: helpCenterAccountId!),
      );
      if (roomEntity == null) return;

      room = roomEntity.toCollection();
    }

    await UChatLoading.hide();

    Get.toNamed(
      Routes.chatRoomDirect.replaceAll(':id', room.id!),
      arguments: ChatRoomArguments(room: room),
    );
  }

  Future<void> handleContactHelpCenter() async {
    if (!isFriend.value) {
      await handleAddHelpCenter();
    } else {
      await handleOpenChatOA();
    }
  }
}
