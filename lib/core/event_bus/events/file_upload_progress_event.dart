// ignore_for_file: public_member_api_docs, sort_constructors_first
class FileUploadProgressEvent {
  String fileRef;
  double uploadProgress;
  double totalProgress;

  FileUploadProgressEvent({
    required this.fileRef,
    required this.uploadProgress,
    required this.totalProgress,
  });

  @override
  String toString() =>
      'FileUploadProgressEvent(fileRef: $fileRef, uploadProgress: $uploadProgress, totalProgress: $totalProgress)';
}
