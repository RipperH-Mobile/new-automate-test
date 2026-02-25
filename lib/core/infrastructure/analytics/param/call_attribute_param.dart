import 'package:uchat/core/infrastructure/analytics/enum/receive_method.dart';

class CallAttributesParams {
    final String? roomCallId;
  final String? callType;
  final String? roomType;
  final ReceiveMethod? receivingFrom;

  CallAttributesParams({
    this.roomCallId,
    this.callType,
    this.roomType,
    this.receivingFrom,
  });

  Map<String, String> toNameValuePairs() {
    final Map<String, String> attributes = {};

    if (roomCallId != null) attributes['roomCallId'] = roomCallId!;
    if (callType != null) attributes['callType'] = callType!;
    if (roomType != null) attributes['roomType'] = roomType!;

    return attributes;
  }
}
