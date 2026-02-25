import 'package:flutter/foundation.dart';

@immutable
class StickerPackDetailArgument {
  final bool isGift;

  const StickerPackDetailArgument({
    this.isGift = false,
  });
}
