import 'package:uchat/features/album/data/models/collections/album_collection.dart';

class FetchAlbumsResponse {
  final List<AlbumCollection> albums;

  FetchAlbumsResponse({
    required this.albums,
  });

  // fromJson method
  factory FetchAlbumsResponse.fromJson(Map<String, dynamic> json) {
    return FetchAlbumsResponse(
      albums: List<AlbumCollection>.from(json['albums'].map((x) => AlbumCollection.fromJson(x))),
    );
  }
}
