import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/coin/domain/entities/coin_entity.dart';

void main() {
  group('CoinEntity', () {
    test('Given valid coin values, When CoinEntity is created, Then all fields are set correctly', () {
      // Given
      const globalCoin = 100;
      const appleCoin = 50;
      const googlePlayCoin = 30;
      const sandboxCoin = 20;

      // When
      const coinEntity = CoinEntity(
        globalCoin: globalCoin,
        appleCoin: appleCoin,
        googlePlayCoin: googlePlayCoin,
        sandboxCoin: sandboxCoin,
      );

      // Then
      expect(coinEntity.globalCoin, equals(globalCoin));
      expect(coinEntity.appleCoin, equals(appleCoin));
      expect(coinEntity.googlePlayCoin, equals(googlePlayCoin));
      expect(coinEntity.sandboxCoin, equals(sandboxCoin));
    });

    test('Given CoinEntity on non-mobile platform, When platformCoin is accessed, Then returns 0', () {
      // Given
      const coinEntity = CoinEntity(
        globalCoin: 100,
        appleCoin: 50,
        googlePlayCoin: 30,
        sandboxCoin: 20,
      );

      // When
      final platformCoin = coinEntity.platformCoin;

      // Then
      expect(platformCoin, equals(0));
    });

    test('Given CoinEntity with appleCoin, When on iOS platform, Then platformCoin returns appleCoin', () {
      // Given
      const appleCoin = 50;
      const coinEntity = CoinEntity(
        globalCoin: 100,
        appleCoin: appleCoin,
        googlePlayCoin: 30,
        sandboxCoin: 20,
      );

      // When
      final platformCoin = coinEntity.platformCoin;

      // Then
      expect(platformCoin, equals(appleCoin));
    }, skip: !Platform.isIOS);

    test('Given CoinEntity with googlePlayCoin, When on Android platform, Then platformCoin returns googlePlayCoin', () {
      // Given
      const googlePlayCoin = 30;
      const coinEntity = CoinEntity(
        globalCoin: 100,
        appleCoin: 50,
        googlePlayCoin: googlePlayCoin,
        sandboxCoin: 20,
      );

      // When
      final platformCoin = coinEntity.platformCoin;

      // Then
      expect(platformCoin, equals(googlePlayCoin));
    }, skip: !Platform.isAndroid);

    test('Given CoinEntity with coin values, When coins is accessed, Then returns globalCoin + platformCoin', () {
      // Given
      const globalCoin = 100;
      const appleCoin = 50;
      const googlePlayCoin = 30;
      const sandboxCoin = 20;
      const coinEntity = CoinEntity(
        globalCoin: globalCoin,
        appleCoin: appleCoin,
        googlePlayCoin: googlePlayCoin,
        sandboxCoin: sandboxCoin,
      );

      // When
      final coins = coinEntity.coins;

      // Then
      expect(coins, equals(globalCoin + coinEntity.platformCoin));
    });

    test('Given CoinEntity, When toMap is called, Then returns correct Map', () {
      // Given
      const globalCoin = 100;
      const appleCoin = 50;
      const googlePlayCoin = 30;
      const sandboxCoin = 20;
      const coinEntity = CoinEntity(
        globalCoin: globalCoin,
        appleCoin: appleCoin,
        googlePlayCoin: googlePlayCoin,
        sandboxCoin: sandboxCoin,
      );

      // When
      final map = coinEntity.toMap();

      // Then
      expect(map, equals({
        'globalCoin': globalCoin,
        'appleCoin': appleCoin,
        'googlePlayCoin': googlePlayCoin,
        'sandboxCoin': sandboxCoin,
      }));
    });

    test('Given valid map, When CoinEntity.fromMap is called, Then returns correct CoinEntity', () {
      // Given
      const map = {
        'globalCoin': 100,
        'appleCoin': 50,
        'googlePlayCoin': 30,
        'sandboxCoin': 20,
      };

      // When
      final coinEntity = CoinEntity.fromMap(map);

      // Then
      expect(coinEntity.globalCoin, equals(100));
      expect(coinEntity.appleCoin, equals(50));
      expect(coinEntity.googlePlayCoin, equals(30));
      expect(coinEntity.sandboxCoin, equals(20));
    });

    test('Given map with null sandboxCoin, When CoinEntity.fromMap is called, Then sandboxCoin defaults to 0', () {
      // Given
      const map = {
        'globalCoin': 100,
        'appleCoin': 50,
        'googlePlayCoin': 30,
        'sandboxCoin': null,
      };

      // When
      final coinEntity = CoinEntity.fromMap(map);

      // Then
      expect(coinEntity.sandboxCoin, equals(0));
    });

    test('Given CoinEntity, When toJson and fromJson are used, Then round trip preserves data', () {
      // Given
      const coinEntity = CoinEntity(
        globalCoin: 100,
        appleCoin: 50,
        googlePlayCoin: 30,
        sandboxCoin: 20,
      );

      // When
      final jsonString = coinEntity.toJson();
      final reconstructed = CoinEntity.fromJson(jsonString);

      // Then
      expect(reconstructed.globalCoin, equals(coinEntity.globalCoin));
      expect(reconstructed.appleCoin, equals(coinEntity.appleCoin));
      expect(reconstructed.googlePlayCoin, equals(coinEntity.googlePlayCoin));
      expect(reconstructed.sandboxCoin, equals(coinEntity.sandboxCoin));
    });
  });
}