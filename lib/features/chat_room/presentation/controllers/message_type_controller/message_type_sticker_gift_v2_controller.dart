import 'package:get/get.dart';
import 'package:uchat/routes/routes.dart';

import 'message_type.dart';

class MessageTypeStickerGiftV2Controller extends MessageTypeController {
  MessageTypeStickerGiftV2Controller({required super.initMessage});

  Future<void> onGoToStickerGift(String packId, {bool isGift = false}) async {
    if (packId.isEmpty) return;

    await Get.toNamed(
      Routes.stickerDetail.replaceAll(':stickerPackId', packId),
      arguments: {'isGift': isGift},
    );
  }
}
