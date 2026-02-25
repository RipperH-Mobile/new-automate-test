class AlbumImageUploadingResponse {
  bool? uploadStatus;
  int? nextIndexing;
  String? taskId;
  String? albumId;
  String? imageId;

  AlbumImageUploadingResponse({
    required this.uploadStatus,
    required this.nextIndexing,
    required this.taskId,
    required this.albumId,
    required this.imageId,
  });

  factory AlbumImageUploadingResponse.fromMap(Map<String, dynamic> json) {
    return AlbumImageUploadingResponse(
      uploadStatus: json['uploadStatus'],
      nextIndexing: json['nextIndexing'],
      taskId: json['taskId'],
      albumId: json['albumId'],
      imageId: json['imageId'],
    );
  }
}
