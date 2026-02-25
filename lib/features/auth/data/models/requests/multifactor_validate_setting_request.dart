class MultifactorValidateSettingRequest {
  final bool enableMultiFactor;

  MultifactorValidateSettingRequest({
    required this.enableMultiFactor,
  });

  Map<String, dynamic> toJson() {
    return {
      'enableMultiFactor': enableMultiFactor,
    };
  }
}
