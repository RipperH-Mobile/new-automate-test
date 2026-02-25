import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class SendGiftResponse {
  final int globalCoin;
  final int googlePlayCoin;
  final int appleCoin;

  const SendGiftResponse({
    required this.globalCoin,
    required this.googlePlayCoin,
    required this.appleCoin,
  });

  factory SendGiftResponse.fromMap(Map<String, dynamic> json) {
    return SendGiftResponse(
      globalCoin: json['coin']['globalCoin'],
      googlePlayCoin: json['coin']['googlePlayCoin'],
      appleCoin: json['coin']['appleCoin'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'globalCoin': globalCoin,
      'googlePlayCoin': googlePlayCoin,
      'appleCoin': appleCoin,
    };
  }

  String toJson() => json.encode(toMap());

  factory SendGiftResponse.fromJson(String source) =>
      SendGiftResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

@immutable
class SendGiftRequest {
  final String stickerId;
  final String type;
  final String platform;
  final String targetAccountId;

  const SendGiftRequest({
    required this.stickerId,
    required this.type,
    required this.platform,
    required this.targetAccountId,
  });
  Map<String, dynamic> toMap() {
    return {
      'stickerId': stickerId,
      'type': type,
      'platform': platform,
      'targetAccountId': targetAccountId,
    };
  }

  factory SendGiftRequest.fromMap(Map<String, dynamic> map) {
    return SendGiftRequest(
      stickerId: map['stickerId'] ?? '',
      type: map['type'] ?? '',
      platform: map['platform'] ?? '',
      targetAccountId: map['targetAccountId'] ?? '',
    );
  }
}
