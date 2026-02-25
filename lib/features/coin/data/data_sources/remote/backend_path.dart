import 'package:uchat/api/backend_path.dart';

class CoinBackendPath {
  CoinBackendPath._();

  static const verifyPurchaseApple = BackendPathModel(
    http: 'v3/coins/topup/apple',
    socket: 'v3.coins.topup.apple.post',
  );

  static const verifyPurchaseAndroid = BackendPathModel(
    http: 'v3/coins/topup/google-play',
    socket: 'v3.coins.topup.googlePlay.post',
  );

  static const getTransactions = BackendPathModel(
    http: 'v3/coins/transactions',
    socket: 'v3.coins.transactions.get',
  );

  static const getMyCoins = BackendPathModel(
    http: 'v3/users/coins',
    socket: 'v3.accounts.coins.get',
  );

  static const getCoinPackages = BackendPathModel(
    http: 'v3/coins/packages/:platform',
    socket: 'v3.coins.packages.get',
  );

  static const sendCoinRefundReason = BackendPathModel(
    http: 'v3/coins/refund-reason',
    socket: 'v3.coins.refundReason.post',
  );

  static const getPendingRefundReason = BackendPathModel(
    http: 'v3/coins/refund-reason/pending',
    socket: 'v3.coins.pendingRefundReason.get',
  );
}
