import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class CreateGroupChatRequest {
  final String groupName;
  final List<ContactCollection>? selectedContactList;
  final String? defaultPhotoName;
  final File? groupPhotoFile;

  CreateGroupChatRequest({
    required this.groupName,
    this.selectedContactList,
    this.defaultPhotoName,
    this.groupPhotoFile,
  });

  Future<FormData> toFormData() async {
    Map<String, dynamic> data = {
      'roomName': groupName.trim(),
    };

    if (selectedContactList != null) {
      List<String> friendList = [];
      for (final contact in selectedContactList!) {
        if (contact.id != null) {
          friendList.add('"${contact.id!}"');
        }
      }

      data['friendAccountIds'] = friendList.toString();
    }

    if (defaultPhotoName != null && defaultPhotoName!.isNotEmpty) {
      data['defaultPhotoName'] = defaultPhotoName?.trim();
    }

    final formData = FormData.fromMap(data);

    if (groupPhotoFile != null && groupPhotoFile?.path.isNotEmpty == true) {
      final avatarFile = await MultipartFile.fromFile(groupPhotoFile!.path);
      formData.fields.add(const MapEntry('noPhotoUpload', 'false'));
      formData.files.add(MapEntry('avatar', avatarFile));
    } else {
      formData.fields.add(const MapEntry('noPhotoUpload', 'true'));
      formData.files.add(MapEntry('avatar', MultipartFile.fromString('', filename: 'noUpload')));
    }

    return formData;
  }
}
