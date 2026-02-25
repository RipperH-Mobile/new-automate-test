import 'package:uchat/core/domain/entities/platform_document_entity.dart';

import '../entities/platform_document_version_entity.dart';
import '../enums/platform_document.dart';

abstract class PlatformDocumentRepository {
  Future<PlatformDocumentEntity?> fetchPlatformDocument(PlatformDocumentType type);

  Future<void> acceptTermAndCondition(PlatformDocumentType type, PlatformDocumentVersionEntity acceptedVersion);

  Future<void> saveVersionTermAndCondition(PlatformDocumentVersionEntity entity);
}
