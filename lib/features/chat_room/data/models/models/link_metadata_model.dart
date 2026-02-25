import 'package:any_link_preview/any_link_preview.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';

class LinkMetadataModel {
  final String? title;
  final String? description;
  final String? image;
  final String url;
  final bool show;
  final String? siteName;

  LinkMetadataModel({
    required this.url,
    this.title,
    this.description,
    this.image,
    this.show = true,
    this.siteName,
  });

  factory LinkMetadataModel.fromAnyLinkPreview({required Metadata metadata, String? url}) {
    return LinkMetadataModel(
      title: metadata.title,
      description: metadata.desc,
      image: metadata.image,
      url: url ?? metadata.url!,
      siteName: metadata.siteName,
    );
  }

  factory LinkMetadataModel.fromJson(Map<String, dynamic> json) {
    return LinkMetadataModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      url: json['url'],
      show: json['show'],
      siteName: json['siteName'],
    );
  }

  MessageLinkModel toMessageLinkModel() {
    return MessageLinkModel(
      url: url,
      title: title,
      description: description,
      images: image != null ? [image!] : [],
      siteName: siteName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'contentType': 'text/html',
      'mediaType': 'website',
      'image': [image],
      'favicons': [image],
      'siteName': siteName,
    };
  }

  @override
  bool operator ==(covariant LinkMetadataModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.image == image &&
        other.url == url &&
        other.show == show &&
        other.siteName == siteName;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode ^ image.hashCode ^ url.hashCode ^ show.hashCode ^ siteName.hashCode;
  }

  LinkMetadataModel copyWith({
    String? title,
    String? description,
    String? image,
    String? url,
    bool? show,
    String? siteName,
  }) {
    return LinkMetadataModel(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      url: url ?? this.url,
      show: show ?? this.show,
      siteName: siteName ?? this.siteName,
    );
  }

  @override
  String toString() {
    return 'LinkMetadataModel(title: $title, description: $description, image: $image, url: $url, show: $show)';
  }
}
