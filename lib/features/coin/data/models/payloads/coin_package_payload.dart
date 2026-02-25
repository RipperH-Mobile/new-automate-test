import 'package:flutter/foundation.dart';
import 'package:uchat/features/coin/domain/entities/coin_package_entity.dart';

@immutable
class CoinPackageRequest {
  final String platform;

  const CoinPackageRequest({
    required this.platform,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'platform': platform,
    };
    return map;
  }
}

@immutable
class CoinPackageResponse {
  final List<CoinPackageEntity> coinPackages;

  const CoinPackageResponse({required this.coinPackages});

  factory CoinPackageResponse.fromMap(dynamic map) {
    final packageList = map as List;
    List<CoinPackageEntity> packages = packageList.map((i) => CoinPackageEntity.fromMap(i)).toList();
    return CoinPackageResponse(coinPackages: packages);
  }
}
