import 'package:uchat/entities/enums.dart';

class FetchMyProfileMedia {
  DateTime? afterAt;
  DateTime? beforeAt;
  List<RoomFileType> types;
  int pageSize;

  FetchMyProfileMedia({
    this.afterAt,
    this.beforeAt,
    required this.types,
    this.pageSize = 20,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'pageSize': pageSize,
      'afterAt': afterAt?.toUtc().toIso8601String(),
      'beforeAt': beforeAt?.toUtc().toIso8601String(),
      'types': types.map((e) => e.value).toList(),
    };
    return json;
  }
}
