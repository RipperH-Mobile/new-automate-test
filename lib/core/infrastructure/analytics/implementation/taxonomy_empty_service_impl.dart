import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';

class TaxonomyEmptyServiceImpl implements TaxonomyService {
  @override
  Future<void> onAuthenticated(UserEntity? user,
      {int? officialAccountNumber, int? friendNumber, int? groupNumber}) async {}

  @override
  Future<void> onUnauthenticated() async {}

  @override
  Future<void> sendEvent(EventName eventName,
      {Map<String, dynamic>? eventProperties, bool sendImmediately = false}) async {}

  @override
  Future<void> setUser(UserEntity user,
      {Map<String, dynamic>? userProperties, int? officialAccountNumber, int? friendNumber, int? groupNumber}) async {}
}
