import 'package:get/get.dart';
import 'package:uchat/controllers/announcement_controller.dart';
import 'package:uchat/controllers/app_controller.dart';
import 'package:uchat/controllers/app_settings_controller.dart';
import 'package:uchat/controllers/audio_controller.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/controllers/in_app_purchase_controller.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/controllers/real_time_database_controller.dart';
import 'package:uchat/controllers/subscription_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/controllers/user_interface_controller.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call_log/presentation/call_log_presentation.dart';
import 'package:uchat/features/central_notification/presentation/central_notification_presentation.dart';
import 'package:uchat/features/chat_folder/presentation/chat_folder_presentation.dart';
import 'package:uchat/features/chat_room_list/presentation/chat_room_list_presentation.dart';
import 'package:uchat/features/contact/presentation/contact_presentation.dart';
import 'package:uchat/features/home/home_barrel.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_controller.dart';
import 'package:uchat/screens/premium_packages/store/store_controller.dart';

import '../common/task_result.dart';

///
/// Register all permanent controllers.
/// Only register controllers that are used in the app.
/// Not include logic to work in this step.
///
Future<TaskResult> registerPermanentController() async {
  // Global controller ordering is important !!!
  // Get.put(PasscodeManagerController(), permanent: true);
  Get.put(RealTimeDatabaseController(), permanent: true);
  Get.put(AppController(), permanent: true);
  Get.put(UserController(), permanent: true);
  Get.put(InAppPurchaseController(), permanent: true);
  Get.put(AudioController(), permanent: true);
  Get.put(UChatCallController(), permanent: true);
  Get.put(AnnouncementController(), permanent: true);
  // Get.put(LifeCycleController(), permanent: true);
  // Get.put(NotificationManagerController(), permanent: true);
  Get.put(AppSettingsController(), permanent: true);
  Get.put(ConnectivityController(), permanent: true);
  Get.put(ChatListController(), permanent: true);
  Get.put(ContactsController(), permanent: true);
  Get.put(CentralNotificationController(), permanent: true);
  Get.put(StickerController(), permanent: true);
  Get.put(PermissionController(), permanent: true);
  Get.put(UserInterfaceController(), permanent: true);
  Get.put(SubscriptionController(), permanent: true);
  Get.put(ChatFolderController(), permanent: true);
  Get.put(ManageChatController(), permanent: true);

  /// These controllers are used in desktop or tablet only.
  // TODO: Move this controller to global controller folders.
  Get.put(PremiumPackagesStoreController(), permanent: true);
  Get.put(CallLogScreenController(), permanent: true);

  Get.put<HomeController>(HomeController(), permanent: true);

  return TaskResult.next;
}
