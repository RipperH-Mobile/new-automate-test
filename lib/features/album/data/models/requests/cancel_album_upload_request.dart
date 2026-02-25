class CancelAlbumUploadRequest {
  final String albumId;
  final String taskId;
  final String roomId;

  CancelAlbumUploadRequest({
    required this.albumId,
    required this.taskId,
    required this.roomId,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'taskId': taskId,
      'roomId': roomId,
    };
  }
}
