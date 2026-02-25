import 'package:uchat/constants/uchat_constant.dart';

class FetchRoomLinksParams {
  final String roomId;
  final int page;
  final int pageSize;

  FetchRoomLinksParams({
    required this.roomId,
    required this.page,
    this.pageSize = UChatConstant.pageSizeInRoomDetailLinks,
  });
}