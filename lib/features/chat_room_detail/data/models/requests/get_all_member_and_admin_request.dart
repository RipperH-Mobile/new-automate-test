import 'package:uchat/constants/uchat_constant.dart';

class GetAllMemberAndAdminRequest {
  final String roomId;
  final int pageSize;
  final int page;
  final String? keyword;

  GetAllMemberAndAdminRequest({
    required this.roomId,
    required this.page,
    this.pageSize = UChatConstant.maxPageSizeMembersInGroup,
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
