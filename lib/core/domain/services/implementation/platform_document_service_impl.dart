import 'package:get/get.dart';
import 'package:uchat/core/domain/entities/platform_document_version_entity.dart';
import 'package:uchat/core/domain/repositories/platform_document_repository.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/utils/app_env.dart';

import '../../entities/platform_document_entity.dart';
import '../../enums/platform_document.dart';
import '../platform_document_service.dart';

class PlatformDocumentServiceImpl implements PlatformDocumentService {
  static const fallbackLanguageCode = 'EN';
  static const fallbackCountryCode = 'US';

  final PlatformDocumentRepository repository;

  PlatformDocumentServiceImpl({
    required this.repository,
  });

  @override
  Future<(String, PlatformDocumentVersionEntity)> getPrivacyPolicyUrlAndCurrentVersion() async {
    final response = await fetchPlatformDocumentByType(PlatformDocumentType.privacyPolicy);

    return (_getFileUrlFromResponse(response), response.currentVersion);
  }

  @override
  Future<(String, PlatformDocumentVersionEntity)> getTermsAndConditionsUrlAndCurrentVersion() async {
    final response = await fetchPlatformDocumentByType(PlatformDocumentType.termAndCondition);

    return (_getFileUrlFromResponse(response), response.currentVersion);
  }

  @override
  Future<(String, PlatformDocumentVersionEntity)> getTermsAndConditionsWithPrivacyUrlAndCurrentVersion() async {
    final response = await fetchPlatformDocumentByType(PlatformDocumentType.termAndConditionWithPrivacy);

    return (_getFileUrlFromResponse(response), response.currentVersion);
  }

  @override
  Future<void> acceptTermAndCondition(PlatformDocumentType type, PlatformDocumentVersionEntity version) async {
    await repository.acceptTermAndCondition(type, version);
  }

  @override
  Future<void> saveVersionTermAndCondition(PlatformDocumentVersionEntity entity) async {
    await repository.saveVersionTermAndCondition(entity);
  }

  @override
  Future<PlatformDocumentEntity> fetchPlatformDocumentByType(PlatformDocumentType type) async {
    final response = await repository.fetchPlatformDocument(type);

    if (response == null) {
      throw PlatformDocumentNotFoundException();
    }

    return response;
  }

  String _getFileIdFromResponse(PlatformDocumentEntity response) {
    final languageCode = Get.locale?.languageCode ?? fallbackLanguageCode;
    final countryCode = Get.locale?.countryCode;

    // Try language + country code first (e.g., EN_US)
    if (countryCode != null) {
      final combinedCode = '${languageCode.toUpperCase()}_${countryCode.toUpperCase()}';
      if (response.fileIds.containsKey(combinedCode)) {
        return response.fileIds[combinedCode]!;
      }
    }

    // Try language code only
    if (response.fileIds.containsKey(languageCode.toUpperCase())) {
      return response.fileIds[languageCode.toUpperCase()]!;
    }

    // Fallback to default language code
    if (!response.fileIds.containsKey(fallbackLanguageCode)) {
      throw PlatformDocumentNotFoundException();
    }

    return response.fileIds[fallbackLanguageCode];
  }

  String _getFileUrlFromResponse(PlatformDocumentEntity response) {
    return '${AppEnv.apiUrl}v3/platform-document/file/${_getFileIdFromResponse(response)}';
  }
}
