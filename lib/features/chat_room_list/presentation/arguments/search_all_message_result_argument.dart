import 'package:uchat/features/chat_room_list/data/models/search_messages_result_model.dart';

class SearchAllMessageResultArgument {
  final String keyword;
  final List<SearchMessagesResultModel> messagePreviewList;
  final int allMessageCount;

  SearchAllMessageResultArgument({
    required this.keyword,
    required this.messagePreviewList,
    required this.allMessageCount,
  });
}
