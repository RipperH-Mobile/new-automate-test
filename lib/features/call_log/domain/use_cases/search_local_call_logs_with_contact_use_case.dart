import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/call_log/domain/helpers/call_log_related_data_helper.dart';
import 'package:uchat/features/call_log/domain/mappers/call_log_with_contact_mapper.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_by_room_and_friend_ids_request.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

/// Parameters for searching local call logs associated with matched contacts/rooms.
class SearchLocalCallLogsWithContactUseCaseParams {
  final String keyword;
  final int limit;

  const SearchLocalCallLogsWithContactUseCaseParams({
    required this.keyword,
    this.limit = 50,
  });
}

/// Searches local call logs by resolving related contacts and rooms from a keyword,
/// then maps the result into [CallLogWithContactEntity].
class SearchLocalCallLogsWithContactUseCase
    extends SimpleUseCase<List<CallLogWithContactEntity>, SearchLocalCallLogsWithContactUseCaseParams> {
  final CallLogLocalRepository callLogLocalRepository;
  final CallLogRelatedDataHelper relatedDataHelper;

  SearchLocalCallLogsWithContactUseCase({
    required this.callLogLocalRepository,
    required this.relatedDataHelper,
  });

  @override
  Future<List<CallLogWithContactEntity>> call(SearchLocalCallLogsWithContactUseCaseParams params) async {
    // Normalize input and skip work for empty keyword.
    final keyword = params.keyword.trim();
    if (keyword.isEmpty) return [];

    // Find related contacts/rooms first, then use their IDs to filter call logs.
    final (contacts, rooms) = await relatedDataHelper.searchRelatedData(keyword);

    final contactIds = contacts.map((e) => e.id ?? '').where((id) => id.isNotEmpty).toSet();
    final roomIds = rooms.map((e) => e.id).toSet();

    // No related targets means no possible call log matches.
    if (contactIds.isEmpty && roomIds.isEmpty) return [];

    // Query local call logs constrained by matched room IDs and friend IDs.
    final filtered = await callLogLocalRepository.getCallLogsByRoomAndFriendIds(
      GetCallLogsByRoomAndFriendIdsRequest(
        roomIds: roomIds.toList(),
        friendIds: contactIds.toList(),
        limit: params.limit,
      ),
    );

    if (filtered.isEmpty) return [];

    // Attach contact/room related data to each call log for presentation usage.
    return CallLogWithContactMapper.fromCallLogs(
      callLogs: filtered,
      contacts: contacts,
      rooms: rooms,
    );
  }
}
