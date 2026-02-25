import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/add_contact/domain/use_cases/approve_group_requested_use_case.dart';
import 'package:uchat/features/add_contact/domain/use_cases/reject_group_requested_use_case.dart';
import 'package:uchat/features/contact/data/models/requests/approve_group_requested_request.dart';
import 'package:uchat/features/contact/data/models/requests/reject_group_requested_request.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class ChatRoomHelper {
  static Future<void> handleGroupRequestApproval(String requestId) async {
    final useCase = GetIt.I<ApproveGroupRequestedUseCase>().call(ApproveGroupRequestedRequest(
      requestId: requestId,
    ));

    await _errorHandlerHelper(() async {
      await useCase;
    });
  }

  static Future<void> handleGroupRequestRejection(String requestId) async {
    final useCase = GetIt.I<RejectGroupRequestedUseCase>().call(RejectGroupRequestedRequest(
      requestId: requestId,
    ));

    await _errorHandlerHelper(
      () async {
        await useCase;
      },
      isRejection: true,
    );
  }

  static Future<void> _errorHandlerHelper(
    Future<void> Function() task, {
    bool isRejection = false,
  }) async {
    try {
      UChatLoading.show();
      await task.call();
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      _log.e('ChatRoomHelper on ApiException error (${isRejection ? 'Rejection' : 'Approval'}).', e, stackTrace);
      if (e.code == 403 || e.type == 'ERR_PERMISSION_DENIED') {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else if (e.code == 404 || e.type == 'ERR_ROOM_MEMBER_REQUEST_NOT_FOUND') {
        UChatNewDialog.showRequestNotFoundDialog(context: Get.context!);
      } else {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
      }
    } catch (e, stackTrace) {
      _log.e('ChatRoomHelper error (${isRejection ? 'Rejection' : 'Approval'}).', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    } finally {
      await UChatLoading.hide();
    }
  }
}
