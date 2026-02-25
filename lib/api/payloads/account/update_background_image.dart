import 'dart:io';

import 'package:dio/dio.dart';

class UpdateBackgroundImageRequest {
  File file;

  UpdateBackgroundImageRequest({
    required this.file,
  });

  Future<FormData> toFormData() async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });

    return formData;
  }
}
