import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/models/default_emoji_item_model.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_default_emoji_request.dart';
import 'package:uchat/features/chat_room/domain/entities/update_default_emoji_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/emoji_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_default_emoji_use_case.dart';

class MockEmojiServerRepository extends Mock implements EmojiServerRepository {}

void main() {
  late UpdateDefaultEmojiUseCase useCase;
  late MockEmojiServerRepository mockEmojiRepository;

  setUp(() {
    mockEmojiRepository = MockEmojiServerRepository();
    useCase = UpdateDefaultEmojiUseCase(
      emojiRepository: mockEmojiRepository,
    );
  });

  group('UpdateDefaultEmojiUseCase', () {
    final testDefaultEmojiItems = ['emoji1', 'emoji2', 'emoji3'];
    final testRequest = UpdateDefaultEmojiRequest(
      defaultEmojiItems: testDefaultEmojiItems,
    );

    final testDefaultEmojiItemModel = DefaultEmojiItemModel(
      emojiItemId: 'emoji1',
      fileId: 'file1',
    );

    final testResponse = UpdateDefaultEmojiEntity(
      accountDefaultEmojiItems: [testDefaultEmojiItemModel],
    );

    test('Given a valid request, When call is executed, Then returns updated default emoji entity', () async {
      // Given
      when(() => mockEmojiRepository.updateDefaultEmoji(testRequest)).thenAnswer((_) async => testResponse);

      // When
      final result = await useCase.call(testRequest);

      // Then
      expect(result, equals(testResponse));
      expect(result.accountDefaultEmojiItems, hasLength(1));
      expect(result.accountDefaultEmojiItems.first.emojiItemId, equals('emoji1'));
      expect(result.accountDefaultEmojiItems.first.fileId, equals('file1'));
      verify(() => mockEmojiRepository.updateDefaultEmoji(testRequest)).called(1);
    });

    test('Given repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      const exception = 'Update failed';
      when(() => mockEmojiRepository.updateDefaultEmoji(testRequest)).thenThrow(exception);

      // When & Then
      expect(
        () async => await useCase.call(testRequest),
        throwsA(equals(exception)),
      );
      verify(() => mockEmojiRepository.updateDefaultEmoji(testRequest)).called(1);
    });

    test('Given empty default emoji items, When call is executed, Then returns empty account default emoji items',
        () async {
      // Given
      final emptyRequest = UpdateDefaultEmojiRequest(
        defaultEmojiItems: [],
      );
      final emptyResponse = UpdateDefaultEmojiEntity(
        accountDefaultEmojiItems: [],
      );
      when(() => mockEmojiRepository.updateDefaultEmoji(emptyRequest)).thenAnswer((_) async => emptyResponse);

      // When
      final result = await useCase.call(emptyRequest);

      // Then
      expect(result, equals(emptyResponse));
      expect(result.accountDefaultEmojiItems, isEmpty);
      verify(() => mockEmojiRepository.updateDefaultEmoji(emptyRequest)).called(1);
    });

    test('Given different emoji items, When call is executed, Then calls repository with correct request', () async {
      // Given
      final differentEmojiItems = ['emoji4', 'emoji5'];
      final differentRequest = UpdateDefaultEmojiRequest(
        defaultEmojiItems: differentEmojiItems,
      );
      when(() => mockEmojiRepository.updateDefaultEmoji(differentRequest)).thenAnswer((_) async => testResponse);

      // When
      final result = await useCase.call(differentRequest);

      // Then
      expect(result, equals(testResponse));
      verify(() => mockEmojiRepository.updateDefaultEmoji(differentRequest)).called(1);
      verifyNever(() => mockEmojiRepository.updateDefaultEmoji(testRequest));
    });

    test('Given single emoji item, When call is executed, Then processes single item correctly', () async {
      // Given
      final singleEmojiRequest = UpdateDefaultEmojiRequest(
        defaultEmojiItems: ['single-emoji'],
      );
      final singleItemModel = DefaultEmojiItemModel(
        emojiItemId: 'single-emoji',
        fileId: 'single-file',
      );
      final singleResponse = UpdateDefaultEmojiEntity(
        accountDefaultEmojiItems: [singleItemModel],
      );
      when(() => mockEmojiRepository.updateDefaultEmoji(singleEmojiRequest)).thenAnswer((_) async => singleResponse);

      // When
      final result = await useCase.call(singleEmojiRequest);

      // Then
      expect(result, equals(singleResponse));
      expect(result.accountDefaultEmojiItems, hasLength(1));
      expect(result.accountDefaultEmojiItems.first.emojiItemId, equals('single-emoji'));
      verify(() => mockEmojiRepository.updateDefaultEmoji(singleEmojiRequest)).called(1);
    });
  });
}
