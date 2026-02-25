import 'package:uchat/entities/enum/chat_category_type.dart';

class ChatCategoryModel {
  String name;
  ChatCategoryType type;
  int seq;

  ChatCategoryModel({
    required this.name,
    required this.type,
    required this.seq,
  });
}
