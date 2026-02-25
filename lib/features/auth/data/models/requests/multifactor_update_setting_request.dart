class MultifactorUpdateSettingRequest {
  final String actionToken;
  final bool enableMultiFactor;

  MultifactorUpdateSettingRequest({
    required this.actionToken,
    required this.enableMultiFactor,
  });

  Map<String, dynamic> toJson() {
    return {
      'actionToken': actionToken,
      'enableMultiFactor': enableMultiFactor,
    };
  }
}
