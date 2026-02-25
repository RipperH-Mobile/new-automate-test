import 'package:uchat/entities/enum/report_topic.dart';
import 'package:uchat/entities/enum/report_type.dart';

class OpenSupportTicketRequest {
  final ReportType type;
  final ReportTopic topic;
  final String? remark;
  final MetaSendReportRequest? meta;

  OpenSupportTicketRequest({
    required this.type,
    required this.topic,
    this.remark,
    this.meta,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'type': type.value,
      'topic': topic.value,
    };
    if (remark != null) {
      json['remark'] = remark;
    }
    if (meta != null) {
      json['meta'] = meta!.toJson();
    }
    return json;
  }
}

class MetaSendReportRequest {
  final String? roomId;
  final String? messageId;
  final String? userId;

  MetaSendReportRequest({
    this.roomId,
    this.messageId,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
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

  MetaSendReportRequest copyWith({
    String? roomId,
    String? messageId,
    String? userId,
  }) {
    return MetaSendReportRequest(
      roomId: roomId ?? this.roomId,
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
    );
  }
}
