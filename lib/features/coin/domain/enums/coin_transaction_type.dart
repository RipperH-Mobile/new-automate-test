enum CoinTransactionType {
  topUp,
  spend,
  refund;

  String get value {
    switch (this) {
      case CoinTransactionType.topUp:
        return 'TOPUP';
      case CoinTransactionType.spend:
        return 'SPEND';
      case CoinTransactionType.refund:
        return 'REFUND';
    }
  }

  static CoinTransactionType? from(String? val) {
    if (val == null) return null;
    switch (val) {
      case 'TOPUP':
        return CoinTransactionType.topUp;
      case 'SPEND':
        return CoinTransactionType.spend;
      case 'REFUND':
        return CoinTransactionType.refund;
      default:
        return null;
    }
  }
}
