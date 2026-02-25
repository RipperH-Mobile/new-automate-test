import 'package:get/get.dart';
import 'dart:io';
import 'package:uchat/core/domain/entities/user_entity.dart';

class TermController extends GetxController {
  // fields for phoneNumber & actionToken
  final Function onAccept;
  final currentUser = Rx<UserEntity?>(null);

  bool get isLoggedIn {
    return currentUser.value?.token != null;
  }

  TermController({
    required this.onAccept,
  });

  @override
  void onInit() {
    // getTermFromServer();
    super.onInit();
  }

  void handleAccept() async {
    onAccept();
  }

  void handleDecline() {
    if (isLoggedIn == true) {
      exit(0);
    } else {
      Get.close(2);
    }
  }
}
