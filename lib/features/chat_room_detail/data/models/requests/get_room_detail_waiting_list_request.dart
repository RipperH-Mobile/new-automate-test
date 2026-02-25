import 'package:uchat/constants/uchat_constant.dart';

class GetRoomDetailMemberAndPendingRequest {
  final String roomId;
  final int pageSize;
  final int page;
  final String? keyword;

  GetRoomDetailMemberAndPendingRequest({
    required this.roomId,
    required this.page,
    this.pageSize = UChatConstant.pageSizeMembersInGroup,
    this.keyword,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'pageSize': pageSize,
      'page': page,
      'keyword': keyword,
    };
  }
}
