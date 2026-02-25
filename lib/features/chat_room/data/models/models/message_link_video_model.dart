import 'package:isar_community/isar.dart';

part 'message_link_video_model.g.dart';

@embedded
class MessageLinkVideoModel {
  String? url;
  String? secureUrl;
  String? type;
  String? width;
  String? height;

  MessageLinkVideoModel({
    this.url,
    this.secureUrl,
    this.type,
    this.width,
    this.height,
  });

  factory MessageLinkVideoModel.fromMap(Map<String, dynamic> data) {
    return MessageLinkVideoModel(
      url: data['url'],
      secureUrl: data['secureUrl'],
      type: data['type'],
      width: data['width'],
      height: data['height'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'secureUrl': secureUrl,
      'type': type,
      'width': width,
      'height': height,
    };
  }
}
