import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/sticker/data/data_sources/local/sticker_db.dart';
import 'package:uchat/features/sticker/data/models/collections/my_sticker_collection.dart';
import 'package:uchat/features/sticker/data/repositories/my_sticker_local_repository_impl.dart';
import 'package:uchat/features/sticker/domain/sticker_domain.dart';

class MockStickerDb extends Mock implements StickerDb {}

void main() {
  late MyStickerLocalRepository repo;
  late MockStickerDb mockStickerDb;

  setUpAll(() {
    mockStickerDb = MockStickerDb();

    repo = MyStickerLocalRepositoryImpl(
      stickerDb: mockStickerDb,
    );
  });

  test('When every pack do not have expireAt value, Return the list normally', () async {
    // Given
    final packA = MyStickerCollection(
      id: 'packA',
      name: 'Pack A',
      seq: 1,
    );
    final packB = MyStickerCollection(
      id: 'packB',
      name: 'Pack B',
      seq: 2,
    );
    final packC = MyStickerCollection(
      id: 'packC',
      name: 'Pack C',
      seq: 3,
    );
    final packD = MyStickerCollection(
      id: 'packD',
      name: 'Pack D',
      seq: 4,
    );
    when(() => mockStickerDb.getAllMyStickerPack()).thenAnswer((_) async => [packA, packB, packC, packD]);

    // When
    final result = await repo.getAllMyStickerPack();

    // Then
    expect(result, [packA.toEntity(), packB.toEntity(), packC.toEntity(), packD.toEntity()]);
  });

  test('When there is an expire pack, Return list with expired pack at the end of a list', () async {
    // Given
    final packA = MyStickerCollection(
      id: 'packA',
      name: 'Pack A',
      seq: 1,
    );
    final packB = MyStickerCollection(
      id: 'packB',
      name: 'Pack B',
      seq: 2,
      expireAt: DateTime.now().subtract(const Duration(days: 1)), // Expired pack
    );
    final packC = MyStickerCollection(
      id: 'packC',
      name: 'Pack C',
      seq: 3,
    );
    final packD = MyStickerCollection(
      id: 'packD',
      name: 'Pack D',
      seq: 4,
    );
    when(() => mockStickerDb.getAllMyStickerPack()).thenAnswer((_) async => [packA, packB, packC, packD]);

    // When
    final result = await repo.getAllMyStickerPack();

    // Then
    expect(result, [packA.toEntity(), packC.toEntity(), packD.toEntity(), packB.toEntity()]);
  });

  test('When there is multiple expire packs, Return list with expired packs at the end of a list', () async {
    // Given
    final packA = MyStickerCollection(
      id: 'packA',
      name: 'Pack A',
      seq: 1,
    );
    final packB = MyStickerCollection(
      id: 'packB',
      name: 'Pack B',
      seq: 2,
      expireAt: DateTime.now().subtract(const Duration(days: 1)), // Expired pack
    );
    final packC = MyStickerCollection(
      id: 'packC',
      name: 'Pack C',
      seq: 3,
      expireAt: DateTime.now().subtract(const Duration(days: 1)), // Expired pack
    );
    final packD = MyStickerCollection(
      id: 'packD',
      name: 'Pack D',
      seq: 4,
    );
    when(() => mockStickerDb.getAllMyStickerPack()).thenAnswer((_) async => [packA, packB, packC, packD]);

    // When
    final result = await repo.getAllMyStickerPack();

    // Then
    expect(result, [packA.toEntity(), packD.toEntity(), packB.toEntity(), packC.toEntity()]);
  });
}
