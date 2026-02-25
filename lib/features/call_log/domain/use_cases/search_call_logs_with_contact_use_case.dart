import 'dart:math';

import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/extensions/list_extension.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_param.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/call_log/domain/helpers/call_log_related_data_helper.dart';
import 'package:uchat/features/call_log/domain/mappers/call_log_with_contact_mapper.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

const _kApiIdLimit = 50;
const _kLocalSearchLimit = 500;

class SearchCallLogsWithContactUseCaseParams {
  final String keyword;
  final int page;
  final int pageSize;

  SearchCallLogsWithContactUseCaseParams({
    required this.keyword,
    required this.page,
    this.pageSize = 50,
  });
}

class SearchCallLogsWithContactUseCase
    extends SimpleUseCase<PaginationPayload<CallLogWithContactEntity>, SearchCallLogsWithContactUseCaseParams> {
  final CallLogServerRepository callLogServerRepository;
  final CallLogRelatedDataHelper relatedDataHelper;

  SearchCallLogsWithContactUseCase({
    required this.callLogServerRepository,
    required this.relatedDataHelper,
  });

  @override
  Future<PaginationPayload<CallLogWithContactEntity>> call(SearchCallLogsWithContactUseCaseParams params) async {
    final (contacts, rooms) = await relatedDataHelper.searchRelatedData(
      params.keyword,
      limit: _kLocalSearchLimit,
    );

    // Extract contact IDs to search for call logs
    final contactIds = contacts.map((e) => e.id ?? '').where((id) => id.isNotEmpty).toList();

    // Extract room IDs to search for call logs
    final roomIds = rooms.map((e) => e.id).toList();

    // Split IDs into chunks of _kApiIdLimit to respect API limits
    final accountIdChunks = contactIds.chunks(_kApiIdLimit);
    final roomIdChunks = roomIds.chunks(_kApiIdLimit);

    if (accountIdChunks.isEmpty && roomIdChunks.isEmpty) {
      // No contacts or rooms found, return empty result
      return PaginationPayload<CallLogWithContactEntity>(
        page: params.page,
        pageSize: params.pageSize,
        total: 0,
        totalPages: 0,
        data: [],
      );
    }

    final maxChunks = max(
      accountIdChunks.isEmpty ? 1 : accountIdChunks.length,
      roomIdChunks.isEmpty ? 1 : roomIdChunks.length,
    );

    // Iterate through chunks sequentially; return as soon as a chunk yields results
    for (var i = 0; i < maxChunks; i++) {
      final chunkAccountIds = i < accountIdChunks.length ? accountIdChunks[i] : null;
      final chunkRoomIds = i < roomIdChunks.length ? roomIdChunks[i] : null;

      final response = await callLogServerRepository.getCallLogs(
        GetCallLogsParam(
          page: params.page,
          pageSize: params.pageSize,
          accountIds: chunkAccountIds,
          roomIds: chunkRoomIds,
        ),
      );

      if (response.data?.isNotEmpty == true) {
        return PaginationPayload<CallLogWithContactEntity>(
          page: response.page,
          pageSize: response.pageSize,
          total: response.total,
          totalPages: response.totalPages,
          data: CallLogWithContactMapper.fromCallLogs(
            callLogs: response.data!.toList(),
            contacts: contacts,
            rooms: rooms,
          ),
        );
      }
    }

    // All chunks returned empty
    return PaginationPayload<CallLogWithContactEntity>(
      page: params.page,
      pageSize: params.pageSize,
      total: 0,
      totalPages: 0,
      data: [],
    );
  }
}
