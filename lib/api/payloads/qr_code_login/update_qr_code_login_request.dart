class UpdateQrCodeLoginRequest {
  final String connectionKey;

  UpdateQrCodeLoginRequest({
    required this.connectionKey,
  });

  Map<String, dynamic> toJson() {
    return {'connectionKey': connectionKey};
  }
}
