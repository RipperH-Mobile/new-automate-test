import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';

class SearchAllContactResultArgument {
  final String keyword;
  final List<ContactSearchResultModel> contactPreviewList;

  SearchAllContactResultArgument({
    required this.keyword,
    required this.contactPreviewList,
  });
}
