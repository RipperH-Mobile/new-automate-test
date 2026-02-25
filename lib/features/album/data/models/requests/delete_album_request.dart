class DeleteAlbumRequest {
  final String albumId;
  final String roomId;

  DeleteAlbumRequest({
    required this.albumId,
    required this.roomId,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'roomId': roomId,
    };
  }
}
