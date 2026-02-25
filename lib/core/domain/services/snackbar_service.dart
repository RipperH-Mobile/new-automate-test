import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';

import '../../infrastructure/notification/common/notification_entity.dart';

abstract class SnackbarService {
  SnackbarController showNotification({
    required NotificationEntity notification,
    OnTap? onTap,
    void Function()? onShow,
  });
}
