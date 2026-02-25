import 'package:get/get.dart';
import 'package:uchat/features/notification_debug/presentation/controllers/notification_debug_controller.dart';

/// Binding for notification debug screens
/// 
/// This binding registers the NotificationDebugController and its dependencies
/// when navigating to notification debug screens.
class NotificationDebugBinding extends Bindings {
  @override
  void dependencies() {
    // Register the main controller
    Get.lazyPut<NotificationDebugController>(
      () => NotificationDebugController(),
    );
  }
}
