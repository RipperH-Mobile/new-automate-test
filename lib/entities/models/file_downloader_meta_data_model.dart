import 'dart:convert';

class FileDownloaderMetaDataModel {
  final String eventTo;
  final bool openWhenCompleted;
  final int fileSize;

  FileDownloaderMetaDataModel({
    required this.eventTo,
    this.openWhenCompleted = false,
    this.fileSize = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventTo': eventTo,
      'openWhenCompleted': openWhenCompleted,
      'fileSize': fileSize,
    };
  }

  factory FileDownloaderMetaDataModel.fromMap(Map<String, dynamic> map) {
    return FileDownloaderMetaDataModel(
      eventTo: map['eventTo'] as String,
      openWhenCompleted: map['openWhenCompleted'] as bool,
      fileSize: map['fileSize'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileDownloaderMetaDataModel.fromJson(String source) =>
      FileDownloaderMetaDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
