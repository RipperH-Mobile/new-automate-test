import 'package:uchat/entities/services/config_db.dart';

import '../../../domain/entities/platform_document_version_entity.dart';

class PlatformDocumentLocalDataSource {
  final ConfigInstance config;

  PlatformDocumentLocalDataSource({required this.config});

  Future<void> saveVersionTermAndCondition(PlatformDocumentVersionEntity entity) async {
    return config.saveConfig(
      key: ConfigDb.termVersionKey(),
      value: '${entity.major}.${entity.minor}.${entity.patch}',
    );
  }
}
