import 'package:uchat/features/coin/domain/entities/coin_entity.dart';
import 'package:uchat/features/coin/domain/repositories/coin_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchMyCoinUseCase extends SimpleUseCase<CoinEntity?, NoParams> {
  final CoinRemoteRepository coinRemoteRepository;

  FetchMyCoinUseCase({
    required this.coinRemoteRepository,
  });

  @override
  Future<CoinEntity?> call(NoParams params) async {
    return await coinRemoteRepository.getMyCoin();
  }
}
