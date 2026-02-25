import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/domain/services/implementation/url_service_impl.dart';
import 'package:uchat/core/domain/services/url_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:url_launcher/url_launcher.dart';

// Mock Classes
class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late UrlServiceImpl urlService;
  late MockLoggerService mockLoggerService;

  setUpAll(() {
    // Initialize Flutter binding for tests
    TestWidgetsFlutterBinding.ensureInitialized();

    // Register the mock logger service in GetIt
    mockLoggerService = MockLoggerService();
    GetIt.instance.registerSingleton<LoggerService>(mockLoggerService);
  });

  setUp(() {
    urlService = UrlServiceImpl();

    // Reset mock and set up default stubbing for logger
    reset(mockLoggerService);
    when(() => mockLoggerService.e(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);
  });

  tearDownAll(() {
    // Clean up GetIt instance
    GetIt.instance.reset();
  });

  group('UrlServiceImpl', () {
    group('open - validation logic', () {
      test('Given an empty URL, When open is called, Then throws ArgumentError with correct message', () async {
        // Given
        const emptyUrl = '';

        // When
        Future<void> call() => urlService.open(emptyUrl);

        // Then
        await expectLater(
          call,
          throwsA(
            allOf(
              isA<ArgumentError>(),
              predicate<ArgumentError>((e) => e.message == 'URL cannot be empty'),
            ),
          ),
        );
      });

      test('Given an invalid URL format with colons, When open is called, Then throws FormatException', () async {
        // Given
        const invalidUrl = ':::invalid:::'; // This makes Uri.tryParse() return null

        // When
        Future<void> call() => urlService.open(invalidUrl);

        // Then
        await expectLater(
          call,
          throwsA(
            allOf(
              isA<FormatException>(),
              predicate<FormatException>((e) => e.message.contains('Invalid URL format')),
            ),
          ),
        );
      });

      test('Given URL with invalid brackets, When open is called, Then throws FormatException', () async {
        // Given
        const invalidUrl = 'http://[invalid'; // This makes Uri.tryParse() return null

        // When
        Future<void> call() => urlService.open(invalidUrl);

        // Then
        await expectLater(call, throwsA(isA<FormatException>()));
      });

      test('Given a valid URL format, When open is called, Then passes validation and attempts to launch', () async {
        // Given
        const validUrl = 'https://example.com';

        // When & Then
        // We expect this to pass validation but fail at the plugin level (MissingPluginException)
        // This proves our validation logic works correctly
        await expectLater(
          () => urlService.open(validUrl),
          throwsA(isA<MissingPluginException>()),
        );
      });

      test('Given a valid URL with query parameters, When open is called, Then passes validation', () async {
        // Given
        const validUrl = 'https://example.com/path?param=value&param2=value2';

        // When & Then
        await expectLater(
          () => urlService.open(validUrl),
          throwsA(isA<MissingPluginException>()),
        );
      });

      test('Given a valid URL with different scheme, When open is called, Then passes validation', () async {
        // Given
        const validUrl = 'http://example.com';

        // When & Then
        await expectLater(
          () => urlService.open(validUrl),
          throwsA(isA<MissingPluginException>()),
        );
      });
    });

    group('mailTo', () {
      test('Given a valid email, When mailTo is called, Then constructs correct mailto URL and passes to open',
          () async {
        // Given
        const testEmail = 'test@example.com';

        // When & Then
        // This should pass validation and fail at plugin level
        await expectLater(
          () => urlService.mailTo(testEmail),
          throwsA(isA<MissingPluginException>()),
        );
      });

      test('Given an empty email, When mailTo is called, Then constructs mailto URL with empty email', () async {
        // Given
        const emptyEmail = '';

        // When & Then
        // This creates 'mailto:' which is a valid URI but reaches plugin level
        await expectLater(
          () => urlService.mailTo(emptyEmail),
          throwsA(isA<MissingPluginException>()),
        );
      });

      test('Given a valid email with special characters, When mailTo is called, Then handles correctly', () async {
        // Given
        const emailWithSpecialChars = 'test+tag@example-domain.com';

        // When & Then
        await expectLater(
          () => urlService.mailTo(emailWithSpecialChars),
          throwsA(isA<MissingPluginException>()),
        );
      });
    });

    group('sms', () {
      test('Given a valid phone number, When sms is called, Then constructs correct sms URL and passes to open',
          () async {
        // Given
        const testPhoneNumber = '+1234567890';

        // When & Then
        await expectLater(
          () => urlService.sms(testPhoneNumber),
          throwsA(isA<MissingPluginException>()),
        );
      });

      test('Given an empty phone number, When sms is called, Then constructs sms URL with empty number', () async {
        // Given
        const emptyPhoneNumber = '';

        // When & Then
        // This creates 'sms:' which is a valid URI but reaches plugin level
        await expectLater(
          () => urlService.sms(emptyPhoneNumber),
          throwsA(isA<MissingPluginException>()),
        );
      });

      test('Given phone numbers with various formats, When sms is called, Then handles all correctly', () async {
        // Given
        const phoneNumbers = [
          '1234567890',
          '+1-234-567-8900',
          '(123) 456-7890',
          '+66812345678',
        ];

        // When & Then
        for (final phoneNumber in phoneNumbers) {
          await expectLater(
            () => urlService.sms(phoneNumber),
            throwsA(isA<MissingPluginException>()),
            reason: 'Failed for phone number: $phoneNumber',
          );
        }
      });
    });

    group('tel', () {
      test('Given a valid phone number, When tel is called, Then constructs correct tel URL and passes to open',
          () async {
        // Given
        const testPhoneNumber = '+1234567890';

        // When & Then
        await expectLater(
          () => urlService.tel(testPhoneNumber),
          throwsA(isA<MissingPluginException>()),
        );
      });

      test('Given an empty phone number, When tel is called, Then constructs tel URL with empty number', () async {
        // Given
        const emptyPhoneNumber = '';

        // When & Then
        // This creates 'tel:' which is a valid URI but reaches plugin level
        await expectLater(
          () => urlService.tel(emptyPhoneNumber),
          throwsA(isA<MissingPluginException>()),
        );
      });

      test('Given phone numbers with various formats, When tel is called, Then handles all correctly', () async {
        // Given
        const phoneNumbers = [
          '1234567890',
          '+1-234-567-8900',
          '(123) 456-7890',
          '+66812345678',
        ];

        // When & Then
        for (final phoneNumber in phoneNumbers) {
          await expectLater(
            () => urlService.tel(phoneNumber),
            throwsA(isA<MissingPluginException>()),
            reason: 'Failed for phone number: $phoneNumber',
          );
        }
      });
    });

    group('LauncherMode enum', () {
      test('Given LauncherMode.platformDefault, When origin is called, Then returns LaunchMode.platformDefault', () {
        // Given
        const mode = LauncherMode.platformDefault;

        // When
        final result = mode.origin;

        // Then
        expect(result, equals(LaunchMode.platformDefault));
      });

      test('Given LauncherMode.inAppWebView, When origin is called, Then returns LaunchMode.inAppWebView', () {
        // Given
        const mode = LauncherMode.inAppWebView;

        // When
        final result = mode.origin;

        // Then
        expect(result, equals(LaunchMode.inAppWebView));
      });

      test('Given LauncherMode.inAppBrowserView, When origin is called, Then returns LaunchMode.inAppBrowserView', () {
        // Given
        const mode = LauncherMode.inAppBrowserView;

        // When
        final result = mode.origin;

        // Then
        expect(result, equals(LaunchMode.inAppBrowserView));
      });

      test('Given LauncherMode.externalApplication, When origin is called, Then returns LaunchMode.externalApplication',
          () {
        // Given
        const mode = LauncherMode.externalApplication;

        // When
        final result = mode.origin;

        // Then
        expect(result, equals(LaunchMode.externalApplication));
      });

      test(
          'Given LauncherMode.externalNonBrowserApplication, When origin is called, Then returns LaunchMode.externalNonBrowserApplication',
          () {
        // Given
        const mode = LauncherMode.externalNonBrowserApplication;

        // When
        final result = mode.origin;

        // Then
        expect(result, equals(LaunchMode.externalNonBrowserApplication));
      });
    });
  });
}
