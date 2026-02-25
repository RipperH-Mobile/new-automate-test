class ShareImageFromAlbumRequest {
  String albumId;
  List<String> imageIds;
  List<String> targetRoomIds;

  ShareImageFromAlbumRequest({
    required this.albumId,
    required this.imageIds,
    required this.targetRoomIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'imageIds': imageIds,
      'targetRoomIds': targetRoomIds,
    };
  }
}
