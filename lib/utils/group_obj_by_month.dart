import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uchat/features/album/data/models/models/album_image_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class GroupObjByMonthModel {
  // List of month in the objMap. latest month will be at index 0.
  List<String> monthList;
  // Key is date from _dateFormat.
  // example:
  // {
  //   'october 2023': [firstImage, secondImage],
  //   'september 2023': [firstImage, ...],
  // }
  Map<String, List<dynamic>> objMap;

  GroupObjByMonthModel({
    required this.monthList,
    required this.objMap,
  });
}

GroupObjByMonthModel groupObjByMonth(dynamic objList) {
  Map<String, List<dynamic>> objMap = {};
  // handle different obj here
  if (objList is List<MessageFileModel>) {
    for (MessageFileModel element in objList) {
      if (element.createdAt != null) {
        _addToObjMap(objMap, element.createdAt!, element);
      }
    }
  } else if (objList is List<AlbumImageModel>) {
    for (AlbumImageModel element in objList) {
      if (element.createAt != null) {
        _addToObjMap(objMap, element.createAt!, element);
      }
    }
  } else if (objList is List<RoomFileCollection>) {
    for (RoomFileCollection element in objList) {
      if (element.file?.createdAt != null) {
        _addToObjMap(objMap, element.file!.createdAt!, element);
      }
    }
  } else if (objList is List<MessageCollection>) {
    for (MessageCollection element in objList) {
      if (element.createdAt != null) {
        _addToObjMap(objMap, element.createdAt!, element);
      }
    }
  } else {
    // Add another else if here to handle another type of obj if needed.
    _log.w('obj type : ${objList.runtimeType} is not supported in this function.');
  }

  final dateFormat = DateFormat('MMMM y', Get.locale?.toLanguageTag() ?? 'en-US');
  List<String> monthList = objMap.keys.toList();
  monthList.sort((a, b) => dateFormat.parse(b).compareTo(dateFormat.parse(a)));

  return GroupObjByMonthModel(
    monthList: monthList,
    objMap: objMap,
  );
}

void _addToObjMap(
  Map<String, List<dynamic>> objMap,
  DateTime dateTime,
  dynamic element,
) {
  final key = dateTime.format('MMMM y');
  if (objMap.containsKey(key)) {
    objMap[key]!.add(element);
  } else {
    objMap[key] = [element];
  }
}
