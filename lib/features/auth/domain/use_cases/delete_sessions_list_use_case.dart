import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteSessionsListUseCase extends SimpleUseCase<void, String> {
  final AuthServerRepository authServerRepository;

  DeleteSessionsListUseCase({required this.authServerRepository});

  @override
  Future<void> call(String params) async {
    return await authServerRepository.deleteSessionsList(params);
  }
}
