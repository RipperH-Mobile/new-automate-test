// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoFileCompressingProgressEvent {
  String fileRef;
  double compressProgress;
  double totalProgress;

  VideoFileCompressingProgressEvent({
    required this.fileRef,
    required this.compressProgress,
    this.totalProgress = 100.0,
  });

  @override
  String toString() =>
      'VideoFileCompressingProgressEvent(fileRef: $fileRef, compressProgress: $compressProgress, totalProgress: $totalProgress)';
}
