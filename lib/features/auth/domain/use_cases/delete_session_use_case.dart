import 'package:uchat/features/auth/data/models/requests/delete_session_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteSessionUseCase extends SimpleUseCase<void, DeleteSessionRequest> {
  final AuthServerRepository authServerRepository;

  DeleteSessionUseCase({required this.authServerRepository});

  @override
  Future<void> call(DeleteSessionRequest params) async {
    return await authServerRepository.deleteSession(params);
  }
}
