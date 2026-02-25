import 'package:flutter/foundation.dart';
import 'package:uchat/features/coin/data/models/models/coin_transaction_refund_model.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_meta_entity.dart';

@immutable
class CoinTransactionMetaModel {
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
  final CoinTransactionRefundModel? data;
  final String? version;
  final DateTime? signedDate;
  final int? iat;

  const CoinTransactionMetaModel({
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

  factory CoinTransactionMetaModel.fromMap(Map<String, dynamic> map) {
    return CoinTransactionMetaModel(
      stickerId: map['stickerId'],
      type: map['type'],
      platform: map['platform'],
      targetAccountId: map['targetAccountId'],
      stickerName: map['stickerName'],
      displayName: map['displayName'] ?? '',
      notificationType: map['notificationType'] ?? '',
      notificationUUID: map['notificationUUID'] != null ? DateTime.parse(map['notificationUUID']) : null,
      data: map['data'] != null ? CoinTransactionRefundModel.fromMap(map['data']) : null,
      version: map['version'] ?? '',
      signedDate: map['signedDate'] != null ? DateTime.parse(map['signedDate']) : null,
      iat: map['iat'] ?? 0,
    );
  }

  CoinTransactionMetaModel copyWith({
    String? stickerId,
    String? type,
    String? platform,
    String? targetAccountId,
    String? stickerName,
    String? displayName,
    String? notificationType,
    DateTime? notificationUUID,
    CoinTransactionRefundModel? data,
    String? version,
    DateTime? signedDate,
    int? iat,
  }) {
    return CoinTransactionMetaModel(
      stickerId: stickerId ?? this.stickerId,
      type: type ?? this.type,
      platform: platform ?? this.platform,
      targetAccountId: targetAccountId ?? this.targetAccountId,
      stickerName: stickerName ?? this.stickerName,
      displayName: displayName ?? this.displayName,
      notificationType: notificationType ?? this.notificationType,
      notificationUUID: notificationUUID ?? this.notificationUUID,
      data: data ?? this.data,
      version: version ?? this.version,
      signedDate: signedDate ?? this.signedDate,
      iat: iat ?? this.iat,
    );
  }

  CoinTransactionMetaEntity toEntity() {
    return CoinTransactionMetaEntity(
      stickerId: stickerId,
      type: type,
      platform: platform,
      targetAccountId: targetAccountId,
      stickerName: stickerName,
      displayName: displayName,
      notificationType: notificationType,
      notificationUUID: notificationUUID,
      data: data?.toEntity(),
      version: version,
      signedDate: signedDate,
      iat: iat,
    );
  }
}
