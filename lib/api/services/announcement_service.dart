import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections/announcement_collection.dart';

final _log = useLogger();

class AnnouncementService with ServiceMixin {
  /// Singleton pattern
  static final AnnouncementService instance = AnnouncementService._internal();

  factory AnnouncementService() => instance;

  AnnouncementService._internal();

  Future<List<AnnouncementCollection>?> getAvailableAnnouncement(
    GetAvailableAnnouncementRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.getAvailableAnnouncement.socket,
          request.toMap(),
        );

        return socketResp.listToResponseV3((e) => AnnouncementCollection.fromMap(e))?.toList();
      } catch (e, stackTrace) {
        _log.w('getAvailableAnnouncement with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.get(
      BackendPath.getAvailableAnnouncement.http,
      queryParameters: request.toMap(),
    );

    return httpResp.listToResponseV3((e) => AnnouncementCollection.fromMap(e))?.toList();
  }
}
