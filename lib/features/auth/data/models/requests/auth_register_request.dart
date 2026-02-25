import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uchat/utils/datetime.dart';

class AuthRegisterRequest {
  final String actionToken;
  final String displayName;
  final String username;
  final String password;
  final String phoneNumber;
  final String? email;
  final File? avatarPhotoFile;

  AuthRegisterRequest({
    required this.actionToken,
    required this.displayName,
    required this.username,
    required this.password,
    required this.phoneNumber,
    this.email,
    this.avatarPhotoFile,
  });

  Future<FormData> toFormData() async {
    Map<String, dynamic> data = {
      'actionToken': actionToken,
      'displayName': displayName,
      'username': username,
      'password': password,
      'phoneNumber': phoneNumber,
    };

    if (email != null) {
      data['email'] = email!;
    }

    final formData = FormData.fromMap(data);

    if (avatarPhotoFile != null && avatarPhotoFile?.path.isNotEmpty == true) {
      final avatarFile = await MultipartFile.fromFile(avatarPhotoFile!.path);
      formData.fields.add(const MapEntry('noPhotoUpload', 'false'));
      formData.files.add(MapEntry('avatar', avatarFile));
    } else {
      formData.fields.add(const MapEntry('noPhotoUpload', 'true'));
      formData.files.add(MapEntry('avatar', MultipartFile.fromString('', filename: 'noUpload')));
    }

    return formData;
  }
}

@Deprecated('This response is unused.')
class AuthRegisterResponse {
  bool? success;
  String? id;
  String? displayName;
  String? username;
  String? phoneNumber;
  String? token;
  String? avatarId;
  String? avatarBlurhash;
  bool? hiddenPhoneNumber;
  String? background;
  String? backgroundId;
  String? backgroundBlurhash;
  DateTime? lastEditUsernameAt;
  bool? enableCall;
  int? limitFriend;
  int? friendRequestCount;

  AuthRegisterResponse({
    this.success,
    this.id,
    this.displayName,
    this.username,
    this.phoneNumber,
    this.token,
    this.avatarBlurhash,
    this.avatarId,
    this.hiddenPhoneNumber,
    this.background,
    this.backgroundId,
    this.backgroundBlurhash,
    this.lastEditUsernameAt,
    this.enableCall,
    this.limitFriend,
    this.friendRequestCount,
  });

  factory AuthRegisterResponse.fromMap(Map<String, dynamic> json) {
    Map<String, dynamic> account = json['account'];

    return AuthRegisterResponse(
      success: json['success'],
      id: account['_id'],
      displayName: account['displayName'],
      username: account['username'],
      phoneNumber: account['phoneNumber'],
      token: json['token'],
      avatarId: account['avatarId'] ?? '',
      avatarBlurhash: account['avatarBlurhash'] ?? '',
      hiddenPhoneNumber: account['hiddenPhoneNumber'] ?? false,
      background: account['background'],
      backgroundId: account['backgroundId'],
      backgroundBlurhash: account['backgroundBlurhash'],
      lastEditUsernameAt: json['lastEditUsernameAt'] != null ? strToDateTime(json['lastEditUsernameAt']) : null,
      enableCall: account['enableCall'] ?? false,
      limitFriend: account['limitFriend'] ?? 100,
      friendRequestCount: account['friendRequestCount'] ?? 0,
    );
  }
}
