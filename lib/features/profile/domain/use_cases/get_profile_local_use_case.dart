import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetProfileLocalUseCase extends SimpleUseCase<ProfileEntity?, String> {
  final ProfileLocalRepository profileLocalRepository;

  GetProfileLocalUseCase({
    required this.profileLocalRepository,
  });

  @override
  Future<ProfileEntity?> call(String accountId) async {
    return profileLocalRepository.getContact(accountId);
  }
}
