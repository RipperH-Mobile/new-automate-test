import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';

abstract class CentralNotificationLocalRepository {
  Future<void> clearCollection();

  Future<bool> deleteCentralNotiOnDb(String id);

  Future<void> deleteCentralNotifications(List<String> ids);

  Future<List<CentralNotificationCollection>> getAllCentralNoti();

  Future<CentralNotificationCollection?> getCentralNoti(String roomId);

  Future<void> putAllCentralNoti(List<CentralNotificationCollection> centralNoti);

  Future<void> putAllCentralNotiWithoutTxn(List<CentralNotificationCollection> centralNoti);

  Future<void> putCentralNoti(CentralNotificationCollection centralNoti);
}
