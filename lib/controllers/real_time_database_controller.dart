import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/app_env.dart';

class RealTimeDatabaseController extends GetxController {
  static RealTimeDatabaseController get instance => Get.find();

  final firebaseApp = Firebase.app();

  final onlineUsers = <String, dynamic>{}.obs;
  StreamSubscription? _onlineUsersSubscription;
  FirebaseDatabase? realTimeDatabaseOnlineUsers;

  void onInitOnlineStatusUser() async {
    realTimeDatabaseOnlineUsers = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: AppEnv.firebaseOnlineStatusDbUrl,
    );
    final starCountRef = realTimeDatabaseOnlineUsers?.ref(UChatConstant.refOnlineUsers);
    _onlineUsersSubscription?.cancel();
    _onlineUsersSubscription = starCountRef?.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data is Map) {
        onlineUsers.assignAll(Map<String, dynamic>.from(data));
      } else if (data == null) {
        onlineUsers.assignAll({});
      }
    }, onError: (e) {
      useLogger().e('realTimeDatabaseOnlineUsers : error can not fetch from firebase : $e');
    });

    super.onInit();
  }

  @override
  void onClose() {
    _onlineUsersSubscription?.cancel();
    super.onClose();
  }
}
