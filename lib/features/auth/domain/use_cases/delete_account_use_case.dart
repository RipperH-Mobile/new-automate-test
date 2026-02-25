import 'package:uchat/api/payloads/account/delete_account.dart';
import 'package:uchat/entities/services/user_db.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteAccountUseCase extends SimpleUseCase<void, DeleteAccountRequest> {
  final AuthServerRepository authServerRepository;
  final UserDb userDb;

  DeleteAccountUseCase({
    required this.authServerRepository,
    required this.userDb,
  });

  @override
  Future<void> call(DeleteAccountRequest params) async {
    /// Delete account data on server
    await authServerRepository.deleteAccount(params);

    if (params.isarId != null) {
      /// Delete account data from local
      await userDb.deleteUser(params.isarId!);
    }
  }
}
