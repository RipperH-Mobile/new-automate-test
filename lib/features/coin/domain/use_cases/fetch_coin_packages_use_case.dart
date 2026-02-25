import 'dart:io';

import 'package:uchat/features/coin/data/models/payloads/coin_package_payload.dart';
import 'package:uchat/features/coin/domain/entities/coin_package_entity.dart';
import 'package:uchat/features/coin/domain/repositories/coin_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchCoinPackagesUseCase extends SimpleUseCase<List<CoinPackageEntity>, NoParams> {
  final CoinRemoteRepository coinRemoteRepository;

  FetchCoinPackagesUseCase({
    required this.coinRemoteRepository,
  });

  String _getPlatform(String os) {
    if (os == 'android') return 'GOOGLE_PLAY';
    if (os == 'ios') return 'APPLE';
    return '';
  }

  @override
  Future<List<CoinPackageEntity>> call(NoParams params) async {
    final os = _getPlatform(Platform.operatingSystem);
    final coinPackages = await coinRemoteRepository.getCoinPackages(CoinPackageRequest(platform: os));

    if (coinPackages.isEmpty) {
      return [];
    }

    // Sort coin packages by coin amount
    coinPackages.sort((a, b) => a.coin.compareTo(b.coin));
    return coinPackages;
  }
}
