import 'dart:async';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type.dart';
import 'package:uchat/utils/extension/extension_string.dart';

class MessageTypeTextV2Controller extends MessageTypeController {
  MessageTypeTextV2Controller({
    required super.initMessage,
    this.enableReact = true,
  }) {
    message.value = super.initMessage;
  }
  final bool enableReact;

  final message = Rx<MessageCollection?>(null);

  /// Count message length
  final msgLength = 0.obs;

  /// Is message length longer than [UChatConstant.maxTextCharacter]
  final isLengthOverLimit = false.obs;

  /// Is message showed as minimum form
  final isMinimizeText = true.obs;

  StreamSubscription? _closeExpandedTextSubscription;

  @override
  onInit() async {
    msgLength.value = message.value?.message?.effectiveLength ?? 0;
    isLengthOverLimit.value = msgLength.value >= UChatConstant.maxTextCharacter;

    _closeExpandedTextSubscription = eventBus.on<CloseExpandedTextEvent>().listen(
      (event) async {
        if (!isMinimizeText.value) {
          isMinimizeText.value = true;
        }
      },
    );

    super.onInit();
  }

  @override
  onClose() async {
    await _closeExpandedTextSubscription?.cancel();
    super.onClose();
  }

  @override
  bool get canReact => enableReact && super.canReact;

  /// This variable means is this message need an RegX markup container or not.
  /// It will be true if one of [isEmoji], [isMention], [hasPhoneNumber] and [hasEmail] is true.
  bool get isRegEx => (message.value?.meta?.isRegEx ?? false) || isLengthOverLimit.value;

  /// Is it has only emoji in message
  bool get isEmoji => message.value?.meta?.isEmoji == true;

  /// Is my message
  bool get isMyMessage => message.value?.mine == true;

  /// Is message had links
  bool get isHaveLinks => message.value?.links?.isNotEmpty == true;

  void onReadMorePressed() {
    isMinimizeText.value = !isMinimizeText.value;
  }
}
