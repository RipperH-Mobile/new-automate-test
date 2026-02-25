import 'package:dio/dio.dart';

class UploadImageToAlbumRequest {
  int totalImages;
  int index;
  String taskId;
  String albumId;
  String filePath;
  CancelToken? cancelToken;

  UploadImageToAlbumRequest({
    required this.totalImages,
    required this.index,
    required this.taskId,
    required this.albumId,
    required this.filePath,
    this.cancelToken,
  });

  Future<FormData> toFormData() async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'totalImages': totalImages,
      'indexing': index,
      'taskId': taskId,
      'albumId': albumId,
    });

    return formData;
  }
}
