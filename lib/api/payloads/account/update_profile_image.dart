import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProfileImageRequest {
  File file;

  UpdateProfileImageRequest({
    required this.file,
  });

  Future<FormData> toFormData() async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });

    return formData;
  }
}

class UpdateProfileImageResponse {
  String avatarId;
  String avatarBlurhash;

  UpdateProfileImageResponse({
    required this.avatarId,
    required this.avatarBlurhash,
  });

  static UpdateProfileImageResponse fromMap(Map<String, dynamic> data) {
    return UpdateProfileImageResponse(
      avatarId: data['avatarId'],
      avatarBlurhash: data['avatarBlurhash'],
    );
  }
}
