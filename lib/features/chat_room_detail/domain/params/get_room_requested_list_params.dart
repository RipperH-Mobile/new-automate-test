import 'package:uchat/constants/uchat_constant.dart';

class GetRoomRequestedListParams {
  final String roomId;
  final int page;
  final int pageSize;

  GetRoomRequestedListParams({
    required this.roomId,
    required this.page,
    this.pageSize = UChatConstant.pageSizeMembersInGroup,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'page': page,
      'pageSize': pageSize,
    };
  }
}
