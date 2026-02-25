import 'dart:convert';

import 'package:uchat/features/album/data/models/collections/album_collection.dart';

class FetchRoomDetailMediaCountResponse {
  FetchRoomDetailMediaCountResponse({
    required this.countOfImage,
    required this.countOfVideo,
    required this.countOfFile,
    required this.countOfLink,
    required this.countOfAlbum,
    required this.albumLists,
  });

  final int countOfImage;
  final int countOfVideo;
  final int countOfFile;
  final int countOfLink;
  final int countOfAlbum;
  final List<AlbumCollection> albumLists;

  factory FetchRoomDetailMediaCountResponse.fromJson(String str) =>
      FetchRoomDetailMediaCountResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FetchRoomDetailMediaCountResponse.fromMap(Map<String, dynamic> json) {
    List<AlbumCollection> albumLists = [];
    if (json['data']?['albumLists'] != null) {
      albumLists =
          List<AlbumCollection>.from(json['data']?['albumLists'].map((x) => AlbumCollection.fromJson(x)).toList());
    }
    return FetchRoomDetailMediaCountResponse(
      countOfImage: json['data']?['countOfImage'] ?? 0,
      countOfVideo: json['data']?['countOfVideo'] ?? 0,
      countOfFile: json['data']?['countOfFile'] ?? 0,
      countOfLink: json['data']?['countOfLink'] ?? 0,
      countOfAlbum: json['data']?['countOfAlbum'] ?? 0,
      albumLists: albumLists,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countOfImage': countOfImage,
      'countOfVideo': countOfVideo,
      'countOfFile': countOfFile,
      'countOfLink': countOfLink,
      'countOfAlbum': countOfAlbum,
    };
  }

  @override
  String toString() {
    return 'FetchRoomDetailMediaCountResponse(countOfImage: $countOfImage, countOfVideo: $countOfVideo, countOfFile: $countOfFile, countOfLink: $countOfLink, countOfAlbum: $countOfAlbum)';
  }
}
