import 'package:flutter/foundation.dart';

@immutable
class CheckStickerOwnerRequest {
  final String stickerId;
  final String targetAccountId;

  const CheckStickerOwnerRequest({
    required this.stickerId,
    required this.targetAccountId,
  });

  Map<String, dynamic> toMap() {
    return {
      'stickerId': stickerId,
      'targetAccountId': targetAccountId,
    };
  }

  factory CheckStickerOwnerRequest.fromMap(Map<String, dynamic> map) {
    return CheckStickerOwnerRequest(
      stickerId: map['stickerId'] ?? '',
      targetAccountId: map['targetAccountId'] ?? '',
    );
  }
}
