import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_dimensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/popup_menu/message_popup/views/message_popup.dart';

final _log = useLogger();

class MessagePopupController extends GetxController with GetTickerProviderStateMixin {
  final String tag;

  /// use [roomId] as tag
  MessagePopupController({required this.tag});

  final double paddingScreen = UChatDimensions.messagePadding;

  // padding from message container to popup menu
  final double defaultPadding = 10;

  Rx<OverlayState?> overlayState = Rx(null);
  Rx<OverlayEntry?> overlayEntry = Rx(null);
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;
  Size messageSize = Size.zero;

  Offset messageContainerOffset = Offset.zero;
  final topPopupOffset = Rx<Offset>(Offset.zero);
  final bottomPopupOffset = Rx<Offset>(Offset.zero);
  final messageOffset = Rx<Offset>(Offset.zero);

  double topPopupHeight = 0;
  double bottomPopupHeight = 0;
  AxisDirection direction = AxisDirection.right;

  bool expandedOverflow = false;

  final isShowPopupMenu = false.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 150),
    );
    curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  /// it will return [true] in case the popup menu is showing
  bool get isShowingMenu => overlayEntry.value != null;

  /// show popup menu
  /// if [isCurrentUserMessage] is true, then show popup menu on the right side of the message
  /// the [context] should be the context of message container, it use to get the size and offset of the message container
  /// [menuItems] is the list of menu item that will be shown in the popup menu
  /// if you want to hide the popup menu, just call [hideMenu] function inside the [onPressed] of [MessagePopupMenuItem] widget
  ///
  /// if there is some error, it will vibrate error, and show nothing

  void showMenu({
    required BuildContext messageContext,
    required Widget message,
    required Widget topPopup,
    required double topPopupHeight,
    Widget? bottomPopup,
    double? bottomPopupHeight,
    required AxisDirection direction,
  }) {
    try {
      isShowPopupMenu(true);
      overlayState.value = Overlay.of(messageContext);

      if (overlayEntry.value != null) {
        hideMenu(vibration: false);
      }

      this.topPopupHeight = topPopupHeight;
      this.direction = direction;
      if (bottomPopupHeight != null && bottomPopup != null) {
        this.bottomPopupHeight = bottomPopupHeight;
      }

      RenderBox messageRenderBox = messageContext.findRenderObject() as RenderBox;
      messageSize = messageRenderBox.size;
      messageContainerOffset = messageRenderBox.localToGlobal(Offset.zero);

      messageOffset.value = getOffsetMessage(
        direction: direction,
        messageOffset: messageContainerOffset,
      );
      topPopupOffset.value = getOffsetTopPopup(
        messageContainerSize: messageSize,
        messageContainerOffset: messageContainerOffset,
        direction: direction,
        topPopupHeight: topPopupHeight,
      );
      if (bottomPopupHeight != null && bottomPopup != null) {
        bottomPopupOffset.value = getOffsetBoottomPopup(
          messageOffset: messageContainerOffset,
          messageSize: messageSize,
          direction: direction,
          bottomPopupHeight: bottomPopupHeight,
        );
      }

      overlayEntry.value = OverlayEntry(
        builder: (context) => MessagePopup(
          message: message,
          bottomPopup: bottomPopup,
          topPopup: topPopup,
          direction: direction,
          onTabBackground: () => hideMenu(),
          roomIdTag: tag,
        ),
      );

      overlayState.value?.insert(overlayEntry.value!);

      GetIt.I<VibrateUtil>().vibrateSuccess();
      animationController.forward();
    } catch (e) {
      _log.d(e);
      GetIt.I<VibrateUtil>().vibrateError();
    }
  }

  /// hide popup menu
  /// if [vibration] is true, then vibrate light, default is true
  /// this function will check if [overlayEntry] is not null then remove it and make it null
  Future<void> hideMenu({
    bool vibration = true,
    bool delay = true,
  }) async {
    isShowPopupMenu(false);

    if (overlayEntry.value != null) {
      if (vibration) GetIt.I<VibrateUtil>().vibrateLight();
      final animationReverse = animationController.reverse();
      if (delay) {
        await animationReverse.whenComplete(() {
          overlayEntry.value?.remove();
          overlayEntry.value?.dispose();
          overlayEntry.value = null;
        });
      } else {
        animationController.reset();
        overlayEntry.value?.remove();
        overlayEntry.value?.dispose();
        overlayEntry.value = null;
      }
    }
  }

  Offset getOffsetTopPopup({
    required Size messageContainerSize,
    required Offset messageContainerOffset,
    required AxisDirection direction,
    required double topPopupHeight,
    double additionalHeight = 0,
  }) {
    /// find the area from the top of the screen to the bottom of the app bar
    /// and the popup menu item size and default padding (place for showing the popup menu)
    final double topAreaWithPopupMenuHeight = kToolbarHeight + topPopupHeight + defaultPadding;

    double dx = 0;
    double dy = messageContainerOffset.dy;

    if (messageContainerOffset.dy <= topAreaWithPopupMenuHeight) {
      /// if there is not enough space to show popup menu at the top
      /// then the popup menu will be shown at the bottom of the status bar
      dy = kToolbarHeight;
    } else {
      /// if there is enough space to show popup menu at the top
      /// then the popup menu will be shown at the top of the message container
      dy -= topPopupHeight + defaultPadding;
    }
    if (additionalHeight > 0) {
      dy -= additionalHeight - messageSize.height + defaultPadding;
    }

    if (direction == AxisDirection.right) {
      dx += paddingScreen;
    } else {
      /// if message is not current user message then show menu at the left sider and add avatar size
      dx += messageContainerOffset.dx;
    }

    return Offset(dx, dy);
  }

  Offset getOffsetBoottomPopup({
    required Offset messageOffset,
    required Size messageSize,
    required AxisDirection direction,
    required double bottomPopupHeight,
    bool updateExpand = false,
    double additionalHeight = 0,
  }) {
    final double keyboardAreaHeight = Get.mediaQuery.viewInsets.bottom;
    final double safeAreaPosition = Get.height - Get.mediaQuery.padding.bottom - keyboardAreaHeight - defaultPadding;
    final double emojiMenuArea = bottomPopupHeight + additionalHeight;
    final double areaPresentMessageWithMessageEmojiMenu =
        messageOffset.dy + messageSize.height + emojiMenuArea + defaultPadding;

    double dx = 0;
    double dy = messageOffset.dy;

    if (areaPresentMessageWithMessageEmojiMenu >= safeAreaPosition) {
      /// if there is not enough space to show popup menu at the bottom
      /// then the popup menu will be shown at the top of the safe area
      dy = safeAreaPosition - emojiMenuArea;
      if (updateExpand) {
        expandedOverflow = true;
      }
    } else {
      /// if there is enough space to show popup menu at the bottom
      /// then the popup menu will be shown at the top of the message container
      dy += messageSize.height + defaultPadding;
    }

    if (direction == AxisDirection.right) {
      dx += paddingScreen;
    } else {
      /// if message is not current user message then show menu at the left sider and add avatar size
      dx += messageOffset.dx;
    }
    return Offset(dx, dy);
  }

  Offset getOffsetMessage({
    required AxisDirection direction,
    required Offset messageOffset,
  }) {
    if (direction == AxisDirection.right) {
      /// if message is current user message then show message at the right side
      return Offset(
        paddingScreen,
        messageOffset.dy,
      );
    } else {
      /// if message is not current user message then show message at the left side
      return messageOffset;
    }
  }

  Offset updateOffsetMenu({
    required Offset bottomPopupOffset,
  }) {
    double dx = topPopupOffset.value.dx;
    double dy = topPopupOffset.value.dy;

    if (bottomPopupOffset.dy < (messageOffset.value.dy)) {
      dy = bottomPopupOffset.dy - topPopupHeight - defaultPadding;
    }

    return Offset(dx, dy);
  }

  void reset() {
    if (expandedOverflow) {
      bottomPopupOffset.value = getOffsetBoottomPopup(
        messageOffset: messageOffset.value,
        messageSize: messageSize,
        direction: direction,
        bottomPopupHeight: bottomPopupHeight,
        updateExpand: true,
      );
      topPopupOffset.value = getOffsetTopPopup(
        messageContainerSize: messageSize,
        messageContainerOffset: messageContainerOffset,
        direction: direction,
        topPopupHeight: topPopupHeight,
      );
      expandedOverflow = false;
    }
  }

  void updateAdditionHeight(double height) {
    bottomPopupOffset.value = getOffsetBoottomPopup(
      messageOffset: messageOffset.value,
      messageSize: messageSize,
      direction: direction,
      bottomPopupHeight: bottomPopupHeight,
      additionalHeight: height,
      updateExpand: true,
    );
    if (expandedOverflow) {
      topPopupOffset.value = updateOffsetMenu(
        bottomPopupOffset: bottomPopupOffset.value,
      );
    }
  }
}
