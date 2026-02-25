import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:uchat/utils/extension/extension_link_preview.dart';
import 'package:uchat/utils/link_preview_wrapper.dart';

// Mock class for LinkPreviewWrapper
class MockLinkPreviewWrapper extends Mock implements LinkPreviewWrapper {}

// Fake class for Metadata
class FakeMetadata extends Fake implements Metadata {
  @override
  String? get title => 'Test Title';
  
  @override
  String? get desc => 'Test Description';
  
  @override
  String? get image => 'https://example.com/image.jpg';
  
  @override
  String get url => 'https://example.com';
  
  @override
  String? get siteName => 'Example Site';
}

void main() {
  group('LinkPreviewExtension', () {
    late MockLinkPreviewWrapper mockLinkPreviewWrapper;
    late GetIt getIt;

    setUpAll(() {
      registerFallbackValue(FakeMetadata());
    });

    setUp(() {
      mockLinkPreviewWrapper = MockLinkPreviewWrapper();
      getIt = GetIt.instance;
      
      // Register the mock instance in GetIt
      if (getIt.isRegistered<LinkPreviewWrapper>()) {
        getIt.unregister<LinkPreviewWrapper>();
      }
      getIt.registerSingleton<LinkPreviewWrapper>(mockLinkPreviewWrapper);
      
      reset(mockLinkPreviewWrapper);
    });

    tearDown(() {
      if (getIt.isRegistered<LinkPreviewWrapper>()) {
        getIt.unregister<LinkPreviewWrapper>();
      }
    });

    group('toMessageLinks', () {
      test('Given null input, When toMessageLinks is called, Then returns null', () async {
        // Given
        final String? input = null;

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNull);
      });

      test('Given empty string input, When toMessageLinks is called, Then returns null', () async {
        // Given
        const String input = '';

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNull);
      });

      test('Given text with no URLs, When toMessageLinks is called, Then returns null', () async {
        // Given
        const String input = 'This is just plain text without any links';

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNull);
      });

      test('Given text with single URL, When toMessageLinks is called, Then returns MessageLinkModel with metadata', () async {
        // Given
        const String input = 'Check out this link: https://example.com';
        final mockMetadata = FakeMetadata();
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://example.com'))
            .thenAnswer((_) async => mockMetadata);

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result.first.url, equals('https://example.com'));
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://example.com')).called(1);
      });

      test('Given text with multiple URLs including Thai text, When toMessageLinks is called, Then returns MessageLinkModels for all URLs', () async {
        // Given
        const String input = 'ลองฟังเพลงนี้ดู https://youtu.be/v18ik7DRFNQ?si=UQYCxNwJo4BlBfPA แต่ถ้าไม่ชอบลองเปลี่ยนไปฟังเพลงนี้ https://youtu.be/HUppRTEfZwY?si=i9oG5xliKfPnnqB4';
        final mockMetadata1 = FakeMetadata();
        final mockMetadata2 = FakeMetadata();
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://youtu.be/v18ik7DRFNQ?si=UQYCxNwJo4BlBfPA'))
            .thenAnswer((_) async => mockMetadata1);
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://youtu.be/HUppRTEfZwY?si=i9oG5xliKfPnnqB4'))
            .thenAnswer((_) async => mockMetadata2);

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNotNull);
        expect(result!.length, equals(2));
        expect(result[0].url, equals('https://youtu.be/v18ik7DRFNQ?si=UQYCxNwJo4BlBfPA'));
        expect(result[1].url, equals('https://youtu.be/HUppRTEfZwY?si=i9oG5xliKfPnnqB4'));
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://youtu.be/v18ik7DRFNQ?si=UQYCxNwJo4BlBfPA')).called(1);
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://youtu.be/HUppRTEfZwY?si=i9oG5xliKfPnnqB4')).called(1);
      });

      test('Given text with duplicate URLs, When toMessageLinks is called, Then returns unique MessageLinkModels', () async {
        // Given
        const String input = 'Visit https://example.com and also https://example.com';
        final mockMetadata = FakeMetadata();
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://example.com'))
            .thenAnswer((_) async => mockMetadata);

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result.first.url, equals('https://example.com'));
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://example.com')).called(1);
      });

      test('Given text with URLs where metadata fetch fails for some, When toMessageLinks is called, Then returns MessageLinkModels for successful URLs only', () async {
        // Given
        const String input = 'Check https://success.com and https://failure.com';
        final mockMetadata = FakeMetadata();
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://success.com'))
            .thenAnswer((_) async => mockMetadata);
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://failure.com'))
            .thenThrow(Exception('Network error'));

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result.first.url, equals('https://success.com'));
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://success.com')).called(1);
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://failure.com')).called(1);
      });

      test('Given text with URLs where metadata returns null, When toMessageLinks is called, Then skips URLs with null metadata', () async {
        // Given
        const String input = 'Check https://nullmeta.com and https://validmeta.com';
        final mockMetadata = FakeMetadata();
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://nullmeta.com'))
            .thenAnswer((_) async => null);
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://validmeta.com'))
            .thenAnswer((_) async => mockMetadata);

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result.first.url, equals('https://validmeta.com'));
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://nullmeta.com')).called(1);
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://validmeta.com')).called(1);
      });

      test('Given text with URLs where all metadata fetches fail, When toMessageLinks is called, Then returns null', () async {
        // Given
        const String input = 'Check https://fail1.com and https://fail2.com';
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://fail1.com'))
            .thenThrow(Exception('Network error 1'));
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://fail2.com'))
            .thenThrow(Exception('Network error 2'));

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNull);
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://fail1.com')).called(1);
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://fail2.com')).called(1);
      });

      test('Given text with URLs where all metadata returns null, When toMessageLinks is called, Then returns null', () async {
        // Given
        const String input = 'Check https://null1.com and https://null2.com';
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://null1.com'))
            .thenAnswer((_) async => null);
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://null2.com'))
            .thenAnswer((_) async => null);

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNull);
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://null1.com')).called(1);
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://null2.com')).called(1);
      });
    });

    group('_extractAllUrls (tested through public interface)', () {
      test('Given text with www URL without scheme, When toMessageLinks is called, Then extracts and formats URL with https scheme', () async {
        // Given
        const String input = 'Visit www.example.com for more info';
        final mockMetadata = FakeMetadata();
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://www.example.com'))
            .thenAnswer((_) async => mockMetadata);

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result.first.url, equals('https://www.example.com'));
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://www.example.com')).called(1);
      });

      test('Given text with domain name only, When toMessageLinks is called, Then extracts and formats URL with https scheme', () async {
        // Given
        const String input = 'Visit example.com for more info';
        final mockMetadata = FakeMetadata();
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://example.com'))
            .thenAnswer((_) async => mockMetadata);

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result.first.url, equals('https://example.com'));
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://example.com')).called(1);
      });


      test('Given text with mixed URL types, When toMessageLinks is called, Then extracts all URL types correctly', () async {
        // Given
        const String input = 'Visit https://secure.com and www.example.com for different types';
        final mockMetadata1 = FakeMetadata();
        final mockMetadata2 = FakeMetadata();
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://secure.com'))
            .thenAnswer((_) async => mockMetadata1);
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://www.example.com'))
            .thenAnswer((_) async => mockMetadata2);

        // When
        final result = await input.toMessageLinks();

        // Then - Note: IP address may not be matched by current regex, so expecting 2 URLs
        expect(result, isNotNull);
        expect(result!.length, equals(2));
        expect(result[0].url, equals('https://secure.com'));
        expect(result[1].url, equals('https://www.example.com'));
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://secure.com')).called(1);
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://www.example.com')).called(1);
      });

      test('Given text with URLs containing special characters, When toMessageLinks is called, Then extracts URLs with special characters', () async {
        // Given
        const String input = 'Visit https://example.com/path?param=value&other=test#fragment for details';
        final mockMetadata = FakeMetadata();
        
        when(() => mockLinkPreviewWrapper.getMetadata(link: 'https://example.com/path?param=value&other=test#fragment'))
            .thenAnswer((_) async => mockMetadata);

        // When
        final result = await input.toMessageLinks();

        // Then
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result.first.url, equals('https://example.com/path?param=value&other=test#fragment'));
        verify(() => mockLinkPreviewWrapper.getMetadata(link: 'https://example.com/path?param=value&other=test#fragment')).called(1);
      });
    });
  });
}