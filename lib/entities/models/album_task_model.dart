import 'package:isar_community/isar.dart';

part 'album_task_model.g.dart';

@embedded
class AlbumTaskModel {
  String? taskId;
  String? ownerId;
  int? totalImages;

  AlbumTaskModel({
    this.taskId,
    this.ownerId,
    this.totalImages,
  });

  factory AlbumTaskModel.fromMap(Map<String, dynamic> json) {
    return AlbumTaskModel(
      taskId: json['taskId'],
      ownerId: json['ownerId'],
      totalImages: json['totalImages'],
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumTaskModel && taskId == other.taskId;
  }

  @ignore
  @override
  int get hashCode => taskId.hashCode;
}
