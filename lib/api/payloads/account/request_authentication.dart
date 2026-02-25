class AuthenticationRequest {
  String? password;
  final String? actionName;
  bool? isRemoveAccount;

  AuthenticationRequest({
    this.password,
    this.actionName,
    this.isRemoveAccount,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'actionName': actionName,
      'isRemoveAccount': isRemoveAccount,
    };
  }
}
