import 'package:uchat/entities/models.dart';
import 'package:uchat/features/album/data/models/models/album_image_model.dart';

class CreateAlbumResponse {
  final String? albumName;
  final String? id;
  final String? accountId;
  final String? roomId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<AlbumImageModel>? images;
  final ContactModel? createdBy;

  CreateAlbumResponse({
    required this.albumName,
    required this.id,
    required this.accountId,
    required this.roomId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> newImages = [];
    if (images != null && images!.isNotEmpty) {
      newImages.addAll(images!.map((e) => e.toJson()));
    }
    Map<String, dynamic> json = {
      'albumName': albumName,
      'id': id,
      'accountId': accountId,
      'roomId': roomId,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'images': newImages,
    };
    return json;
  }

  factory CreateAlbumResponse.fromJson(Map<String, dynamic> json) {
    List<AlbumImageModel> images = [];
    if (json['images'] != null && json['images'] is List) {
      List image = json['images'];
      image.map((item) => images.add(AlbumImageModel.fromJson(item)));
    }

    ContactModel? createBy;
    if (json['createdBy'] != null) {
      createBy = ContactModel.fromMap(json['createdBy']);
    }

    return CreateAlbumResponse(
      albumName: json['albumName'],
      id: json['_id'],
      accountId: json['accountId'],
      roomId: json['roomId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      images: images,
      createdBy: createBy,
    );
  }
}
