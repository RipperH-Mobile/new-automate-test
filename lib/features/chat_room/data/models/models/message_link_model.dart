import 'package:isar_community/isar.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_video_model.dart';
import 'package:uchat/utils/get_link_helper.dart';

part 'message_link_model.g.dart';

@embedded
class MessageLinkModel {
  String? messageId;
  String? roomId;
  String? url;
  List<String>? images = [];
  List<MessageLinkVideoModel>? videos;
  List<String>? favicons;
  String? mediaType;
  String? title;
  String? description;
  String? siteName;
  String? contentType;

  // Constructor
  MessageLinkModel({
    this.messageId,
    this.roomId,
    this.url,
    this.images,
    this.videos,
    this.favicons,
    this.mediaType,
    this.title,
    this.description,
    this.siteName,
    this.contentType,
  });

  // Convert from map
  factory MessageLinkModel.fromMap(Map<String, dynamic> data) {
    final link = MessageLinkModel(
      messageId: data['messageId'] as String?,
      roomId: data['roomId'] as String?,
      url: data['url'] as String,
    );

    // Process Image
    link.images ??= <String>[];
    if (data['images'] != null && data['images'] is List) {
      for (final image in data['images']) {
        link.images!.add(image);
      }
    }
    if (data['image'] != null) {
      link.images!.add(data['image']);
    }

    // Other
    if (data['videos'] != null && data['video'] is List) {
      link.videos ??= <MessageLinkVideoModel>[];
      for (final video in data['videos']) {
        link.videos!.add(MessageLinkVideoModel.fromMap(video));
      }
    }

    if (data['favicons'] != null && data['favicons'] is List) {
      link.favicons ??= <String>[];
      for (final favicon in data['favicons']) {
        link.favicons!.add(favicon);
      }
    }

    if (data['mediaType'] != null) {
      link.mediaType = data['mediaType'] as String;
    }

    if (data['title'] != null) {
      link.title = data['title'] as String;
    }

    if (data['description'] != null) {
      link.description = data['description'] as String;
    }

    if (data['siteName'] != null) {
      link.siteName = data['siteName'] as String;
    }

    if (data['contentType'] != null) {
      link.contentType = data['contentType'] as String;
    }

    return link;
  }

  // Convert to map
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['images'] = images;
    // TODO: Check if this is correct video or videos
    data['video'] = videos?.map((e) => e.toMap()).toList() ?? [];
    data['favicons'] = favicons;
    data['mediaType'] = mediaType;

    // Handle title with proper error handling for invalid URLs
    try {
      data['title'] = title ?? (url?.isNotEmpty == true ? getDomain(url: url!) : 'Unknown');
    } catch (e) {
      // If getDomain fails, use the URL itself or a fallback
      data['title'] = title ?? url ?? 'Unknown';
    }

    data['description'] = description;
    data['siteName'] = siteName;
    data['contentType'] = contentType;
    return data;
  }

  bool get hasMinimumToShow {
    return title != null && description != null;
  }

  bool get hasImage {
    return images != null && images!.isNotEmpty;
  }
}
