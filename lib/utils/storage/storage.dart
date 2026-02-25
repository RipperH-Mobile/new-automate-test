import 'dart:io';

import 'package:path_provider/path_provider.dart';

const nonLoggedInUserId = 'non-logged-in';

class UChatStorage {
  /// Singleton pattern
  static final UChatStorage instance = UChatStorage._internal();

  factory UChatStorage() => instance;

  UChatStorage._internal();

  /// Start class operation
  String _userId = nonLoggedInUserId;

  void setUserId(String value) {
    _userId = value;
  }

  void removeUserId() {
    _userId = nonLoggedInUserId;
  }

  Future<Directory> getRoomDirectory({
    required String roomId,
  }) async {
    // if (Get.isRegistered<PermissionController>()) {
    //   await PermissionController.instance
    //       .checkDirectoryApplicationSupportPermission();
    // }

    final supportDir = await getApplicationSupportDirectory();
    final path = '${supportDir.path}/${getRoomFolderPath(roomId)}';
    final dir = Directory(path);

    if (!await FileSystemEntity.isDirectory(path)) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    return dir;
  }

  String getRoomFolderPath(String roomId) {
    return '$_userId/rooms/$roomId';
  }
}
