import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class CentralNotificationParam {
  int page;
  int pageSize;

  CentralNotificationParam({
    required this.page,
    required this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
    };
  }
}

class CentralNotificationResponse {
  List<CentralNotificationCollection> centralNotiList;
  int total;
  int page;
  int pageSize;
  int totalPage;
  int notiUnreadCount;

  CentralNotificationResponse({
    required this.centralNotiList,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPage,
    required this.notiUnreadCount,
  });

  factory CentralNotificationResponse.fromMap(Map<String, dynamic> json) {
    List<CentralNotificationCollection> centralNotiData = [];

    if (json['data'] != null) {
      for (Map<String, dynamic> data in json['data']) {
        try {
          centralNotiData.add(CentralNotificationCollection.fromMap(data));
        } catch (e) {
          _log.w('CentralNotificationResponse.fromMap error.', e);
        }
      }
    }

    return CentralNotificationResponse(
      centralNotiList: centralNotiData,
      total: json['pagination']?['total'] ?? 0,
      page: json['pagination']?['page'] ?? 0,
      pageSize: json['pagination']?['pageSize'] ?? 0,
      totalPage: json['pagination']?['totalPages'] ?? 0,
      notiUnreadCount: json['metadata']?['notiUnreadCount'] ?? 0,
    );
  }
}
