import 'package:uchat/core/domain/entities/enabled_country_list_entity.dart';
import 'package:uchat/core/domain/repositories/core_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetEnabledCountryListUseCase extends SimpleUseCase<EnabledCountryListEntity, NoParams> {
  GetEnabledCountryListUseCase({
    required this.coreServerRepository,
  });

  final CoreServerRepository coreServerRepository;

  @override
  Future<EnabledCountryListEntity> call(NoParams params) {
    return coreServerRepository.getEnabledCountry();
  }
}
