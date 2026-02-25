import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllUsersParams {
  final bool includeHidden;
  final bool sortByLoginAt;

  GetAllUsersParams({this.includeHidden = false, this.sortByLoginAt = false});
}

class GetAllUsersUseCase extends SimpleUseCase<List<UserEntity>, GetAllUsersParams> {
  final UserLocalRepository userLocalRepository;

  GetAllUsersUseCase({
    required this.userLocalRepository,
  });

  @override
  Future<List<UserEntity>> call(GetAllUsersParams params) async {
    if (params.includeHidden) {
      return await userLocalRepository.getAllUsersIncludeHidden(sortedByLoginAt: params.sortByLoginAt);
    } else {
      return await userLocalRepository.getAllUsers(sortedByLoginAt: params.sortByLoginAt);
    }
  }
}
