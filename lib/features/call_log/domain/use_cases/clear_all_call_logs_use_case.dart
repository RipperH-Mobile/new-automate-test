import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

/// Clears all call logs from both server and local DB.
class ClearAllCallLogsUseCase extends SimpleUseCase<void, NoParams> {
  final CallLogServerRepository callLogServerRepository;
  final CallLogLocalRepository callLogLocalRepository;

  ClearAllCallLogsUseCase({
    required this.callLogServerRepository,
    required this.callLogLocalRepository,
  });

  @override
  Future<void> call(NoParams params) async {
    await callLogServerRepository.deleteCallLogs();
    await callLogLocalRepository.clearCallLogs();
  }
}
