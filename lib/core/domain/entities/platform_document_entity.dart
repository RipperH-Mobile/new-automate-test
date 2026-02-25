import 'platform_document_version_entity.dart';

class PlatformDocumentEntity {
  final PlatformDocumentVersionEntity currentVersion;
  final Map<String, dynamic> fileIds;
  final PlatformDocumentVersionEntity nextVersionRelease;

  const PlatformDocumentEntity({
    required this.currentVersion,
    required this.fileIds,
    required this.nextVersionRelease,
  });
}
