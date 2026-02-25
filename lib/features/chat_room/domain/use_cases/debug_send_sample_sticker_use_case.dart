import 'package:flutter/foundation.dart';
import 'package:uchat/features/chat_room/domain/entities/sticker_sending_entity.dart';
import 'package:uchat/use_cases/use_case.dart';

@immutable
class DebugSendSampleStickerParams {
  final StickerSendingEntity sticker;
  final Function(StickerSendingEntity, {int loopCount}) onSendSticker;
  final int delay;
  final int loopCount;

  const DebugSendSampleStickerParams({
    required this.sticker,
    required this.onSendSticker,
    this.delay = 100,
    this.loopCount = 100,
  });
}

class DebugSendSampleStickerUseCase extends SimpleUseCase<void, DebugSendSampleStickerParams> {
  @override
  Future<void> call(DebugSendSampleStickerParams params) async {
    for (var i = 0; i < params.loopCount; i++) {
      params.onSendSticker(params.sticker, loopCount: params.loopCount);
      await Future.delayed(Duration(milliseconds: params.delay));
    }
  }
}
