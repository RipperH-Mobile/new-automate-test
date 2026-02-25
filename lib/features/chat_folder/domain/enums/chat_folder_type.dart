import 'package:get/get.dart';

enum ChatFolderType {
  all('ALL'),
  normal('NORMAL'),
  unread('UNREAD'),
  direct('DIRECT'),
  secret('SECRET'),
  group('GROUP'),
  oa('OA');

  final String value;
  const ChatFolderType(this.value);

  factory ChatFolderType.fromString(String stateName) {
    return values.firstWhere((e) => e.value == stateName);
  }

  String get displayName {
    switch (this) {
      case ChatFolderType.all:
        return 'All chat'.tr;
      case ChatFolderType.normal:
        return 'Normal'.tr;
      case ChatFolderType.unread:
        return 'Unread'.tr;
      case ChatFolderType.direct:
        return 'Direct'.tr;
      case ChatFolderType.secret:
        return 'Secret'.tr;
      case ChatFolderType.group:
        return 'Group chat'.tr;
      case ChatFolderType.oa:
        return 'Official Account'.tr;
      }
  }

  String get description {
    switch (this) {
      case ChatFolderType.all:
        return 'Show all messages from every chats'.tr;
      case ChatFolderType.normal:
        return '';
      case ChatFolderType.unread:
        return 'Show new messages from every chats'.tr;
      case ChatFolderType.direct:
        return 'Show only messages from direct chats'.tr;
      case ChatFolderType.secret:
        return 'Show only messages from secret chats'.tr;
      case ChatFolderType.group:
        return 'Show only messages from group chats'.tr;
      case ChatFolderType.oa:
        return 'Show only messages from Official accounts'.tr;
      }
  }
}
