class EnableMultiFactorRequest {
  String actionToken;
  bool? allowMultiFactor;

  EnableMultiFactorRequest({
    required this.actionToken,
    this.allowMultiFactor,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'actionToken': actionToken,
      'allowMultiFactor': allowMultiFactor,
    };
  }
}
