import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetUserCountParams {
  final bool includeHiddenAccount;

  GetUserCountParams({this.includeHiddenAccount = true});
}

class GetUserCountUseCase extends SimpleUseCase<int, GetUserCountParams> {
  final UserLocalRepository userLocalRepository;

  GetUserCountUseCase({required this.userLocalRepository});

  @override
  Future<int> call(GetUserCountParams params) async {
    return await userLocalRepository.getUserCount(includeHiddenAccount: params.includeHiddenAccount);
  }
}
