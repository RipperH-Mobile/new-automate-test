class SetDefaultGroupAvatarRequest {
  final String roomId;
  final String fileName;

  SetDefaultGroupAvatarRequest({
    required this.roomId,
    required this.fileName,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'fileName': fileName,
    };
  }
}
