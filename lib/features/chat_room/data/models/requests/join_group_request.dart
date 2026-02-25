// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

@immutable
class JoinGroupRequest {
  final String roomId;
  final bool isViaLink;

  const JoinGroupRequest({
    required this.roomId,
    this.isViaLink = false,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'roomId': roomId,
      'isViaLink': isViaLink,
    };

    return json;
  }

  @override
  String toString() => 'JoinGroupRequest(roomId: $roomId, isViaLink: $isViaLink)';
}
