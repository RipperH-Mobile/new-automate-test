class RenameAlbumRequest {
  final String albumId;
  final String newAlbumName;

  RenameAlbumRequest({
    required this.albumId,
    required this.newAlbumName,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'albumName': newAlbumName,
    };
  }
}
