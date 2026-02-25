import 'package:uchat/entities/enum/online_status.dart';

class UpdateOnlineStatusRequest {
  OnlineStatus onlineStatus;

  UpdateOnlineStatusRequest({required this.onlineStatus});

  Map<String, dynamic> toMap() {
    return {
      'onlineStatus': onlineStatus.value,
    };
  }
}

class UpdateOnlineStatusResponse {
  String id;
  OnlineStatus onlineStatus;

  UpdateOnlineStatusResponse({
    required this.id,
    required this.onlineStatus,
  });

  static UpdateOnlineStatusResponse fromMap(Map<String, dynamic> data) {
    return UpdateOnlineStatusResponse(
      id: data['_id'],
      onlineStatus: OnlineStatus.from(data['onlineStatus'])!,
    );
  }
}
