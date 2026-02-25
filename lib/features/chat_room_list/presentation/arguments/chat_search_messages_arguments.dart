import 'package:uchat/features/chat_room_list/data/models/search_messages_result_model.dart';

class ChatSearchMessagesArguments {
  final String keyword;
  final SearchMessagesResultModel searchResult;

  ChatSearchMessagesArguments({
    required this.keyword,
    required this.searchResult,
  });
}
