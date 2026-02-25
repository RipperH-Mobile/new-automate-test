import 'package:uchat/constants/uchat_constant.dart';

class GetSessionsListRequest {
  final String? actionToken;
  final int? page;
  final int? pageSize;

  GetSessionsListRequest({
    this.actionToken,
    this.page,
    this.pageSize = UChatConstant.pageSizeInGetSessionsList,
  });

  Map<String, dynamic> toMap() {
    return {
      'actionToken': actionToken,
      'page': page,
      'pageSize': pageSize,
    };
  }
}
