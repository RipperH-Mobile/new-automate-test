import '../entities/version_entity.dart';

///
/// Service for checking and notifying about app version updates.
///
abstract class AppVersionService {
  DateTime? get lastUpdate;

  VersionEntity? get lastVersion;

  bool get lastVersionForceUpdate;

  Future<void> initialize();

  Future<void> checkUpdate({Duration? timeout});

  Future<void> notifyUpdate();

  void resetCache();
}
