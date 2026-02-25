import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/bindings/base_message_binding.dart';

class PinMessageBinding extends BaseMessageBinding {
  static void put(MessageCollection message) {
    // PinMessageBinding only handles message type controllers, no container or reaction controllers
    BaseMessageBinding.putMessageTypeControllers(
      message,
      suffix: 'pin',
      enableReact: false,
    );
  }

  static void close(MessageCollection message) {
    // PinMessageBinding only handles message type controllers, no container or reaction controllers
    BaseMessageBinding.closeMessageTypeControllers(
      message,
      suffix: 'pin',
    );
  }

  static String getMessageTypeTagWithSuffix(MessageCollection message) {
    return BaseMessageBinding.getMessageTypeTagWithSuffix(message, 'pin');
  }
}
