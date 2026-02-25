// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models/announcement_data_model.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'announcement_collection.g.dart';

final _log = useLogger();

@Collection(accessor: 'announcement')
@Name('Announcement')
class AnnouncementCollection {
  @Index(type: IndexType.value)
  String? id;

  Id get isarId => fastHash(id!);

  bool? isBroadcasted;
  DateTime announceAt;
  DateTime expireAt;
  bool? isUseBroadcast;
  List<AnnouncementDataModel>? text;
  List<AnnouncementDataModel>? image;
  bool? deleted;
  String? announceType;
  DateTime? startMaintenanceAt;
  DateTime? endMaintenanceAt;
  DateTime? dontShowToday;

  AnnouncementCollection({
    required this.isBroadcasted,
    required this.id,
    this.text,
    this.image,
    required this.announceAt,
    required this.expireAt,
    required this.isUseBroadcast,
    required this.deleted,
    required this.announceType,
    this.startMaintenanceAt,
    this.endMaintenanceAt,
    this.dontShowToday,
  });

  static AnnouncementCollection fromMap(Map<String, dynamic> data) {
    try {
      List<AnnouncementDataModel> text = [];
      List<AnnouncementDataModel> image = [];
      if (data['image'] != null) {
        for (final key in data['image'].keys) {
          image.add(
            AnnouncementDataModel(data: data['image'][key], lang: key),
          );
        }
      }

      if (data['text'] != null && data['text'] is Map) {
        Map textDataMap = data['text'] as Map;

        // Iterate over each entry in the map
        for (final entry in textDataMap.entries) {
          String key = entry.key;
          final value = entry.value;
          String textData;

          // Check if the value is a List, and join if it is
          if (value is List) {
            // Join the array elements into a single string separated by a newline
            textData = value.join('\n');
          } else if (value is String) {
            // Directly use the string if it's not a List
            textData = value;
          } else {
            // Handle other unexpected data types
            _log.e('Unexpected data type for text value: ${value.runtimeType}');
            textData = ''; // Use an empty string as default
          }

          text.add(AnnouncementDataModel(lang: key, data: textData));
        }
      }

      return AnnouncementCollection(
        isBroadcasted: data['isBroadcasted'],
        id: data['_id'],
        image: image,
        text: text,
        announceAt: strToDateTime(data['announceAt'])!,
        expireAt: strToDateTime(data['expireAt'])!,
        isUseBroadcast: data['isUseBroadcast'],
        deleted: data['deleted'],
        announceType: data['announceType'],
        startMaintenanceAt: strToDateTime(data['startMaintenanceAt']),
        endMaintenanceAt: strToDateTime(data['endMaintenanceAt']),
      );
    } catch (e) {
      _log.e('Error AnnouncementCollection fromMap', e);
      rethrow;
    }
  }

  String getText(String locale) {
    final value = text?.firstWhereOrNull(
      (element) => element.lang?.toLowerCase() == locale.toLowerCase(),
    );
    if (value != null) {
      return value.data ?? '';
    } else {
      if (text?.isNotEmpty ?? false) {
        return text!.first.data ?? '';
      } else {
        return '';
      }
    }
  }

  String getImage(String locale) {
    return image
            ?.firstWhere((element) => element.lang?.toLowerCase() == locale.toLowerCase(), orElse: () => image!.first)
            .data ??
        '';
  }

  String getDateString() {
    String langLocale = Get.locale?.toLanguageTag() ?? 'en_US';
    if (startMaintenanceAt!.isSameDay(endMaintenanceAt!)) {
      return '${startMaintenanceAt!.format('dd MMM , kk:mm', langLocale)} - ${endMaintenanceAt!.format('kk:mm', langLocale)}';
    } else if (startMaintenanceAt!.isSameYear(endMaintenanceAt!)) {
      return '${startMaintenanceAt!.format('dd MMM , kk:mm', langLocale)} - ${endMaintenanceAt!.format('dd MMM , kk:mm', langLocale)}';
    } else {
      return '${startMaintenanceAt!.format('dd MMM y , kk:mm', langLocale)} -\n${endMaintenanceAt!.format('dd MMM y , kk:mm', langLocale)}';
    }
  }

  bool get isExpired {
    return DateTime.now().isAfter(announceAt) && DateTime.now().isBefore(expireAt);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnouncementCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AnnouncementCollection(id: $id, isBroadcasted: $isBroadcasted, announceAt: $announceAt, expireAt: $expireAt, isUseBroadcast: $isUseBroadcast, text: $text, image: $image, deleted: $deleted, announceType: $announceType, startMaintenanceAt: $startMaintenanceAt, endMaintenanceAt: $endMaintenanceAt, dontShowToday: $dontShowToday)';
  }
}
