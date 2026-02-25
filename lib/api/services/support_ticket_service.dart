import 'dart:async';

import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';

class SupportTicketService with ServiceMixin {
  /// Instance
  static final SupportTicketService instance = SupportTicketService.internal();

  factory SupportTicketService() => instance;

  SupportTicketService.internal();

  /// ServiceMethod
  // TODO update this function to use [OpenSupportTicketRequest] instead.
  Future<bool> openTicket(
    String type,
    String topic,
    String remark,
    String messageId,
    String roomId,
    String userId,
  ) async {
    await socketCaller.emitCall(
      BackendPath.openSupportTicket.socket,
      {
        'type': type,
        'topic': topic,
        'remark': remark,
        'meta': {
          'messageId': messageId,
          'roomId': roomId,
          'userId': userId,
        },
      },
    );

    return true;
  }
}
