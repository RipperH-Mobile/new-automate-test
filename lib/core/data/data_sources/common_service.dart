import 'dart:async';

import 'package:uchat/api/api.dart';
import 'package:uchat/core/data/models/responses/get_enabled_country_list_response.dart';
import 'package:uchat/core/data/models/responses/get_public_config_response.dart';

class CommonService {
  final HttpCaller httpCaller;

  CommonService({
    required this.httpCaller,
  });

  /// ServiceMethod: upload profile image
  Future<GetEnabledCountryListResponse?> getInfo() async {
    final httpResp = await httpCaller.get(
      BackendPath.getInfo.http,
    );

    return httpResp.mapToResponse<GetEnabledCountryListResponse>(
      (data) => GetEnabledCountryListResponse.fromMap(data),
    );
  }

  Future<GetPublicConfigResponse?> getPublicConfig() async {
    final httpResp = await httpCaller.get(
      BackendPath.getPublicConfig.http,
    );

    return httpResp.mapToResponse<GetPublicConfigResponse>(
      (data) => GetPublicConfigResponse.fromMap(data),
    );
  }
}
