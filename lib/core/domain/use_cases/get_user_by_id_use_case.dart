import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetUserByIdParams {
  final String userId;

  GetUserByIdParams({required this.userId});
}

class GetUserByIdUseCase extends SimpleUseCase<UserEntity?, GetUserByIdParams> {
  final UserLocalRepository userLocalRepository;

  GetUserByIdUseCase({required this.userLocalRepository});

  @override
  Future<UserEntity?> call(GetUserByIdParams params) async {
    return await userLocalRepository.getUser(params.userId);
  }
}
