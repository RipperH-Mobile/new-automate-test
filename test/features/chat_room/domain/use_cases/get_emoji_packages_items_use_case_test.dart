import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_package_items_request.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_with_items_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/emoji_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_emoji_packages_items_use_case.dart';

class MockEmojiServerRepository extends Mock implements EmojiServerRepository {}

void main() {
  late GetEmojiPackagesItemsUseCase useCase;
  late MockEmojiServerRepository mockEmojiRepository;

  setUp(() {
    mockEmojiRepository = MockEmojiServerRepository();
    useCase = GetEmojiPackagesItemsUseCase(
      emojiRepository: mockEmojiRepository,
    );
  });

  group('GetEmojiPackagesItemsUseCase', () {
    const testEmojiPackageId = 'test-package-id';
    final testRequest = GetEmojiPackageItemsRequest(
      emojiPackageId: testEmojiPackageId,
    );

    final testEmojiPackageWithItems = EmojiPackageWithItemsEntity(
      id: 'item-1',
      description: 'Test Description',
      coverId: 'cover-file-id',
      isDefault: false,
      isPublish: true,
      emojiItems: [],
      createdAt: DateTime(2023, 1, 1),
      updatedAt: DateTime(2023, 1, 1),
    );

    final testResponse = PaginationPayload<EmojiPackageWithItemsEntity>(
      data: [testEmojiPackageWithItems],
      total: 1,
      page: 1,
      pageSize: 10,
      totalPages: 1,
    );

    test('Given a valid request, When call is executed, Then returns emoji package with items', () async {
      // Given
      when(() => mockEmojiRepository.getEmojiPackagesItems(testRequest)).thenAnswer((_) async => testResponse);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(testResponse));
      expect(result.data, hasLength(1));
      expect(result.data!.first.id, equals('item-1'));
      expect(result.data!.first.description, equals('Test Description'));
      verify(() => mockEmojiRepository.getEmojiPackagesItems(testRequest)).called(1);
    });

    test('Given repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      const exception = 'Network error';
      when(() => mockEmojiRepository.getEmojiPackagesItems(testRequest)).thenThrow(exception);

      // When & Then
      expect(
        () async => await useCase.call(testRequest),
        throwsA(equals(exception)),
      );
      verify(() => mockEmojiRepository.getEmojiPackagesItems(testRequest)).called(1);
    });

    test('Given empty response, When call is executed, Then returns empty emoji packages list', () async {
      // Given
      final emptyResponse = PaginationPayload<EmojiPackageWithItemsEntity>(
        data: [],
        total: 0,
        page: 1,
        pageSize: 10,
        totalPages: 0,
      );
      when(() => mockEmojiRepository.getEmojiPackagesItems(testRequest)).thenAnswer((_) async => emptyResponse);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(emptyResponse));
      expect(result.data, isEmpty);
      verify(() => mockEmojiRepository.getEmojiPackagesItems(testRequest)).called(1);
    });

    test('Given different package ID, When call is executed, Then calls repository with correct request', () async {
      // Given
      const differentPackageId = 'different-package-id';
      final differentRequest = GetEmojiPackageItemsRequest(
        emojiPackageId: differentPackageId,
      );
      when(() => mockEmojiRepository.getEmojiPackagesItems(differentRequest)).thenAnswer((_) async => testResponse);

      // When
      final result = await useCase.call(differentRequest);

      // Then
      expect(result, equals(testResponse));
      verify(() => mockEmojiRepository.getEmojiPackagesItems(differentRequest)).called(1);
      verifyNever(() => mockEmojiRepository.getEmojiPackagesItems(testRequest));
    });
  });
}
