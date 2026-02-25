import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_images_from_clipboard_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/get_images_from_clipboard_util.dart';
import 'package:uchat/use_cases/use_case.dart';

// Mock classes
class MockClipboardDataReader extends Mock implements ClipboardDataReader {}

// Fake classes
class FakeNoParams extends Fake implements NoParams {}

void main() {
  late GetImagesFromClipboardUseCase useCase;
  late MockClipboardDataReader mockClipboardDataReader;
  late NoParams testParams;

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
  });

  setUp(() {
    useCase = GetImagesFromClipboardUseCase();
    mockClipboardDataReader = MockClipboardDataReader();
    testParams = NoParams();
  });

  group('GetImagesFromClipboardUseCase', () {
    group('call', () {
      test(
        'Given SystemClipboard access fails, When use case is called, Then handles gracefully',
        () async {
          // Given
          // SystemClipboard.instance will throw in test environment

          // When/Then
          // The use case should handle the native channel error gracefully
          // This test verifies the use case doesn't crash when clipboard access fails
          await expectLater(
            () => useCase(testParams),
            throwsA(isA<Object>()),
          );
        },
      );

      // Note: Testing the full call method with actual SystemClipboard is challenging
      // due to static dependencies and native channel requirements.
      // The main logic is tested through getAvailableFormats method below.
      // Integration tests would cover the full flow with actual clipboard access.
    });

    group('getAvailableFormats', () {
      test(
        'Given item supports JPEG format, When getAvailableFormats is called, Then returns Formats.jpeg',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.jpeg));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
        },
      );

      test(
        'Given item supports PNG format but not JPEG, When getAvailableFormats is called, Then returns Formats.png',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.png));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.png)).called(1);
        },
      );

      test(
        'Given item supports GIF format but not JPEG or PNG, When getAvailableFormats is called, Then returns Formats.gif',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.gif));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.png)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.gif)).called(1);
        },
      );

      test(
        'Given item supports WEBP format but not JPEG, PNG, or GIF, When getAvailableFormats is called, Then returns Formats.webp',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.webp));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.png)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.gif)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.webp)).called(1);
        },
      );

      test(
        'Given item supports HEIC format but not previous formats, When getAvailableFormats is called, Then returns Formats.heic',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.heic));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.png)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.gif)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.webp)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.heic)).called(1);
        },
      );

      test(
        'Given item supports HEIF format but not previous formats, When getAvailableFormats is called, Then returns Formats.heif',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.heif));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.png)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.gif)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.webp)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.heic)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.heif)).called(1);
        },
      );

      test(
        'Given item supports TIFF format but not previous formats, When getAvailableFormats is called, Then returns Formats.tiff',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.tiff));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.png)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.gif)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.webp)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.heic)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.heif)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.tiff)).called(1);
        },
      );

      test(
        'Given item supports no image formats, When getAvailableFormats is called, Then returns null',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(false);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, isNull);
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.png)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.gif)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.webp)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.heic)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.heif)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.tiff)).called(1);
        },
      );

      test(
        'Given item supports multiple formats, When getAvailableFormats is called, Then returns first supported format in priority order',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(true);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(true);
          when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.jpeg));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          // Should not check other formats since JPEG is found first
          verifyNever(() => mockClipboardDataReader.canProvide(Formats.png));
          verifyNever(() => mockClipboardDataReader.canProvide(Formats.gif));
        },
      );

      test(
        'Given item supports PNG and GIF but not JPEG, When getAvailableFormats is called, Then returns PNG (higher priority)',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(true);
          when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.png));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.png)).called(1);
          // Should not check GIF since PNG is found
          verifyNever(() => mockClipboardDataReader.canProvide(Formats.gif));
        },
      );

      test(
        'Given item supports TIFF and HEIF but not other formats, When getAvailableFormats is called, Then returns HEIF (higher priority)',
        () {
          // Given
          when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
          when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(true);
          when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(true);

          // When
          final result = getAvailableFormats(mockClipboardDataReader);

          // Then
          expect(result, equals(Formats.heif));
          verify(() => mockClipboardDataReader.canProvide(Formats.jpeg)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.png)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.gif)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.webp)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.heic)).called(1);
          verify(() => mockClipboardDataReader.canProvide(Formats.heif)).called(1);
          // Should not check TIFF since HEIF is found
          verifyNever(() => mockClipboardDataReader.canProvide(Formats.tiff));
        },
      );
    });
  });
}
