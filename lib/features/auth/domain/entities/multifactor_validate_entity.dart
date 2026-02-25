sealed class MultifactorValidateEntity {
  const MultifactorValidateEntity();
}

class MultifactorValidateTurnOffEntity extends MultifactorValidateEntity {
  final bool isGetOtp;

  const MultifactorValidateTurnOffEntity({
    required this.isGetOtp,
  });
}

class MultifactorValidateTurnOnEntity extends MultifactorValidateEntity {
  final String actionToken;
  final String actionName;

  const MultifactorValidateTurnOnEntity({
    required this.actionToken,
    required this.actionName,
  });
}
