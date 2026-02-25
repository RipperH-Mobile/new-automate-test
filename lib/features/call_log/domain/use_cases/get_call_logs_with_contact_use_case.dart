import 'dart:io';

import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/call_log/domain/helpers/call_log_related_data_helper.dart';
import 'package:uchat/features/call_log/domain/mappers/call_log_with_contact_mapper.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_param.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_server_repository.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetCallLogsWithContactUseCaseParams {
  final int page;
  final int pageSize;
  final CallActionType? callActionType;

  GetCallLogsWithContactUseCaseParams({
    required this.page,
    this.pageSize = 50,
    this.callActionType,
  });
}

class GetCallLogsWithContactUseCase
    extends SimpleUseCase<PaginationPayload<CallLogWithContactEntity>, GetCallLogsWithContactUseCaseParams> {
  final CallLogServerRepository callLogServerRepository;
  final CallLogLocalRepository callLogLocalRepository;
  final CallLogRelatedDataHelper relatedDataHelper;

  GetCallLogsWithContactUseCase({
    required this.callLogServerRepository,
    required this.callLogLocalRepository,
    required this.relatedDataHelper,
  });

  @override
  Future<PaginationPayload<CallLogWithContactEntity>> call(GetCallLogsWithContactUseCaseParams params) async {
    try {
      // Fetch call logs from the server based on the provided parameters
      final response = await callLogServerRepository.getCallLogs(
        GetCallLogsParam(
          page: params.page,
          pageSize: params.pageSize,
          callActionType: params.callActionType,
        ),
      );

      final callLogs = response.data?.toList() ?? [];

      if (params.callActionType == null) {
        // Clear stale local data on first page before saving fresh data
        if (params.page == 1 && callLogs.isNotEmpty) {
          await callLogLocalRepository.clearCallLogs();
        }

        // Only save to local DB when not filtering by call action type, to avoid mixing different types of logs in local storage.
        await callLogLocalRepository.saveCallLogs(callLogs);
      }

      final (rooms, contacts) = await getRelatedData(callLogs);

      return PaginationPayload<CallLogWithContactEntity>(
        page: response.page,
        pageSize: response.pageSize,
        total: response.total,
        totalPages: response.totalPages,
        data: CallLogWithContactMapper.fromCallLogs(
          callLogs: callLogs,
          contacts: contacts,
          rooms: rooms,
        ),
      );
    } on FailedHostLookupException catch (_) {
      // Network unavailable – fallback to local DB
      return _loadFromLocal();
    } on SocketException catch (_) {
      // Network unavailable – fallback to local DB
      return _loadFromLocal();
    }
  }

  Future<PaginationPayload<CallLogWithContactEntity>> _loadFromLocal() async {
    final callLogs = await callLogLocalRepository.getAllCallLogs();

    final (rooms, contacts) = await getRelatedData(callLogs);

    return PaginationPayload<CallLogWithContactEntity>(
      page: 1,
      pageSize: callLogs.length,
      total: callLogs.length,
      totalPages: 1,
      data: CallLogWithContactMapper.fromCallLogs(
        callLogs: callLogs,
        contacts: contacts,
        rooms: rooms,
      ),
    );
  }

  Future<(List<RoomEntity>, List<ContactEntity>)> getRelatedData(List<CallLogEntity> callLogs) =>
      relatedDataHelper.getRelatedData(callLogs);
}
