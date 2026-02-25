// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FileSavingRequest {
  final String fileName;
  final String fileUrl;
  final Map<String, String>? header;
  final bool isVideo;
  final bool isGif;
  final String? giphyId;
  final bool isFromServer;
  final String? fileExtension;
  final String? mimeType;
  final String? fileId;
  final String? messageId;
  final String? roomId;

  FileSavingRequest({
    required this.fileName,
    required this.fileUrl,
    this.header,
    this.isVideo = false,
    this.isGif = false,
    this.giphyId,
    this.isFromServer = true,
    this.fileExtension,
    this.mimeType,
    this.fileId,
    this.messageId,
    this.roomId,
  });

  FileSavingRequest copyWith({
    String? fileName,
    String? fileUrl,
    Map<String, String>? header,
    bool? isVideo,
    bool? isGif,
    String? giphyId,
    bool? isFromServer,
    String? fileExtension,
    String? mimeType,
    String? fileId,
    String? messageId,
    String? roomId,
  }) {
    return FileSavingRequest(
      fileName: fileName ?? this.fileName,
      fileUrl: fileUrl ?? this.fileUrl,
      header: header ?? this.header,
      isVideo: isVideo ?? this.isVideo,
      isGif: isGif ?? this.isGif,
      giphyId: giphyId ?? this.giphyId,
      isFromServer: isFromServer ?? this.isFromServer,
      fileExtension: fileExtension ?? this.fileExtension,
      mimeType: mimeType ?? this.mimeType,
      fileId: fileId ?? this.fileId,
      messageId: messageId ?? this.messageId,
      roomId: roomId ?? this.roomId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileName': fileName,
      'fileUrl': fileUrl,
      'header': header,
      'isVideo': isVideo,
      'isGif': isGif,
      'giphyId': giphyId,
      'isFromServer': isFromServer,
      'fileExtension': fileExtension,
      'mimeType': mimeType,
      'fileId': fileId,
      'messageId': messageId,
      'roomId': roomId,
    };
  }

  factory FileSavingRequest.fromMap(Map<String, dynamic> map) {
    return FileSavingRequest(
      fileName: map['fileName'] as String,
      fileUrl: map['fileUrl'] as String,
      header: map['header'] != null ? Map<String, String>.from((map['header'] as Map<String, String>)) : null,
      isVideo: map['isVideo'] as bool,
      isGif: map['isGif'] as bool,
      giphyId: map['giphyId'] != null ? map['giphyId'] as String : null,
      isFromServer: map['isFromServer'] as bool,
      fileExtension: map['fileExtension'] != null ? map['fileExtension'] as String : null,
      mimeType: map['mimeType'] != null ? map['mimeType'] as String : null,
      fileId: map['fileId'] != null ? map['fileId'] as String : null,
      messageId: map['messageId'] != null ? map['messageId'] as String : null,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileSavingRequest.fromJson(String source) =>
      FileSavingRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FileSavingRequest(fileName: $fileName, fileUrl: $fileUrl, header: $header, isVideo: $isVideo, isGif: $isGif, giphyId: $giphyId, isFromServer: $isFromServer, fileExtension: $fileExtension, mimeType: $mimeType, fileId: $fileId, messageId: $messageId, roomId: $roomId)';
  }

  @override
  bool operator ==(covariant FileSavingRequest other) {
    if (identical(this, other)) return true;

    return other.fileName == fileName &&
        other.fileUrl == fileUrl &&
        mapEquals(other.header, header) &&
        other.isVideo == isVideo &&
        other.isGif == isGif &&
        other.giphyId == giphyId;
  }

  @override
  int get hashCode {
    return fileName.hashCode ^
        fileUrl.hashCode ^
        header.hashCode ^
        isVideo.hashCode ^
        isGif.hashCode ^
        giphyId.hashCode;
  }
}
