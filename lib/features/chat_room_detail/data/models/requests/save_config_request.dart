class SaveConfigRequest {
  final String key;
  final dynamic value;

  SaveConfigRequest({
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}
