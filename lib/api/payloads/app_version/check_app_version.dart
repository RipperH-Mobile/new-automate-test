class CheckAppVersionRequest {
  final String appName;
  final String osName;
  final String version;

  CheckAppVersionRequest({
    this.appName = 'UCHAT_MESSENGER',
    required this.osName,
    required this.version,
  });

  Map<String, dynamic> toMap() {
    return {
      'appName': appName,
      'osName': osName,
      'version': version,
    };
  }
}

class CheckAppVersionResponse {
  final String appName;
  final String osName;
  final String version;
  final bool? isForceUpdate;

  CheckAppVersionResponse({
    required this.appName,
    required this.osName,
    required this.version,
    this.isForceUpdate,
  });

  static CheckAppVersionResponse fromMap(Map<String, dynamic> data) {
    return CheckAppVersionResponse(
      appName: data['appName'],
      osName: data['osName'],
      version: data['version'],
      isForceUpdate: data['isForceUpdate'],
    );
  }
}
