import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';

class CentralNotificationUpdateEvent {
  CentralNotificationCollection centralNoti;

  CentralNotificationUpdateEvent({required this.centralNoti});

  @override
  String toString() => 'CentralNotificationUpdateEvent(centralNoti: $centralNoti)';
}
