import 'package:uchat/core/domain/entities/public_config_entity.dart';
import 'package:uchat/core/domain/repositories/core_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetPublicConfigUseCase extends SimpleUseCase<PublicConfigEntity, NoParams> {
  GetPublicConfigUseCase({
    required this.coreServerRepository,
  });

  final CoreServerRepository coreServerRepository;

  @override
  Future<PublicConfigEntity> call(NoParams params) {
    return coreServerRepository.getPublicConfig();
  }
}
