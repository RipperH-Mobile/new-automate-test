import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/update_room_invite_link_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_invite_link_setting_argument.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class ChatRoomDetailGroupInviteLinkSettingController extends GetxController {
  late String roomId;
  InviteLinkStatus inviteLinkStatus = InviteLinkStatus.on;
  InviteLinkStatus selectedInviteLinkStatus = InviteLinkStatus.on;

  bool get isChanged => inviteLinkStatus != selectedInviteLinkStatus;

  @override
  onInit() {
    super.onInit();

    if (Get.arguments is! ChatRoomDetailInviteLinkSettingArgument) {
      Get.back();
    } else {
      final args = Get.arguments as ChatRoomDetailInviteLinkSettingArgument;
      roomId = args.roomId;
      inviteLinkStatus = args.inviteLinkStatus;
      selectedInviteLinkStatus = inviteLinkStatus;
    }
  }

  void onSelectInviteLinkStatus(InviteLinkStatus? status) {
    if (status != null) {
      selectedInviteLinkStatus = status;
      update();
    }
  }

  Future<void> onDoneSettingInviteLink() async {
    try {
      UChatLoading.show();

      final result = await GetIt.I<UpdateRoomInviteLinkUseCase>().call(
        UpdateRoomInviteLinkParams(roomId: roomId, enable: selectedInviteLinkStatus),
      );

      if (result == null) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      }

      inviteLinkStatus = selectedInviteLinkStatus;
      Get.back(result: result);
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        _log.e('Failed to update invite link status', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
      }
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('Failed to update invite link status', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('Failed to update invite link status', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e as Exception);
    } finally {
      UChatLoading.hide();
    }
  }
}
