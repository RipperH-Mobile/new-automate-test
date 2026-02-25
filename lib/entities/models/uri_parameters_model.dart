class UriParametersModel {
  final DateTime expiryData;
  final String uniqConnectId;
  final String location;
  final String device;
  final String pin;
  final String salt;
  final String iv;

  UriParametersModel({
    required this.expiryData,
    required this.uniqConnectId,
    required this.location,
    required this.device,
    required this.pin,
    required this.salt,
    required this.iv,
  });

  factory UriParametersModel.fromMap(Map<String, dynamic> data) {
    return UriParametersModel(
      expiryData: data['expiryData'] != null
          ? DateTime.fromMillisecondsSinceEpoch(int.parse(data['expiryData']))
          : DateTime.now(),
      uniqConnectId: data['uniqConnectId'] ?? '',
      location: data['location'] ?? '',
      device: data['device'] ?? '',
      pin: data['pin'] ?? '',
      salt: data['salt'] ?? '',
      iv: data['iv'] ?? '',
    );
  }
}
