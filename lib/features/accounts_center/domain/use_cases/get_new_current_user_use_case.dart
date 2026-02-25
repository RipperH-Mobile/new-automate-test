import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetNewCurrentUserUseCase extends SimpleUseCase<UserEntity?, NoParams>{
  final UserLocalRepository userLocalRepository;

  GetNewCurrentUserUseCase({required this.userLocalRepository});

  @override
  Future<UserEntity?> call(NoParams params) async {
    return await userLocalRepository.getNewCurrentUser();
  }
}