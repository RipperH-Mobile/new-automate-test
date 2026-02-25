import 'package:uchat/core/domain/entities/enabled_country_list_entity.dart';
import 'package:uchat/core/domain/entities/public_config_entity.dart';

abstract class CoreServerRepository {
  Future<EnabledCountryListEntity> getEnabledCountry();

  Future<PublicConfigEntity> getPublicConfig();
}
