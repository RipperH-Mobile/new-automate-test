class DevicesManagerModel {
  String? sessionId;
  String? deviceBrand;
  String? deviceModel;
  String? deviceOS;
  String? deviceMarketingName;
  String? loginLocation;
  DateTime? lastLoginAt;

  DevicesManagerModel({
    this.sessionId,
    this.deviceBrand,
    this.deviceModel,
    this.deviceOS,
    this.deviceMarketingName,
    this.loginLocation,
    this.lastLoginAt,
  });

  factory DevicesManagerModel.fromMap(Map<String, dynamic> json) {
    return DevicesManagerModel(
      sessionId: json['_id'] ?? '',
      deviceBrand: json['meta']?['device']?['data']?['brand'] ?? json['meta']?['device']?['model'] ?? '',
      deviceModel: json['meta']?['device']?['model'] ?? '',
      deviceOS: json['meta']?['device']?['os'] ?? json['meta']?['device']?['data']?['systemName'] ?? '',
      deviceMarketingName: json['meta']?['device']?['data']?['utsname']?['machine'] ??
          json['meta']?['device']?['data']?['model'] ??
          json['meta']?['device']?['model'] ??
          '',
      loginLocation: json['meta']?['locationName'] ?? '',
      lastLoginAt: DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now().toUtc(),
    );
  }

  @override
  String toString() {
    return '[DevicesManagerModel]\n'
        'sessionId: $sessionId\n'
        'deviceBrand: $deviceBrand\n'
        'model: $deviceModel\n'
        'deviceOS: $deviceOS\n'
        'deviceMarketingName: $deviceMarketingName\n'
        'loginLocation: $loginLocation\n'
        'loginLocation: $loginLocation\n';
  }
}
