import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

enum StackPageType {
  editChat,
  sortingChat,
}

class EditChatModalController extends GetxController {
  final isShowStackPage = false.obs;
  final currentStackPageType = Rx<StackPageType?>(null);
  final sortingIndex = Rx<int>(-1);
  final dialogSize = (Get.height * 0.55).obs;
  final isEditChat = false.obs;

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  bool get isEnableChatFolder => UserController.instance.enableChatFolder;

  // ChatFolderController get chatFolderController => Get.find<ChatFolderController>();

  void handleEditChatList() {
    if (isMobile) {
      toggleFullDialogHeight();
      currentStackPageType(StackPageType.editChat);
      isShowStackPage(true);
    } else {
      Get.back(result: true);
    }
  }

  void handleChatListSorting() {
    toggleHalfDialogHeight();
    currentStackPageType(StackPageType.sortingChat);
    isShowStackPage(true);
  }

  // void handleChatManageFolder() {
  //   Get.back();
  //   chatFolderController.fetchChatFolders();
  //   Get.toNamed(Routes.chatFolder);
  // }
  //
  // void handleChatManageFolderDesktop() {
  //   UChatDialog.showCustomDialog<void, ChatFolderController>(
  //     child: (_) => const ChatFolderScreen(),
  //     init: ChatFolderController(),
  //     barrierDismissible: true,
  //     bgDialogColor: Colors.transparent,
  //     barrierColor: Colors.transparent,
  //   );
  // }

  void handleCancelStackPage() {
    isShowStackPage(false);
  }

  void toggleHalfDialogHeight() {
    dialogSize(Get.height * 0.55);
  }

  void toggleFullDialogHeight() {
    dialogSize(Get.height);
  }

  bool get isEditChatPage {
    return currentStackPageType() == StackPageType.editChat;
  }

  bool get isSortingChatPage {
    return currentStackPageType() == StackPageType.sortingChat;
  }
}
