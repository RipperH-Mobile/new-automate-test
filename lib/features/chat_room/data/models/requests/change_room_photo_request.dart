import 'dart:io';

import 'package:dio/dio.dart';

class ChangeRoomPhotoRequest {
  final File file;
  final String roomId;

  ChangeRoomPhotoRequest({
    required this.file,
    required this.roomId,
  });

  Future<FormData> toFormData() async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });

    return formData;
  }
}
