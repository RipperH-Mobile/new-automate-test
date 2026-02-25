import 'package:uchat/constants/uchat_constant.dart';

class GetRoomMemberAndPendingListParams {
  final String roomId;
  final int pageSize;
  final int page;
  final String? keyword;

  GetRoomMemberAndPendingListParams({
    required this.roomId,
    required this.page,
    this.pageSize = UChatConstant.maxPageSizeMembersInGroup,
    this.keyword,
  });
}
