import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/call_log/data/data_source/remote/call_log_api_service.dart';
import 'package:uchat/features/call_log/data/data_source/remote/call_log_socket_service.dart';
import 'package:uchat/features/call_log/data/models/mapper/call_log_mapper.dart';
import 'package:uchat/features/call_log/data/models/requests/delete_call_log_request.dart';
import 'package:uchat/features/call_log/data/models/requests/get_call_log_request.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_param.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_server_repository.dart';

class CallLogServerRepositoryImpl implements CallLogServerRepository {
  final SocketCaller socketCaller;
  final CallLogApiService callLogApiService;
  final CallLogSocketService callLogSocketService;
  final LoggerService log;

  CallLogServerRepositoryImpl({
    required this.socketCaller,
    required this.callLogApiService,
    required this.callLogSocketService,
    required this.log,
  });

  @override
  Future<int> deleteCallLogs({List<String>? callLogIds}) async {
    final request = DeleteCallLogRequest(callLogIds: callLogIds);

    if (socketCaller.isReadyForCall) {
      try {
        final socketResponse = await callLogSocketService.deleteCallLogs(request);
        if (socketResponse == null) {
          throw NullResponseException();
        }
        return socketResponse.totalDeleted;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        log.w('deleteCallLogs via socket', e, stackTrace);
      }
    }

    try {
      final apiResponse = await callLogApiService.deleteCallLogs(request);
      if (apiResponse == null) {
        throw NullResponseException();
      }
      return apiResponse.totalDeleted;
    } catch (e, stackTrace) {
      log.e('deleteCallLogs via API', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<PaginationPayload<CallLogEntity>> getCallLogs(GetCallLogsParam param) async {
    final request = GetCallLogRequest(
      page: param.page,
      pageSize: param.pageSize,
      callActionType: param.callActionType,
      accountIds: param.accountIds,
      roomIds: param.roomIds,
    );

    if (socketCaller.isReadyForCall) {
      try {
        final socketResponse = await callLogSocketService.getCallLogs(request);
        if (socketResponse == null) {
          throw NullResponseException();
        }
        return socketResponse.toEntity<CallLogEntity>(
          (data) => CallLogMapper.toEntities(data),
        );
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        log.w('getCallLogs via socket', e, stackTrace);
      }
    }

    try {
      final apiResponse = await callLogApiService.getCallLogs(request);
      if (apiResponse == null) {
        throw NullResponseException();
      }
      return apiResponse.toEntity<CallLogEntity>(
        (data) => CallLogMapper.toEntities(data),
      );
    } catch (e, stackTrace) {
      log.e('getCallLogs via API', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }
}
