import 'package:get/get.dart';

class RoomLinksResponse {
  final String id;
  final String roomId;
  final String accountId;
  final DateTime createdAt;
  final String url;
  final String title;
  final String description;
  final List<String> images;
  final List<String> favicons;

  RoomLinksResponse({
    required this.id,
    required this.roomId,
    required this.accountId,
    required this.createdAt,
    required this.url,
    required this.title,
    required this.description,
    required this.images,
    required this.favicons,
  });

  factory RoomLinksResponse.fromJson(Map<String, dynamic> json) {
    return RoomLinksResponse(
      id: json['_id'],
      roomId: json['roomId'],
      accountId: json['accountId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      url: json['url'] ?? '',
      title: json['title'] ?? json['siteName'] ?? 'UNKNOWN'.tr,
      description: json['description'] ?? '',
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      favicons: (json['favicons'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
