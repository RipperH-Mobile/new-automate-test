import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RemoveAccountFromLocalParams {
  final String accountId;

  RemoveAccountFromLocalParams({
    required this.accountId,
  });
}

class RemoveAccountFromLocalUseCase extends SimpleUseCase<void, RemoveAccountFromLocalParams> {
  final UserLocalRepository userLocalRepository;

  RemoveAccountFromLocalUseCase({required this.userLocalRepository});

  @override
  Future<void> call(RemoveAccountFromLocalParams params) async {
    await userLocalRepository.deleteUserById(params.accountId);
  }
}
