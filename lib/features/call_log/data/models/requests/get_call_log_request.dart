import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';

class GetCallLogRequest {
  final int page;
  final int pageSize;
  final CallActionType? callActionType;
  final List<String>? accountIds;
  final List<String>? roomIds;

  GetCallLogRequest({
    required this.page,
    this.pageSize = 50,
    this.callActionType,
    this.accountIds,
    this.roomIds,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };
    if (callActionType != null) json['callActionType'] = callActionType!.value;
    if (accountIds != null) json['accountIds'] = accountIds;
    if (roomIds != null) json['roomIds'] = roomIds;
    return json;
  }
}
