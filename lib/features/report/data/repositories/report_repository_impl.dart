import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/report/data/data_sources/remote/report_api_service.dart';
import 'package:uchat/features/report/data/data_sources/remote/report_socket_service.dart';
import 'package:uchat/features/report/data/models/report_request.dart';
import 'package:uchat/features/report/data/models/report_response.dart';
import 'package:uchat/features/report/domain/entities/report_entity.dart';
import 'package:uchat/features/report/domain/repositories/report_repository.dart';

final _log = useLogger();

class ReportRepositoryImpl implements ReportRepository {
  ReportRepositoryImpl({
    required this.socketCaller,
    required this.reportApiService,
    required this.reportSocketService,
  });

  final SocketCaller socketCaller;
  final ReportApiService reportApiService;
  final ReportSocketService reportSocketService;

  @override
  Future<ReportResponse> sendReportTicket({
    required ReportEntity request,
  }) async {
    final ReportRequest reportRequest = ReportRequest(
      reportType: request.reportType,
      reportTopic: request.reportTopic!,
      remark: request.remark!,
      meta: ReportRequestMeta(
        roomId: request.roomId,
        messageId: request.messageId,
        userId: request.userId,
      ),
    );

    if (socketCaller.isReadyForCall) {
      try {
        final response = await reportSocketService.sendReportTicket(
          request: reportRequest,
        );

        return ReportResponse(ticketId: response.data['data']['ticketId']);
      } catch (e, stackTrace) {
        _log.w('openSupportTicket with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final response = await reportApiService.sendReportTicket(
      request: reportRequest,
    );

    return ReportResponse(ticketId: response.data['data']['ticketId']);
  }

  // @override
  // Future<void> blockFriend({required ReportEntity request}) async {
  //   final Map<String, dynamic> blockFriendRequest = {
  //     'friendAccountIds': [request.userId],
  //   };

  //   if (socketCaller.isConnected) {
  //     try {
  //       await reportSocketService.blockFriend(
  //         request: blockFriendRequest,
  //       );

  //       // TODO: Implement this
  //       // _expireAllSecretChatWithFriendId(request);

  //       return;
  //     } catch (e, stackTrace) {
  //       _log.w('blockContact with socket error. fallback to http request...', e, stackTrace);
  //     }
  //   }
  //   try {
  //     await reportApiService.blockFriend(
  //       request: blockFriendRequest,
  //     );
  //   } catch (e, stackTrace) {
  //     _log.w('blockContact with socket error. fallback to http request...', e, stackTrace);
  //   }

  //   // TODO: Implement this
  //   // _expireAllSecretChatWithFriendId(request);
  // }
}
