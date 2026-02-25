import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/call_log/domain/helpers/call_log_related_data_helper.dart';
import 'package:uchat/features/call_log/domain/mappers/call_log_with_contact_mapper.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetLocalCallLogsWithContactUseCaseParams {
  final int limit;
  final CallActionType? callActionType;

  const GetLocalCallLogsWithContactUseCaseParams({
    this.limit = 50,
    this.callActionType,
  });
}

class GetLocalCallLogsWithContactUseCase
    extends SimpleUseCase<List<CallLogWithContactEntity>, GetLocalCallLogsWithContactUseCaseParams> {
  final CallLogLocalRepository callLogLocalRepository;
  final CallLogRelatedDataHelper relatedDataHelper;

  GetLocalCallLogsWithContactUseCase({
    required this.callLogLocalRepository,
    required this.relatedDataHelper,
  });

  @override
  Future<List<CallLogWithContactEntity>> call(GetLocalCallLogsWithContactUseCaseParams params) async {
    final callLogs = await callLogLocalRepository.getAllCallLogs(
      limit: params.limit,
      callActionType: params.callActionType,
    );

    if (callLogs.isEmpty) return [];

    final (rooms, contacts) = await relatedDataHelper.getRelatedData(callLogs);

    return CallLogWithContactMapper.fromCallLogs(
      callLogs: callLogs,
      contacts: contacts,
      rooms: rooms,
    );
  }
}
