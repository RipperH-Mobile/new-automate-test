class OAQRVerifyTokenRequest {
  final String token;

  OAQRVerifyTokenRequest({
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'qrToken': token,
    };
  }
}
