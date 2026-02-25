class CreateAlbumRequest {
  final String albumName;
  final String roomId;
  final bool isCreateOnly;

  CreateAlbumRequest({
    required this.albumName,
    required this.roomId,
    this.isCreateOnly = true,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'albumName': albumName,
      'roomId': roomId,
      'isCreateOnly': isCreateOnly,
    };
  }
}
