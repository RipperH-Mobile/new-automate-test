import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_packages_request.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/emoji_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_emoji_packages_use_case.dart';

class MockEmojiServerRepository extends Mock implements EmojiServerRepository {}

void main() {
  late GetEmojiPackagesUseCase useCase;
  late MockEmojiServerRepository mockEmojiRepository;

  setUp(() {
    mockEmojiRepository = MockEmojiServerRepository();
    useCase = GetEmojiPackagesUseCase(
      emojiRepository: mockEmojiRepository,
    );
  });

  group('GetEmojiPackagesUseCase', () {
    const testPage = 1;
    const testPageSize = 10;
    final testRequest = GetEmojiPackagesRequest(
      page: testPage,
      pageSize: testPageSize,
    );

    final testEmojiPackage = EmojiPackageEntity(
      id: 'package-1',
      description: 'Test Package Description',
      coverId: 'cover-id',
      isDefault: false,
      isPublish: true,
      createdAt: DateTime(2023, 1, 1),
      updatedAt: DateTime(2023, 1, 1),
    );

    final testResponse = PaginationPayload<EmojiPackageEntity>(
      data: [testEmojiPackage],
      total: 1,
      page: testPage,
      pageSize: testPageSize,
      totalPages: 1,
    );

    test('Given a valid request, When call is executed, Then returns emoji packages response', () async {
      // Given
      when(() => mockEmojiRepository.getEmojiPackages(testRequest)).thenAnswer((_) async => testResponse);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(testResponse));
      expect(result.data, hasLength(1));
      expect(result.data!.first.id, equals('package-1'));
      expect(result.data!.first.description, equals('Test Package Description'));
      expect(result.total, equals(1));
      expect(result.page, equals(testPage));
      expect(result.pageSize, equals(testPageSize));
      expect(result.totalPages, equals(1));
      verify(() => mockEmojiRepository.getEmojiPackages(testRequest)).called(1);
    });

    test('Given repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      const exception = 'Server error';
      when(() => mockEmojiRepository.getEmojiPackages(testRequest)).thenThrow(exception);

      // When & Then
      expect(
        () async => await useCase.call(testRequest),
        throwsA(equals(exception)),
      );
      verify(() => mockEmojiRepository.getEmojiPackages(testRequest)).called(1);
    });

    test('Given empty response, When call is executed, Then returns empty emoji packages list', () async {
      // Given
      final emptyResponse = PaginationPayload<EmojiPackageEntity>(
        data: [],
        total: 0,
        page: testPage,
        pageSize: testPageSize,
        totalPages: 0,
      );
      when(() => mockEmojiRepository.getEmojiPackages(testRequest)).thenAnswer((_) async => emptyResponse);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(emptyResponse));
      expect(result.data, isEmpty);
      expect(result.total, equals(0));
      expect(result.totalPages, equals(0));
      verify(() => mockEmojiRepository.getEmojiPackages(testRequest)).called(1);
    });

    test('Given different page parameters, When call is executed, Then calls repository with correct request',
        () async {
      // Given
      const differentPage = 2;
      const differentPageSize = 20;
      final differentRequest = GetEmojiPackagesRequest(
        page: differentPage,
        pageSize: differentPageSize,
      );
      final differentResponse = PaginationPayload<EmojiPackageEntity>(
        data: [],
        total: 0,
        page: differentPage,
        pageSize: differentPageSize,
        totalPages: 0,
      );
      when(() => mockEmojiRepository.getEmojiPackages(differentRequest)).thenAnswer((_) async => differentResponse);

      // When
      final result = await useCase.call(differentRequest);

      // Then
      expect(result, equals(differentResponse));
      expect(result.page, equals(differentPage));
      expect(result.pageSize, equals(differentPageSize));
      verify(() => mockEmojiRepository.getEmojiPackages(differentRequest)).called(1);
      verifyNever(() => mockEmojiRepository.getEmojiPackages(testRequest));
    });
  });
}
