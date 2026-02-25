import 'package:flutter/foundation.dart';
import 'package:uchat/features/chat_room/domain/entities/gif_sending_entity.dart';
import 'package:uchat/use_cases/use_case.dart';

@immutable
class DebugSendSampleGifParams {
  final GifSendingEntity gif;
  final Function(GifSendingEntity, {int loopCount}) onSendGif;
  final int delay;
  final int loopCount;

  const DebugSendSampleGifParams({
    required this.gif,
    required this.onSendGif,
    this.delay = 100,
    this.loopCount = 100,
  });
}

class DebugSendSampleGifUseCase extends SimpleUseCase<void, DebugSendSampleGifParams> {
  @override
  Future<void> call(DebugSendSampleGifParams params) async {
    for (var i = 0; i < params.loopCount; i++) {
      params.onSendGif(params.gif, loopCount: params.loopCount);
      await Future.delayed(Duration(milliseconds: params.delay));
    }
  }
}
