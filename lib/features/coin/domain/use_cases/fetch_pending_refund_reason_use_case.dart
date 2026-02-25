import 'package:uchat/features/coin/data/models/payloads/coin_pending_refund_reason_payload.dart';
import 'package:uchat/features/coin/domain/repositories/coin_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchPendingRefundReasonUseCase
    extends SimpleUseCase<CoinPendingRefundReasonResponse?, CoinPendingRefundReasonRequest> {
  final CoinRemoteRepository coinRemoteRepository;

  FetchPendingRefundReasonUseCase({
    required this.coinRemoteRepository,
  });

  @override
  Future<CoinPendingRefundReasonResponse?> call(CoinPendingRefundReasonRequest params) async {
    return await coinRemoteRepository.fetchPendingRefundReasons(params);
  }
}
