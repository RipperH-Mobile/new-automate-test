class UpdateDisplayNameRequest {
  String displayName;

  UpdateDisplayNameRequest({
    required this.displayName,
  });

  Map<String, dynamic> toMap() {
    return {'displayName': displayName};
  }
}
