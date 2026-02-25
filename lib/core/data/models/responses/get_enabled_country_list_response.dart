import 'package:uchat/core/domain/entities/enabled_country_list_entity.dart';

class GetEnabledCountryListResponse {
  List<String> countryEnabled;

  GetEnabledCountryListResponse({
    required this.countryEnabled,
  });

  factory GetEnabledCountryListResponse.fromMap(Map<String, dynamic> json) {
    final countryEnabled = <String>[];

    if (json['countryEnabled'] != null && json['countryEnabled'] is List) {
      for (final country in json['countryEnabled']) {
        countryEnabled.add(country);
      }
    }

    return GetEnabledCountryListResponse(countryEnabled: countryEnabled);
  }

  EnabledCountryListEntity toEntity() {
    return EnabledCountryListEntity(countryEnabled: countryEnabled);
  }
}
