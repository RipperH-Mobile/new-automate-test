import 'package:uchat/features/coin/data/models/payloads/coin_refund_reason_payload.dart';
import 'package:uchat/features/coin/domain/repositories/coin_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SendCoinRefundReasonUseCase extends SimpleUseCase<void, CoinRefundReasonRequest> {
  final CoinRemoteRepository coinRemoteRepository;

  SendCoinRefundReasonUseCase({
    required this.coinRemoteRepository,
  });

  @override
  Future<void> call(CoinRefundReasonRequest params) async {
    return await coinRemoteRepository.sendCoinRefundReason(params);
  }
}
