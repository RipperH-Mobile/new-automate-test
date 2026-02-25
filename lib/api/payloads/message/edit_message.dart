import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';

class EditMessageRequest {
  String newMessage;
  String messageId;
  bool isEncrypted;
  MessageMetaModel? meta;
  List<MessageLinkModel>? links;

  EditMessageRequest({
    required this.messageId,
    required this.newMessage,
    required this.isEncrypted,
    this.meta,
    this.links,
  });

  Map<String, dynamic> toMap() {
    final linksMap = [];
    if (links != null) {
      for (var link in links!) {
        linksMap.add(link.toMap());
      }
    }

    Map<String, dynamic> json = {
      'messageId': messageId,
      'newMessage': newMessage,
      'isEncrypted': isEncrypted,
      'meta': {
        'isEmoji': meta?.isEmoji,
        'isRegEx': meta?.isRegEx,
      },
      'links': linksMap,
    };

    return json;
  }
}
