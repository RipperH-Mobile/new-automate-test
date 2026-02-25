import 'package:flutter/foundation.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_refund_entity.dart';

@immutable
class CoinTransactionMetaEntity {
  // for spend type
  final String? stickerId;
  final String? type;
  final String? platform;
  final String? targetAccountId;
  final String? stickerName;
  final String? displayName;

  // for refund type
  final String? notificationType;
  final DateTime? notificationUUID;
  final CoinTransactionRefundEntity? data;
  final String? version;
  final DateTime? signedDate;
  final int? iat;

  const CoinTransactionMetaEntity({
    this.stickerId,
    this.type,
    this.platform,
    this.targetAccountId,
    this.stickerName,
    this.displayName,
    this.notificationType,
    this.notificationUUID,
    this.data,
    this.version,
    this.signedDate,
    this.iat,
  });

  factory CoinTransactionMetaEntity.fromMap(Map<String, dynamic> map) {
    return CoinTransactionMetaEntity(
      stickerId: map['stickerId'],
      type: map['type'],
      platform: map['platform'],
      targetAccountId: map['targetAccountId'],
      stickerName: map['stickerName'],
      displayName: map['displayName'] ?? '',
      notificationType: map['notificationType'] ?? '',
      notificationUUID: map['notificationUUID'] != null ? DateTime.parse(map['notificationUUID']) : null,
      data: map['data'] != null ? CoinTransactionRefundEntity.fromMap(map['data']) : null,
      version: map['version'] ?? '',
      signedDate: map['signedDate'] != null ? DateTime.parse(map['signedDate']) : null,
      iat: map['iat'] ?? 0,
    );
  }
}
