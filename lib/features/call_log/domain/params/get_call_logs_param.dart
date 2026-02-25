import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';

class GetCallLogsParam {
  final int page;
  final int pageSize;
  final CallActionType? callActionType;
  final List<String>? accountIds;
  final List<String>? roomIds;

  const GetCallLogsParam({
    required this.page,
    this.pageSize = 50,
    this.callActionType,
    this.accountIds,
    this.roomIds,
  });
}
