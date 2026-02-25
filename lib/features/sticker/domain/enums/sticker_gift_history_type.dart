import 'package:get/get.dart';

enum StickerGiftHistoryType {
  received('Received'),
  sent('Sent');

  final String value;

  const StickerGiftHistoryType(this.value);

  String get translatedValue {
    switch (this) {
      case StickerGiftHistoryType.received:
        return 'Received'.tr;
      case StickerGiftHistoryType.sent:
        return '|__stickerGift__|Sent'.tr;
    }
  }
}
