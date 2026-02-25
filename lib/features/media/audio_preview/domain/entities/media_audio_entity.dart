import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';

class MediaAudioEntity {
  String apiFileUrl;
  String? id;
  String? name;
  String? accountId;
  String? url;
  int? size;
  double? duration;
  DateTime? createdAt;
  FileDownloadStatus? downloadStatus;
  double downloadProgress;
  bool isLocalFile;

  MediaAudioEntity({
    required this.apiFileUrl,
    this.id,
    this.name,
    this.accountId,
    this.url,
    this.size,
    this.duration,
    this.createdAt,
    this.downloadStatus,
    this.downloadProgress = -1.0,
    this.isLocalFile = false,
  });

  static MediaAudioEntity fromMessageFileModel(MessageFileModel data) {
    return MediaAudioEntity(
      apiFileUrl: data.apiFileUrl ?? '',
      id: data.id,
      name: data.name,
      accountId: data.accountId,
      url: data.url,
      size: data.size,
      duration: data.duration,
      createdAt: data.createdAt,
      downloadStatus: data.downloadStatus,
      downloadProgress: data.downloadProgress,
      isLocalFile: data.isLocalFile,
    );
  }

  MessageFileModel toMessageFileModel() {
    return MessageFileModel(
      id: id,
      name: name,
      accountId: accountId,
      url: url,
      size: size,
      duration: duration,
      createdAt: createdAt,
      downloadStatus: downloadStatus,
      downloadProgress: downloadProgress,
      isLocalFile: isLocalFile,
    );
  }
}
