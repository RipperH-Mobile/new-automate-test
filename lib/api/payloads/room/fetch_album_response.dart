import 'dart:convert';

import 'package:uchat/features/album/data/models/models/album_image_model.dart';

class FetchAlbumResponse {
  FetchAlbumResponse({
    required this.id,
    required this.albumName,
    required this.isSuccess,
    required this.lastFourImageInAlbum,
    required this.totalImages,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? albumName;
  final bool? isSuccess;
  final List<AlbumImageModel>? lastFourImageInAlbum;
  final int? totalImages;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FetchAlbumResponse.fromJson(String str) => FetchAlbumResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FetchAlbumResponse.fromMap(Map<String, dynamic> json) {
    List<AlbumImageModel>? lastFourImageInAlbum;
    if (json['lastFourImageInAlbum'] != null) {
      lastFourImageInAlbum = List<AlbumImageModel>.from(
        json['lastFourImageInAlbum'].map(
          (item) {
            item['albumId'] = json['_id'];
            return AlbumImageModel.fromJson(item);
          },
        ),
      );
    }
    return FetchAlbumResponse(
      id: json['_id'],
      albumName: json['albumName'],
      isSuccess: json['isSuccess'],
      lastFourImageInAlbum: lastFourImageInAlbum,
      totalImages: json['totalImages'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>>? newLastFourImageInAlbum;
    if (lastFourImageInAlbum != null && lastFourImageInAlbum!.isNotEmpty) {
      newLastFourImageInAlbum = lastFourImageInAlbum
          ?.map(
            (e) => e.toJson(),
          )
          .toList();
    }
    return {
      'id': id,
      'albumName': albumName,
      'isSuccess': isSuccess,
      'lastFourImageInAlbum': newLastFourImageInAlbum,
      'totalImages': totalImages,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}
