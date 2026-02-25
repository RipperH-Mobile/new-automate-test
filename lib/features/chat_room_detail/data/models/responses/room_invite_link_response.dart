// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class RoomInviteLinkResponse {
  final String? inviteLink;
  final bool isActive;

  const RoomInviteLinkResponse({
    this.inviteLink,
    required this.isActive,
  });

  RoomInviteLinkResponse copyWith({
    String? inviteLink,
    bool? isActive,
  }) {
    return RoomInviteLinkResponse(
      inviteLink: inviteLink ?? this.inviteLink,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inviteLink': inviteLink,
      'isActive': isActive,
    };
  }

  factory RoomInviteLinkResponse.fromMap(Map<String, dynamic> map) {
    final data = map['data'] as Map<String, dynamic>? ?? {};
    return RoomInviteLinkResponse(
      inviteLink: data['inviteLink'] != null ? data['inviteLink'] as String : null,
      isActive: data['isActive'] != null ? data['isActive'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomInviteLinkResponse.fromJson(String source) =>
      RoomInviteLinkResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
