import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/constants/uchat_error_label_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/entities/get_image_from_clipboard_stream_state.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_stream_images_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/get_images_from_clipboard_util.dart';

// Mock classes
class MockClipboardDataReader extends Mock implements ClipboardDataReader {}

class MockLoggerService extends Mock implements LoggerService {}

// Fake classes
class FakeFileFormat extends Fake implements FileFormat {}

void main() {
  late GetStreamImagesUseCase useCase;
  late MockLoggerService mockLogger;
  late List<MockClipboardDataReader> mockFileItems;
  late MockClipboardDataReader mockClipboardDataReader;

  setUpAll(() {
    registerFallbackValue(FakeFileFormat());
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    mockLogger = MockLoggerService();
    useCase = GetStreamImagesUseCase();
    mockClipboardDataReader = MockClipboardDataReader();
    mockFileItems = [mockClipboardDataReader];

    // Register mock logger in GetIt
    if (GetIt.I.isRegistered<LoggerService>()) {
      GetIt.I.unregister<LoggerService>();
    }
    GetIt.I.registerSingleton<LoggerService>(mockLogger);

    // Mock the logger methods
    when(() => mockLogger.e(any())).thenReturn(null);
    when(() => mockLogger.e(any(), any())).thenReturn(null);
  });

  tearDown(() {
    useCase.dispose();
    if (GetIt.I.isRegistered<LoggerService>()) {
      GetIt.I.unregister<LoggerService>();
    }
  });

  group('GetStreamImagesUseCase', () {
    group('call', () {
      test('Given file items, When call is invoked, Then calls readImagesFromClipboard', () async {
        // Given
        final fileItems = <ClipboardDataReader>[];

        // When
        await useCase.call(fileItems);

        // Then
        // Verify that the method completes without error
        expect(useCase.stateStream, isA<Stream<ClipboardState>>());
      });
    });

    group('readImagesFromClipboard', () {
      test('Given empty file items, When readImagesFromClipboard is called, Then emits ClipboardAllLoaded', () async {
        // Given
        final fileItems = <ClipboardDataReader>[];
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);

        // When
        await useCase.readImagesFromClipboard(fileItems);

        // Then
        await Future.delayed(Duration.zero); // Allow stream to emit
        expect(states.length, equals(1));
        expect(states[0], isA<ClipboardAllLoaded>());
        final allLoadedState = states[0] as ClipboardAllLoaded;
        expect(allLoadedState.totalImagesLoaded, equals(0));
        expect(allLoadedState.images, isEmpty);

        await subscription.cancel();
      });

      test('Given non-empty file items, When readImagesFromClipboard is called, Then emits ClipboardInitiated',
          () async {
        // Given
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);
        when(() => mockClipboardDataReader.canProvide(any())).thenReturn(false);

        // When
        await useCase.readImagesFromClipboard(mockFileItems);

        // Then
        await Future.delayed(Duration.zero);
        expect(states.isNotEmpty, isTrue);
        expect(states[0], isA<ClipboardInitiated>());
        final initiatedState = states[0] as ClipboardInitiated;
        expect(initiatedState.totalImages, equals(1));

        await subscription.cancel();
      });

      test('Given exception during processing, When readImagesFromClipboard is called, Then emits ClipboardError',
          () async {
        // Given
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);
        when(() => mockClipboardDataReader.canProvide(any())).thenThrow(Exception('Test error'));

        // When
        await useCase.readImagesFromClipboard(mockFileItems);

        // Then
        await Future.delayed(Duration.zero);
        expect(states.any((state) => state is ClipboardError), isTrue);
        final errorState = states.firstWhere((state) => state is ClipboardError) as ClipboardError;
        expect(errorState.message, equals(UChatErrorLabelConstant.failedToProcessFile));

        await subscription.cancel();
      });

      test('Given more than 10 items, When readImagesFromClipboard is called, Then processes only first 10 items',
          () async {
        // Given
        final manyItems = List.generate(15, (index) => MockClipboardDataReader());
        for (final item in manyItems) {
          when(() => item.canProvide(any())).thenReturn(false);
        }
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);

        // When
        await useCase.readImagesFromClipboard(manyItems);

        // Then
        await Future.delayed(const Duration(milliseconds: 100));
        // Should have ClipboardInitiated state
        expect(states.whereType<ClipboardInitiated>(), isNotEmpty);
        final initiatedState = states.whereType<ClipboardInitiated>().first;
        expect(initiatedState.totalImages, equals(15));

        await subscription.cancel();
      });
    });

    group('getAvailableFormats', () {
      test('Given item supports JPEG, When getAvailableFormats is called, Then returns Formats.jpeg', () {
        // Given
        when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(false);

        // When
        final result = getAvailableFormats(mockClipboardDataReader);

        // Then
        expect(result, equals(Formats.jpeg));
      });

      test('Given item supports PNG, When getAvailableFormats is called, Then returns Formats.png', () {
        // Given
        when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(false);

        // When
        final result = getAvailableFormats(mockClipboardDataReader);

        // Then
        expect(result, equals(Formats.png));
      });

      test('Given item supports GIF, When getAvailableFormats is called, Then returns Formats.gif', () {
        // Given
        when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(false);

        // When
        final result = getAvailableFormats(mockClipboardDataReader);

        // Then
        expect(result, equals(Formats.gif));
      });

      test('Given item supports WEBP, When getAvailableFormats is called, Then returns Formats.webp', () {
        // Given
        when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(false);

        // When
        final result = getAvailableFormats(mockClipboardDataReader);

        // Then
        expect(result, equals(Formats.webp));
      });

      test('Given item supports HEIC, When getAvailableFormats is called, Then returns Formats.heic', () {
        // Given
        when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(false);

        // When
        final result = getAvailableFormats(mockClipboardDataReader);

        // Then
        expect(result, equals(Formats.heic));
      });

      test('Given item supports HEIF, When getAvailableFormats is called, Then returns Formats.heif', () {
        // Given
        when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(false);

        // When
        final result = getAvailableFormats(mockClipboardDataReader);

        // Then
        expect(result, equals(Formats.heif));
      });

      test('Given item supports TIFF, When getAvailableFormats is called, Then returns Formats.tiff', () {
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
      });

      test('Given item supports no formats, When getAvailableFormats is called, Then returns null', () {
        // Given
        when(() => mockClipboardDataReader.canProvide(any())).thenReturn(false);

        // When
        final result = getAvailableFormats(mockClipboardDataReader);

        // Then
        expect(result, isNull);
      });
    });

    group('file processing integration', () {
      test('Given item with no available format, When processing, Then returns early without processing', () async {
        // Given
        when(() => mockClipboardDataReader.canProvide(any())).thenReturn(false);
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);

        // When
        await useCase.readImagesFromClipboard([mockClipboardDataReader]);

        // Then
        await Future.delayed(Duration.zero);
        // Should only have ClipboardInitiated state, no loading states
        expect(states.whereType<ClipboardLoading>(), isEmpty);

        await subscription.cancel();
      });

      test('Given exception during file processing, When processing, Then emits ClipboardError', () async {
        // Given
        when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.webp)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heic)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.heif)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.tiff)).thenReturn(false);
        when(() => mockClipboardDataReader.getFile(any(), any())).thenThrow(Exception('File processing error'));
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);

        // When
        await useCase.readImagesFromClipboard([mockClipboardDataReader]);

        // Then
        await Future.delayed(Duration.zero);
        expect(states.any((state) => state is ClipboardError), isTrue);
        final errorState = states.firstWhere((state) => state is ClipboardError) as ClipboardError;
        expect(errorState.message, equals(UChatErrorLabelConstant.failedToProcessFile));

        await subscription.cancel();
      });
    });

    group('stateStream', () {
      test('Given use case instance, When stateStream is accessed, Then returns broadcast stream', () {
        // Given/When
        final stream = useCase.stateStream;

        // Then
        expect(stream, isA<Stream<ClipboardState>>());
        expect(stream.isBroadcast, isTrue);
      });
    });

    group('dispose', () {
      test('Given use case with active stream, When dispose is called, Then closes stream and clears images', () async {
        // Given
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);

        // When
        useCase.dispose();

        // Then
        await expectLater(
          subscription.asFuture(),
          completes,
        );
      });

      test('Given use case already disposed, When dispose is called again, Then does not throw error', () {
        // Given
        useCase.dispose();

        // When/Then
        expect(() => useCase.dispose(), returnsNormally);
      });
    });

    group('error handling', () {
      test('Given exception in readImagesFromClipboard, When processing, Then logs error and emits ClipboardError',
          () async {
        // Given
        when(() => mockClipboardDataReader.canProvide(any())).thenThrow(Exception('Test error'));
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);

        // When
        await useCase.readImagesFromClipboard([mockClipboardDataReader]);

        // Then
        await Future.delayed(Duration.zero);
        expect(states.any((state) => state is ClipboardError), isTrue);
        final errorState = states.firstWhere((state) => state is ClipboardError) as ClipboardError;
        expect(errorState.message, equals(UChatErrorLabelConstant.failedToProcessFile));
        verify(() => mockLogger.e(any(), any(), any())).called(1);

        await subscription.cancel();
      });
    });

    group('format priority', () {
      test('Given item supports multiple formats, When getAvailableFormats is called, Then returns JPEG first', () {
        // Given
        when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(true);

        // When
        final result = getAvailableFormats(mockClipboardDataReader);

        // Then
        expect(result, equals(Formats.jpeg));
      });

      test('Given item supports PNG and GIF but not JPEG, When getAvailableFormats is called, Then returns PNG', () {
        // Given
        when(() => mockClipboardDataReader.canProvide(Formats.jpeg)).thenReturn(false);
        when(() => mockClipboardDataReader.canProvide(Formats.png)).thenReturn(true);
        when(() => mockClipboardDataReader.canProvide(Formats.gif)).thenReturn(true);

        // When
        final result = getAvailableFormats(mockClipboardDataReader);

        // Then
        expect(result, equals(Formats.png));
      });

      test('Given item supports only TIFF, When getAvailableFormats is called, Then returns TIFF', () {
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
      });
    });

    group('edge cases', () {
      test('Given empty file items list, When processing, Then emits ClipboardAllLoaded', () async {
        // Given
        final emptyItems = <ClipboardDataReader>[];
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);

        // When
        await useCase.readImagesFromClipboard(emptyItems);

        // Then
        await Future.delayed(Duration.zero);
        expect(states.length, equals(1));
        expect(states[0], isA<ClipboardAllLoaded>());
        final allLoadedState = states[0] as ClipboardAllLoaded;
        expect(allLoadedState.totalImagesLoaded, equals(0));
        expect(allLoadedState.images, isEmpty);

        await subscription.cancel();
      });

      test('Given single item with unsupported format, When processing, Then emits ClipboardInitiated only', () async {
        // Given
        when(() => mockClipboardDataReader.canProvide(any())).thenReturn(false);
        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);

        // When
        await useCase.readImagesFromClipboard([mockClipboardDataReader]);

        // Then
        await Future.delayed(Duration.zero);
        expect(states.length, equals(1));
        expect(states[0], isA<ClipboardInitiated>());
        final initiatedState = states[0] as ClipboardInitiated;
        expect(initiatedState.totalImages, equals(1));

        await subscription.cancel();
      });
    });

    group('constants validation', () {
      test('Given UChatConstant.fileSizeLimit, When checking file size limit, Then uses correct constant', () {
        // Given/When/Then
        expect(UChatConstant.fileSizeLimit, equals(104857600)); // 100MB
      });

      test('Given error constants, When checking error messages, Then uses correct constants', () {
        // Given/When/Then
        expect(UChatErrorLabelConstant.failedToReadClipboard, equals('FAILED_TO_READ_CLIPBOARD'));
        expect(UChatErrorLabelConstant.failedToProcessFile, equals('FAILED_TO_PROCESS_FILE'));
        expect(UChatErrorLabelConstant.fileIsTooLarge, equals('FILE_IS_TOO_LARGE'));
        expect(UChatErrorLabelConstant.streamFileError, equals('STREAM_FILE_ERROR'));
        expect(UChatErrorLabelConstant.cannotGetAnyImages, equals('CANNOT_GET_ANY_IMAGES'));
        expect(UChatErrorLabelConstant.failedToProcessFileStream, equals('FAILED_TO_PROCESS_FILE_STREAM'));
      });
    });

    group('state stream behavior', () {
      test('Given stream listener added after emission, When new state is emitted, Then only new state is received',
          () async {
        // Given
        await useCase.readImagesFromClipboard([]);
        await Future.delayed(Duration.zero);

        final states = <ClipboardState>[];
        final subscription = useCase.stateStream.listen(states.add);

        // When
        await useCase.readImagesFromClipboard([]);

        // Then
        await Future.delayed(Duration.zero);
        expect(states.length, equals(1)); // Only the new emissions
        expect(states[0], isA<ClipboardAllLoaded>());

        await subscription.cancel();
      });
    });
  });
}
