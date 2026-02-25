class AuthCodeVerifyTokenRequest {
  final String token;

  AuthCodeVerifyTokenRequest({
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }
}
