import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/debug_send_sample_image_video_config_dialog.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/use_cases/use_case.dart';

class DebugSendSampleImageVideoParams {
  final AssetEntity asset;
  final int delay;
  final int loopCount;
  final int imageAmount;
  final Function(MediaGalleryResult, {int loopCount}) onDoneCallback;

  const DebugSendSampleImageVideoParams({
    required this.asset,
    required this.onDoneCallback,
    this.delay = 100,
    this.loopCount = 100,
    this.imageAmount = 10,
  });
}

class DebugSendSampleImageVideoUseCase extends SimpleUseCase<void, DebugSendSampleImageVideoParams> {
  @override
  Future<void> call(DebugSendSampleImageVideoParams params) async {
    final asset = params.asset;
    final onDoneCallback = params.onDoneCallback;

    final result = await Get.dialog(
      DebugSendSampleImageVideoConfigDialog(asset: asset),
      barrierDismissible: false,
    );
    if (result == null) return;

    final [mediaResult, delay, loopCount] = result;

    for (var i = 0; i < loopCount; i++) {
      onDoneCallback(mediaResult, loopCount: loopCount);
      await Future.delayed(Duration(milliseconds: delay));
    }
  }
}
