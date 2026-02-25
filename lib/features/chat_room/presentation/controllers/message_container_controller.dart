import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';

class MessageContainerController extends GetxController with GetSingleTickerProviderStateMixin {
  final MessageCollection initMessage;

  MessageContainerController({
    required this.initMessage,
  }) {
    message.value = initMessage;
  }

  final message = Rxn<MessageCollection>();

  StreamSubscription? _reactionSubscription;

  AnimationController? animationCtl;

  // TODO: มีวิธีที่ไม่ต้องเรียกใช้ controller อื่น ใน controller นี้ไหม
  ChatRoomController get chatRoomDirectController {
    if (!Get.isRegistered<ChatRoomController>()) {
      return Get.put<ChatRoomController>(
          ChatRoomController(
            tag: initMessage.roomId ?? '',
            messageLocalRepository: GetIt.I<MessageLocalRepository>(),
          ),
          tag: initMessage.roomId ?? '');
    }

    return Get.find<ChatRoomController>(tag: initMessage.roomId ?? '');
  }

  UserController? get currentUserCtl {
    try {
      return UserController.instance;
    } catch (e) {
      return null;
    }
  }

  bool get whoReadEnable => chatRoomDirectController.chatRoomInputCtl.enableWarMode.value;

  bool get enableReactionModal =>
      initMessage.canReact &&
      currentUserCtl?.enableReactMessage == true &&
      !chatRoomDirectController.roomCapability.value.disableEmojiReaction;

  @override
  void onInit() {
    super.onInit();
    animationCtl = AnimationController(vsync: this);
    _reactionSubscription = eventBus.on<MessageReactionEvent>().listen((event) {
      if (event.msgId == message()?.id) {
        EasyThrottle.throttle(
          'updateReactionCategoriesList2',
          const Duration(milliseconds: 500),
          () {
            message.value?.emojiAmount = event.emojiAmount;
            message.refresh();
          },
        );
      }
    });
  }

  @override
  void onClose() {
    animationCtl?.dispose();
    animationCtl = null;
    _reactionSubscription?.cancel();
    super.onClose();
  }

  /// Trigger shake animation on the message container
  /// Reference: UCHAT3-27695 - Added null safety check
  void shakeIt() {
    animationCtl?.forward(from: 0.0);
  }
}
