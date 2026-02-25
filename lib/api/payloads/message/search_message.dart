import 'package:get_it/get_it.dart';
import 'package:uchat/entities/models/search_messages_result_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

// Universal Search Request
class SearchMessagesRequest {
  final String keyword;
  final int? page;
  final int? pageSize;

  SearchMessagesRequest({
    required this.keyword,
    this.page,
    this.pageSize,
  });

  SearchMessagesRequest copyWith({
    String? keyword,
    int? page,
    int? pageSize,
  }) {
    return SearchMessagesRequest(
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keyword': keyword,
      'page': page,
      'pageSize': pageSize,
    };
  }

  factory SearchMessagesRequest.fromJson(Map<String, dynamic> map) {
    return SearchMessagesRequest(
      keyword: map['keyword'] as String,
      page: map['page'] != null ? map['page'] as int : null,
      pageSize: map['pageSize'] != null ? map['pageSize'] as int : null,
    );
  }

  @override
  String toString() => 'SearchUniversalRequest(keyword: $keyword, page: $page, pageSize: $pageSize)';

  @override
  bool operator ==(covariant SearchMessagesRequest other) {
    if (identical(this, other)) return true;

    return other.keyword == keyword && other.page == page && other.pageSize == pageSize;
  }

  @override
  int get hashCode => keyword.hashCode ^ page.hashCode ^ pageSize.hashCode;
}

// Universal Search Response
class SearchMessagesResponse {
  List<SearchMessagesResultModel> resultList;

  SearchMessagesResponse({required this.resultList});

  // Static async function to fetch room details locally
  static Future<SearchMessagesResponse> fromList(List<dynamic> data) async {
    List<SearchMessagesResultModel> dataList = [];
    RoomDb roomDb = GetIt.I<RoomDb>();

    for (final result in data) {
      String roomId = result['_id'];

      // Retrieve the room information from the database
      RoomCollection? room = await roomDb.getRoom(roomId);

      if (room != null) {
        dataList.add(SearchMessagesResultModel(
          room: room,
          foundMessageCount: result['foundMessageCount'],
        ));
      } else {
        dataList.add(SearchMessagesResultModel(
          room: RoomCollection.fromMap(result),
          foundMessageCount: result['foundMessageCount'],
        ));
      }
    }

    return SearchMessagesResponse(resultList: dataList);
  }
}
