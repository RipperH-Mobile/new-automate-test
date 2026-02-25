import '../../../../../domain/entities/platform_document_version_entity.dart';

class AcceptTermAndConditionRequest {
  String type;
  AcceptedVersion acceptedVersion;

  AcceptTermAndConditionRequest({
    required this.type,
    required this.acceptedVersion,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'acceptedVersion': acceptedVersion.toMap(),
    };
  }
}

class AcceptedVersion {
  final int major;
  final int minor;
  final int patch;

  AcceptedVersion({
    required this.major,
    required this.minor,
    required this.patch,
  });

  factory AcceptedVersion.fromEntity(PlatformDocumentVersionEntity entity) {
    return AcceptedVersion(
      major: entity.major,
      minor: entity.minor,
      patch: entity.patch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'major': major,
      'minor': minor,
      'patch': patch,
    };
  }
}
