import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/events/base_event.dart';
import 'package:amplitude_flutter/events/identify.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/amplitude_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';

// Mock Definitions
class MockAmplitude extends Mock implements Amplitude {}

class MockLoggerService extends Mock implements LoggerService {}

class MockUserEntity extends Mock implements UserEntity {}

class MockLogEvent extends Mock implements LogEvent {}

// Fake Definitions for Fallback Values
class FakeBaseEvent extends Fake implements BaseEvent {}

class FakeIdentify extends Fake implements Identify {}

void main() {
  late MockAmplitude mockAmplitude;
  late MockLoggerService mockLogger;
  late AmplitudeServiceImpl service;
  const apiKey = 'test-api-key';
  final getIt = GetIt.instance;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeBaseEvent());
    registerFallbackValue(FakeIdentify());
  });

  setUp(() {
    getIt.reset();
    mockAmplitude = MockAmplitude();
    mockLogger = MockLoggerService();

    // Stub all logger methods that might be called
    when(() => mockLogger.e(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.d(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.addLogListener(any())).thenReturn(null);
    when(() => mockLogger.removeLogListener(any())).thenReturn(null);

    // Register mock logger with GetIt for useLogger()
    getIt.registerSingleton<LoggerService>(mockLogger);

    // Initialize the service with the mock amplitude instance
    service = AmplitudeServiceImpl(apiKey, mockLogger, customAmplitude: mockAmplitude);

    reset(mockAmplitude);
    // We reset the logger's interactions, but keep the stubs
    reset(mockLogger);
    when(() => mockLogger.e(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.d(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.addLogListener(any())).thenReturn(null);
    when(() => mockLogger.removeLogListener(any())).thenReturn(null);
  });

  tearDown(() {
    getIt.reset();
  });

  group('setUser', () {
    test(
        'Given valid user and userProperties, When setUser is called, Then sets userId and user properties in Amplitude',
        () async {
      // Given
      final user = MockUserEntity();
      when(() => user.id).thenReturn('user123');
      when(() => mockAmplitude.setUserId('user123')).thenAnswer((_) async {});
      when(() => mockAmplitude.identify(any())).thenAnswer((_) async {});

      // When
      await service.setUser(user, userProperties: {'foo': 'bar'});

      // Then
      verify(() => mockAmplitude.setUserId('user123')).called(1);
      verify(() => mockAmplitude.identify(any(that: isA<Identify>()))).called(1);
    });

    test('Given user with null id, When setUser is called, Then logs an error', () async {
      // Given
      final user = MockUserEntity();
      when(() => user.id).thenReturn(null);

      // When
      await service.setUser(user);

      // Then
      verify(() => mockLogger.e(any(), any(), any())).called(1);
      verifyNever(() => mockAmplitude.setUserId(any()));
    });
  });

  group('onUnauthenticated', () {
    test('Given Amplitude, When onUnauthenticated is called, Then userId is unset', () async {
      // Given
      when(() => mockAmplitude.setUserId(null)).thenAnswer((_) async {});

      // When
      await service.onUnauthenticated();

      // Then
      verify(() => mockAmplitude.setUserId(null)).called(1);
    });

    test('Given Amplitude throws, When onUnauthenticated is called, Then error is logged', () async {
      // Given
      when(() => mockAmplitude.setUserId(null)).thenThrow(Exception('fail'));

      // When
      await service.onUnauthenticated();

      // Then
      verify(() => mockLogger.e(any(), any(), any())).called(1);
    });
  });

  group('sendEvent', () {
    test('Given eventName and properties, When sendEvent is called, Then sends event to Amplitude', () async {
      // Given
      final eventName = EventName.openApp;
      when(() => mockAmplitude.track(any())).thenAnswer((_) async {});
      when(() => mockAmplitude.flush()).thenAnswer((_) async {});

      // When
      await service.sendEvent(eventName, eventProperties: {'foo': 'bar'}, sendImmediately: true);

      // Then
      verify(() => mockAmplitude.track(any(that: isA<BaseEvent>()))).called(1);
      verify(() => mockAmplitude.flush()).called(1);
    });

    test('Given Amplitude throws, When sendEvent is called, Then error is logged', () async {
      // Given
      final eventName = EventName.openApp;
      when(() => mockAmplitude.track(any())).thenThrow(Exception('fail'));

      // When
      await service.sendEvent(eventName);

      // Then
      verify(() => mockLogger.e(any(), any(), any())).called(1);
    });
  });

  group('onAuthenticated', () {
    test('Given null user, When onAuthenticated is called, Then onUnauthenticated is called', () async {
      // Given
      when(() => mockAmplitude.setUserId(null)).thenAnswer((_) async {});

      // When
      await service.onAuthenticated(null);

      // Then
      verify(() => mockAmplitude.setUserId(null)).called(1);
    });

    test('Given valid user, When onAuthenticated is called, Then setUser and sendEvent are called', () async {
      // Given
      final user = MockUserEntity();
      when(() => user.id).thenReturn('user123');
      when(() => user.premiumPackageId).thenReturn('prem1');
      when(() => mockAmplitude.setUserId('user123')).thenAnswer((_) async {});
      when(() => mockAmplitude.identify(any())).thenAnswer((_) async {});
      when(() => mockAmplitude.track(any())).thenAnswer((_) async {});

      // When
      await service.onAuthenticated(user);

      // Then
      verify(() => mockAmplitude.setUserId('user123')).called(1);
      verify(() => mockAmplitude.identify(any(that: isA<Identify>()))).called(1);
      verify(() => mockAmplitude.track(any(that: isA<BaseEvent>()))).called(1);
    });
  });

  group('errorLogListener', () {
    test('Given LogEvent below error level, When errorLogListener is called, Then does nothing', () async {
      // Given
      final event = MockLogEvent();
      when(() => event.level).thenReturn(Level.info);

      // When
      await service.errorLogListener(event);

      // Then
      verifyNever(() => mockAmplitude.track(any()));
    });

    test('Given LogEvent at error level, When errorLogListener is called, Then sendEvent is called', () async {
      // Given
      final event = MockLogEvent();
      when(() => event.level).thenReturn(Level.error);
      when(() => event.message).thenReturn('error message');
      when(() => event.error).thenReturn(null);
      when(() => mockAmplitude.track(any())).thenAnswer((_) async {});

      // When
      await service.errorLogListener(event);

      // Then
      verify(() => mockAmplitude.track(any(that: isA<BaseEvent>()))).called(1);
    });
  });
}
