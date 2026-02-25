import 'package:flutter/foundation.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/use_cases/use_case.dart';

@immutable
class DebugSendSampleFileMessageParams {
  final FileInfoModel fileInfo;
  final int delay;
  final int loopCount;
  final Function(FileInfoModel, {int loopCount}) onSendFile;

  const DebugSendSampleFileMessageParams({
    required this.fileInfo,
    required this.onSendFile,
    this.delay = 100,
    this.loopCount = 100,
  });
}

class DebugSendSampleFileMessageUseCase extends SimpleUseCase<void, DebugSendSampleFileMessageParams> {
  @override
  Future<void> call(DebugSendSampleFileMessageParams params) async {
    for (var i = 0; i < params.loopCount; i++) {
      params.onSendFile(params.fileInfo, loopCount: params.loopCount);
      await Future.delayed(Duration(milliseconds: params.delay));
    }
  }
}
