import 'package:uchat/features/report/data/models/enum/report_topic.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';

class ReportRequest {
  final ReportType reportType;
  final ReportTopic reportTopic;
  final String remark;
  final ReportRequestMeta meta;

  ReportRequest({
    required this.reportType,
    required this.reportTopic,
    required this.remark,
    required this.meta,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'type': reportType.value,
      'topic': reportTopic.value,
    };
    json['remark'] = remark;
    json['meta'] = meta.toJson();
    return json;
  }
}

class ReportRequestMeta {
  final String? roomId;
  final String? messageId;
  final String? userId;

  ReportRequestMeta({
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

  ReportRequestMeta copyWith({
    String? roomId,
    String? messageId,
    String? userId,
  }) {
    return ReportRequestMeta(
      roomId: roomId ?? this.roomId,
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
    );
  }
}
