import 'package:uchat/core/data/data_sources/models/payloads/platform_document/accept_term_and_condition.dart';
import 'package:uchat/core/data/data_sources/remote/platform_document_http_data_source.dart';
import 'package:uchat/core/domain/entities/platform_document_entity.dart';
import 'package:uchat/core/domain/entities/platform_document_version_entity.dart';
import 'package:uchat/core/domain/enums/platform_document.dart';
import 'package:uchat/core/domain/repositories/platform_document_repository.dart';

import '../data_sources/local/platform_document_local_data_source.dart';
import '../data_sources/models/payloads/platform_document/get_platform_document.dart';

class PlatformDocumentRepositoryImpl implements PlatformDocumentRepository {
  final PlatformDocumentHttpDataSource httpDataSource;
  final PlatformDocumentLocalDataSource localDataSource;

  PlatformDocumentRepositoryImpl({required this.httpDataSource, required this.localDataSource});

  @override
  Future<void> acceptTermAndCondition(PlatformDocumentType type, PlatformDocumentVersionEntity acceptedVersion) async {
    await httpDataSource.acceptTermAndCondition(
      AcceptTermAndConditionRequest(
        type: type.value,
        acceptedVersion: AcceptedVersion.fromEntity(acceptedVersion),
      ),
    );
  }

  @override
  Future<PlatformDocumentEntity?> fetchPlatformDocument(PlatformDocumentType type) async {
    final res = await httpDataSource.getPlatformDocument(
      GetPlatformDocumentRequest(type: type),
    );

    return res?.toEntity();
  }

  @override
  Future<void> saveVersionTermAndCondition(PlatformDocumentVersionEntity entity) async {
    await localDataSource.saveVersionTermAndCondition(entity);
  }
}
