import 'package:isar_community/isar.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'iap_transaction_collection.g.dart';

/// This collection is used to save unfinished in app purchase data to be used or
/// sent to server when there are problems verifying purchase and verification can't
/// be done right away.
/// If there are no pending purchase needed to be verify this collection should be empty.
@Collection(accessor: 'iapTransactions')
@Name('IapTransaction')
class IapTransactionCollection {
  /// Purchase Id / transaction identifier of a in app purchase
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id!);

  @Index()
  String? productId;

  String? status;

  String? localVerificationData;

  /// Server verification data, Send this to backend to verify purchase with App store / Play store.
  String? serverVerificationData;

  IapTransactionCollection({
    required this.id,
    required this.productId,
    required this.status,
    required this.localVerificationData,
    required this.serverVerificationData,
  });

  @override
  bool operator ==(Object other) {
    return other is IapTransactionCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return '[IapTransactionCollection] ID: $id,\n'
        'productId: $productId,\n'
        'status: $status\n'
        'localVerificationData: $localVerificationData\n'
        'serverVerificationData: $serverVerificationData';
  }
}
