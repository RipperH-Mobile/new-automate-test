import 'package:get/get.dart';
import 'package:uchat/screens.dart';

class ChatRoomListEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatRoomListEditController>(ChatRoomListEditController());
  }
}
