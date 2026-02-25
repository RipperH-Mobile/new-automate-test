import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';

abstract class IsarBaseUtil {
  Isar get authDb {
    final isar = DbManager.instance.authenticatedInstance;
    if (isar == null || !isar.isOpen) {
      throw Exception(
        'Authenticated Isar Instance is not open! '
        'Please call CommonUtil.openApplication(WidgetTester); ',
      );
    }
    return isar;
  }

  Isar get generalDb {
    final isar = DbManager.instance.generalInstance;
    if (isar == null || !isar.isOpen) {
      throw Exception(
        'General Isar Instance is not open! '
        'Please call CommonUtil.openApplication(WidgetTester); ',
      );
    }
    return isar;
  }

  String get getUserId {
    final currentUserId = DbManager.instance.currentUserId;
    if (currentUserId != null) {
      return currentUserId;
    } else {
      return '';
    }
  }
}
