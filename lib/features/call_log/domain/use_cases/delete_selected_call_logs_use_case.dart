import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

/// Deletes a specific set of call logs by their IDs from both server and local DB.
class DeleteSelectedCallLogsUseCase extends SimpleUseCase<void, List<String>> {
  final CallLogServerRepository callLogServerRepository;
  final CallLogLocalRepository callLogLocalRepository;

  DeleteSelectedCallLogsUseCase({
    required this.callLogServerRepository,
    required this.callLogLocalRepository,
  });

  @override
  Future<void> call(List<String> params) async {
    final ids = params.where((id) => id.isNotEmpty).toSet().toList();

    if (ids.isEmpty) {
      throw ArgumentError('callLogIds must not be empty');
    }

    await callLogServerRepository.deleteCallLogs(callLogIds: ids);
    await callLogLocalRepository.deleteAllCallLogs(ids);
  }
}
