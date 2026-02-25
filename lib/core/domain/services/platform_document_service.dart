import '../entities/platform_document_entity.dart';
import '../entities/platform_document_version_entity.dart';
import '../enums/platform_document.dart';

abstract class PlatformDocumentService {
  Future<(String, PlatformDocumentVersionEntity)> getPrivacyPolicyUrlAndCurrentVersion();

  Future<(String, PlatformDocumentVersionEntity)> getTermsAndConditionsUrlAndCurrentVersion();

  Future<(String, PlatformDocumentVersionEntity)> getTermsAndConditionsWithPrivacyUrlAndCurrentVersion();

  Future<void> acceptTermAndCondition(PlatformDocumentType type, PlatformDocumentVersionEntity version);

  Future<PlatformDocumentEntity> fetchPlatformDocumentByType(PlatformDocumentType type);

  Future<void> saveVersionTermAndCondition(PlatformDocumentVersionEntity entity);
}
