import 'package:isar_community/isar.dart';

part 'notification_desktop_model.g.dart';

@embedded
class NotificationDesktopDataModel {
  String? roomId;
  String? headings;
  String? contents;

  NotificationDesktopDataModel({
    this.roomId,
    this.headings,
    this.contents,
  });

  factory NotificationDesktopDataModel.fromMap(Map<String, dynamic> json) {
    return NotificationDesktopDataModel(
      roomId: json['roomId'],
      headings: json['headings']['en'],
      contents: json['contents']['en'],
    );
  }

  @override
  String toString() {
    return '[Instance:NotificationDesktopDataModel] roomId: $roomId, headings: $headings, contents: $contents';
  }
}
