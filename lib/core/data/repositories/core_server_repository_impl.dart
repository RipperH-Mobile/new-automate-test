import 'package:uchat/core/data/data_sources/common_service.dart';
import 'package:uchat/core/domain/entities/enabled_country_list_entity.dart';
import 'package:uchat/core/domain/entities/public_config_entity.dart';
import 'package:uchat/core/domain/repositories/core_server_repository.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

class CoreServerRepositoryImpl implements CoreServerRepository {
  final CommonService commonService;

  CoreServerRepositoryImpl({
    required this.commonService,
  });

  final _log = useLogger();

  @override
  Future<EnabledCountryListEntity> getEnabledCountry() async {
    try {
      final httpResp = await commonService.getInfo();

      if (httpResp == null) throw NullResponseException('getEnabledCountry response is null');

      return httpResp.toEntity();
    } catch (e, stackTrace) {
      _log.e('getEnabledCountry error', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<PublicConfigEntity> getPublicConfig() async {
    try {
      final httpResp = await commonService.getPublicConfig();

      if (httpResp == null) throw NullResponseException('getPublicConfig response is null');

      return httpResp.toEntity();
    } catch (e, stackTrace) {
      _log.e('getPublicConfig error', e, stackTrace);
      rethrow;
    }
  }
}
