import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/routes/app_pages.dart';

// This observer is used to handle the navigation events specifically for chat rooms.
class ChatRoomNavigatorObserver extends NavigatorObserver {
  // [route] is the route that is being popped.
  // [previousRoute] is the route that is being navigated to after popping.
  @override
  void didPop(Route route, Route? previousRoute) {
    // When popping from another screen to chat room screen.
    if (previousRoute?.settings.name?.startsWith(Routes.chatRoomRoot) == true) {
      final tag = 'chat-room-${previousRoute?.settings.name?.split('/').last}';
      if (Get.isRegistered<MessageListController>(tag: tag)) {
        final ctl = Get.find<MessageListController>(tag: tag);
        if (ctl.messages.isNotEmpty) {
          // Use addPostFrameCallback to ensure the UI is built / refresh with new message before execute the logic.
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            // Get the latest visible message because message list observer isn't triggered when popping to the chat room.
            final result = await ctl.listObserverController.dispatchOnceObserve();
            if (result.observeResult == null) return;
            final indexRange = ctl.convertListToVisibleRange(result.observeResult!.displayingChildIndexList);
            if (indexRange == null) return;
            final item1 = ctl.messages.elementAtOrNull(indexRange.$1);
            final item2 = ctl.messages.elementAtOrNull(indexRange.$2);
            if (item1 == null || item2 == null) return;
            // Trigger read message with the latest visible message range
            ctl.triggerReadMessage(borderMessage: (item1, item2));
          });
        }
      }
    }

    super.didPop(route, previousRoute);
  }
}
