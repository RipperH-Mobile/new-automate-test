import 'package:uchat/features/central_notification/data/data_source/local/central_notification_db.dart';
import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';
import 'package:uchat/features/central_notification/domain/repository/central_notification_local_repository.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class CentralNotificationLocalRepositoryImpl implements CentralNotificationLocalRepository {
  final CentralNotificationDb centralNotificationDb;

  CentralNotificationLocalRepositoryImpl({
    required this.centralNotificationDb,
  });

  @override
  Future<void> clearCollection() async {
    try {
      await centralNotificationDb.clearCollection();
    } catch (e, stackTrace) {
      _log.e('clearCollection error.', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> deleteCentralNotiOnDb(String id) async {
    try {
      return await centralNotificationDb.deleteCentralNotiOnDb(id);
    } catch (e, stackTrace) {
      _log.e('deleteCentralNotiOnDb error.', e, stackTrace);
      return false;
    }
  }

  @override
  Future<void> deleteCentralNotifications(List<String> ids) async {
    try {
      await centralNotificationDb.deleteCentralNotifications(ids);
    } catch (e, stackTrace) {
      _log.e('deleteCentralNotifications error.', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<CentralNotificationCollection>> getAllCentralNoti() async {
    try {
      return await centralNotificationDb.getAllCentralNoti();
    } catch (e, stackTrace) {
      _log.e('getAllCentralNoti error.', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<CentralNotificationCollection?> getCentralNoti(String roomId) async {
    try {
      return await centralNotificationDb.getCentralNoti(roomId);
    } catch (e, stackTrace) {
      _log.e('getCentralNoti error.', e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> putAllCentralNoti(List<CentralNotificationCollection> centralNoti) async {
    try {
      await centralNotificationDb.putAllCentralNoti(centralNoti);
    } catch (e, stackTrace) {
      _log.e('putAllCentralNoti error.', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> putAllCentralNotiWithoutTxn(List<CentralNotificationCollection> centralNoti) async {
    try {
      await centralNotificationDb.putAllCentralNotiWithoutTxn(centralNoti);
    } catch (e, stackTrace) {
      _log.e('putAllCentralNotiWithoutTxn error.', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> putCentralNoti(CentralNotificationCollection centralNoti) async {
    try {
      await centralNotificationDb.putCentralNoti(centralNoti);
    } catch (e, stackTrace) {
      _log.e('putCentralNoti error.', e, stackTrace);
      rethrow;
    }
  }
}
