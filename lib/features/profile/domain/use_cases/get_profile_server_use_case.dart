import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetProfileServerUseCase extends SimpleUseCase<ProfileEntity?, String> {
  final ProfileServerRepository profileServerRepository;

  GetProfileServerUseCase({
    required this.profileServerRepository,
  });

  @override
  Future<ProfileEntity?> call(String accountId) async {
    return profileServerRepository.getProfile(accountId);
  }
}
