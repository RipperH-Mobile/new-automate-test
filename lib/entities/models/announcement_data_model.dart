// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar_community/isar.dart';

part 'announcement_data_model.g.dart';

@embedded
class AnnouncementDataModel {
  String? lang;
  String? data;

  AnnouncementDataModel({
    this.lang,
    this.data,
  });

  @override
  String toString() => 'AnnouncementDataModel(lang: $lang, data: $data)';
}
