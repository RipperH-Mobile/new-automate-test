import 'package:uchat/features/report/data/models/enum/report_topic.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';

class ReportEntity {
  ReportType reportType;
  ReportTopic? reportTopic;
  String? remark;
  String? roomId;
  String? messageId;
  String? userId;

  ReportEntity({
    required this.reportType,
    this.reportTopic,
    this.remark,
    this.roomId,
    this.messageId,
    this.userId,
  });

  set setReportTopic(ReportTopic reportTopic) {
    reportTopic = reportTopic;
  }

  set setRemark(String remark) {
    remark = remark;
  }

  set setRoomId(String roomId) {
    roomId = roomId;
  }

  set setMessageId(String messageId) {
    messageId = messageId;
  }

  set setUserId(String userId) {
    userId = userId;
  }

  get getReportType => reportType;
  get getReportTopic => reportTopic;
  get getRemark => remark;
  get getRoomId => roomId;
  get getMessageId => messageId;
  get getUserId => userId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'type': reportType.value,
    };
    if (reportTopic != null) {
      json['topic'] = reportTopic!.value;
    }
    if (remark != null) {
      json['remark'] = remark;
    }
    if (roomId != null) {
      json['roomId'] = roomId;
    }
    if (messageId != null) {
      json['messageId'] = messageId;
    }
    if (userId != null) {
      json['userId'] = userId;
    }
    return json;
  }
}
