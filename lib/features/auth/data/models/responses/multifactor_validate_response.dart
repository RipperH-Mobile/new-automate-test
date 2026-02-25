import 'package:uchat/features/auth/domain/entities/multifactor_validate_entity.dart';

sealed class MultifactorValidateResponse {}

class MultifactorValidateTurnOffResponse extends MultifactorValidateResponse {
  final bool isGetOtp;

  MultifactorValidateTurnOffResponse({
    required this.isGetOtp,
  });

  factory MultifactorValidateTurnOffResponse.fromJson(Map<String, dynamic> json) {
    return MultifactorValidateTurnOffResponse(
      isGetOtp: json['isGetOtp'] ?? false,
    );
  }

  MultifactorValidateTurnOffEntity toEntity() {
    return MultifactorValidateTurnOffEntity(
      isGetOtp: isGetOtp,
    );
  }
}

class MultifactorValidateTurnOnResponse extends MultifactorValidateResponse {
  final String actionToken;
  final String actionName;

  MultifactorValidateTurnOnResponse({
    required this.actionToken,
    required this.actionName,
  });

  factory MultifactorValidateTurnOnResponse.fromJson(Map<String, dynamic> json) {
    return MultifactorValidateTurnOnResponse(
      actionToken: json['actionToken'],
      actionName: json['actionName'],
    );
  }

  MultifactorValidateTurnOnEntity toEntity() {
    return MultifactorValidateTurnOnEntity(
      actionToken: actionToken,
      actionName: actionName,
    );
  }
}
