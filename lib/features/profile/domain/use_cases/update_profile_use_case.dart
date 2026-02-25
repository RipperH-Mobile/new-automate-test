import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdateProfileUseCase extends SimpleUseCase<ProfileEntity, String> {
  final ProfileServerRepository profileServerRepository;
  final ProfileLocalRepository profileLocalRepository;

  UpdateProfileUseCase({
    required this.profileServerRepository,
    required this.profileLocalRepository,
  });

  @override
  Future<ProfileEntity> call(String accountId) async {
    final serverProfile = await profileServerRepository.getProfile(accountId);
    await profileLocalRepository.updateProfile(serverProfile);
    return serverProfile;
  }
}
