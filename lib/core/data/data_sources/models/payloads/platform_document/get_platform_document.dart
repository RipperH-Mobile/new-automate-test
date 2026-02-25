import '../../../../../domain/entities/platform_document_entity.dart';
import '../../../../../domain/entities/platform_document_version_entity.dart';
import '../../../../../domain/enums/platform_document.dart';

class GetPlatformDocumentRequest {
  final PlatformDocumentType type;

  GetPlatformDocumentRequest({required this.type});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.value,
    };
  }
}

class GetPlatformDocumentResponse {
  final PlatformDocumentVersionModel currentVersion;
  final Map<String, dynamic> fileIds;
  final PlatformDocumentVersionModel nextVersionRelease;

  GetPlatformDocumentResponse({
    required this.currentVersion,
    required this.fileIds,
    required this.nextVersionRelease,
  });

  factory GetPlatformDocumentResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return GetPlatformDocumentResponse(
      currentVersion: PlatformDocumentVersionModel.fromJson(data['currentVersion']),
      fileIds: data['fileIds'],
      nextVersionRelease: PlatformDocumentVersionModel.fromJson(data['nextVersionRelease']),
    );
  }

  PlatformDocumentEntity toEntity() {
    return PlatformDocumentEntity(
      currentVersion: currentVersion.toEntity(),
      fileIds: fileIds,
      nextVersionRelease: nextVersionRelease.toEntity(),
    );
  }
}

class PlatformDocumentVersionModel {
  final int major;
  final int minor;
  final int patch;

  PlatformDocumentVersionModel({
    required this.major,
    required this.minor,
    required this.patch,
  });

  factory PlatformDocumentVersionModel.fromJson(Map<String, dynamic> json) {
    return PlatformDocumentVersionModel(
      major: json['major'],
      minor: json['minor'],
      patch: json['patch'],
    );
  }

  PlatformDocumentVersionEntity toEntity() {
    return PlatformDocumentVersionEntity(
      major: major,
      minor: minor,
      patch: patch,
    );
  }
}
