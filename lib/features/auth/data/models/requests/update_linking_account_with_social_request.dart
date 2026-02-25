class UpdateLinkingAccountWithSocialRequest {
  String token;
  String actionToken;

  UpdateLinkingAccountWithSocialRequest({
    required this.token,
    required this.actionToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'actionToken': actionToken,
    };
  }
}
