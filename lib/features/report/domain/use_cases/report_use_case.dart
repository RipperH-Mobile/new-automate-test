import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reactions_in_room_request.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_reactions_by_room_id_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/params/leave_group_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/leave_group_use_case.dart';
import 'package:uchat/features/contact/domain/params/block_contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';
import 'package:uchat/features/report/data/models/enum/report_topic.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';
import 'package:uchat/features/report/data/models/report_response.dart';
import 'package:uchat/features/report/domain/entities/report_entity.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

import '../repositories/report_repository.dart';

final _log = useLogger();

class ReportUseCase {
  final ReportRepository reportRepository;

  ReportUseCase({required this.reportRepository});

  ReportEntity reportEntity = ReportEntity(
    reportType: ReportType.reportUser,
  );

  initializeReportEntity(ReportType reportType) {
    reportEntity = ReportEntity(
      reportType: reportType,
    );
  }

  setReportTopic(ReportTopic topic) {
    reportEntity.reportTopic = topic;
  }

  setRemark(String remark) {
    reportEntity.remark = remark;
  }

  setReportType(ReportType reportType) {
    reportEntity.reportType = reportType;
  }

  setId(String? roomId, String? messageId, String? userId) {
    switch (reportEntity.reportType) {
      case ReportType.reportUser:
        reportEntity.userId = userId;
        break;
      case ReportType.reportGroup:
        reportEntity.roomId = roomId;
        break;
      case ReportType.reportMessage:
        reportEntity.userId = userId;
        reportEntity.roomId = roomId;
        reportEntity.messageId = messageId;
        break;
    }
  }

  Future<ReportResponse> sendReportTicket() async {
    return await reportRepository.sendReportTicket(request: reportEntity);
  }

  Future<void> blockFriend() async {
    try {
      if (reportEntity.userId != null) {
        GetIt.I<BlockContactUseCase>().call(
          BlockContactParams(
            contactIds: [reportEntity.userId!],
          ),
        );
      }
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleBlockUser error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  // leave group
  Future<void> leaveGroup() async {
    if (reportEntity.roomId == null) {
      return;
    }
    try {
        await GetIt.I<LeaveGroupUseCase>().call(LeaveGroupParams(
          roomId: reportEntity.roomId!,
          onRoomDeleted: (roomId) {
            eventBus.fire(RoomDeleteEvent(roomId: roomId));
          },
        ));
        await GetIt.I<RemoveReactionsByRoomIdUseCase>().call(
          RemoveReactionsByRoomIdRequest(
            roomId: reportEntity.roomId!,
          ),
        );
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleLeaveGroup error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }
}
