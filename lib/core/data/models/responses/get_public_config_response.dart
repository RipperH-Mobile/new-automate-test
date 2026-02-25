import 'package:uchat/core/domain/entities/public_config_entity.dart';

class GetPublicConfigResponse {
  String? helpCenterId;
  String? oaSystemAccountId;

  GetPublicConfigResponse({
    required this.helpCenterId,
    required this.oaSystemAccountId,
  });

  factory GetPublicConfigResponse.fromMap(Map<String, dynamic> json) {
    return GetPublicConfigResponse(
      helpCenterId: json['helpCenterId'],
      oaSystemAccountId: json['oaSystemAccountId'],
    );
  }

  PublicConfigEntity toEntity() {
    return PublicConfigEntity(
      helpCenterId: helpCenterId,
      oaSystemAccountId: oaSystemAccountId,
    );
  }
}
