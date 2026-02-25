import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/features/profile/data/data_source/remote/profile_http_service.dart';
import 'package:uchat/features/profile/data/data_source/remote/profile_socket_service.dart';
import 'package:uchat/features/profile/data/repositories/profile_server_repository_impl.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';

// Mock Definitions
class MockProfileHttpService extends Mock implements ProfileHttpService {}

class MockProfileSocketService extends Mock implements ProfileSocketService {}

class MockSocketCaller extends Mock implements SocketCaller {}

class MockLoggerService extends Mock implements LoggerService {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

void main() {
  late ProfileServerRepositoryImpl repository;
  late MockProfileHttpService mockProfileHttpService;
  late MockProfileSocketService mockProfileSocketService;
  late MockSocketCaller mockSocketCaller;
  late MockLoggerService mockLoggerService;
  late ProfileEntity tProfileEntity;

  setUpAll(() {
    registerFallbackValue(FakeProfileEntity());
  });

  setUp(() {
    mockProfileHttpService = MockProfileHttpService();
    mockProfileSocketService = MockProfileSocketService();
    mockSocketCaller = MockSocketCaller();
    mockLoggerService = MockLoggerService();
    repository = ProfileServerRepositoryImpl(
      profileHttpService: mockProfileHttpService,
      profileSocketService: mockProfileSocketService,
      socketCaller: mockSocketCaller,
      log: mockLoggerService,
    );
    tProfileEntity = ProfileEntity(
      id: 'account123',
      username: 'testuser',
      phoneNumber: '+1234567890',
      displayName: 'Test User',
      statusMessage: 'Available',
      avatarId: 'avatar123',
      onlineStatus: OnlineStatus.online,
      deleted: false,
      settings: AccountSettingsModel(),
      isFriend: true,
      friendNickname: 'TestNick',
      isBlocked: false,
    );

    reset(mockProfileHttpService);
    reset(mockProfileSocketService);
    reset(mockSocketCaller);
    reset(mockLoggerService);
  });

  group('getProfile', () {
    const tAccountId = 'account123';

    test(
        'Given socket is ready and socket service returns profile, When getProfile is called, Then returns ProfileEntity from socket',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockProfileSocketService.getProfile(tAccountId)).thenAnswer((_) async => tProfileEntity);
      when(() => mockProfileHttpService.getProfile(tAccountId)).thenAnswer((_) async => tProfileEntity);

      // When
      final result = await repository.getProfile(tAccountId);

      // Then
      expect(result, equals(tProfileEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockProfileSocketService.getProfile(tAccountId)).called(1);
      verifyNever(() => mockProfileHttpService.getProfile(tAccountId));
      verifyNoMoreInteractions(mockProfileHttpService);
      verifyNoMoreInteractions(mockLoggerService);
    });

    test(
        'Given socket is ready but socket service returns null, When getProfile is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockProfileSocketService.getProfile(tAccountId)).thenAnswer((_) async => null);

      // When
      call() => repository.getProfile(tAccountId);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockProfileSocketService.getProfile(tAccountId)).called(1);
      verifyNever(() => mockProfileHttpService.getProfile(any()));
      verifyNoMoreInteractions(mockProfileHttpService);
      verifyNoMoreInteractions(mockLoggerService);
    });

    test(
        'Given socket is ready but socket service throws SERVICE_NOT_FOUND ApiException, When getProfile is called, Then falls back to HTTP and returns profile',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockProfileSocketService.getProfile(tAccountId))
          .thenThrow(ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found'));
      when(() => mockProfileHttpService.getProfile(tAccountId)).thenAnswer((_) async => tProfileEntity);

      // When
      final result = await repository.getProfile(tAccountId);

      // Then
      expect(result, equals(tProfileEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockProfileSocketService.getProfile(tAccountId)).called(1);
      verify(() => mockProfileHttpService.getProfile(tAccountId)).called(1);
      verifyNoMoreInteractions(mockLoggerService);
    });

    test(
        'Given socket is ready but socket service throws non-SERVICE_NOT_FOUND ApiException, When getProfile is called, Then rethrows the ApiException',
        () async {
      // Given
      final tApiException = ApiException(type: 'SERVER_ERROR', message: 'Server error');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockProfileSocketService.getProfile(tAccountId)).thenThrow(tApiException);

      // When
      call() => repository.getProfile(tAccountId);

      // Then
      expect(call, throwsA(equals(tApiException)));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockProfileSocketService.getProfile(tAccountId)).called(1);
      verifyNever(() => mockProfileHttpService.getProfile(any()));
      verifyNoMoreInteractions(mockProfileHttpService);
      verifyNoMoreInteractions(mockLoggerService);
    });

    test(
        'Given socket is ready but socket service throws NullResponseException, When getProfile is called, Then rethrows NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockProfileSocketService.getProfile(tAccountId)).thenThrow(NullResponseException());

      // When
      call() => repository.getProfile(tAccountId);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockProfileSocketService.getProfile(tAccountId)).called(1);
      verifyNever(() => mockProfileHttpService.getProfile(any()));
      verifyNoMoreInteractions(mockProfileHttpService);
      verifyNoMoreInteractions(mockLoggerService);
    });

    test(
        'Given socket is ready but socket service throws other exception, When getProfile is called, Then logs warning and falls back to HTTP',
        () async {
      // Given
      final tException = Exception('Network error');
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockProfileSocketService.getProfile(tAccountId)).thenThrow(tException);
      when(() => mockProfileHttpService.getProfile(tAccountId)).thenAnswer((_) async => tProfileEntity);
      when(() => mockLoggerService.w(any(), any(), any())).thenReturn(null);

      // When
      final result = await repository.getProfile(tAccountId);

      // Then
      expect(result, equals(tProfileEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockProfileSocketService.getProfile(tAccountId)).called(1);
      verify(() => mockProfileHttpService.getProfile(tAccountId)).called(1);
      verify(() => mockLoggerService.w(
            'multifactorValidate with socket error. fallback to http request...',
            tException,
            any(),
          )).called(1);
    });

    test('Given socket is not ready, When getProfile is called, Then directly uses HTTP and returns profile', () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockProfileHttpService.getProfile(tAccountId)).thenAnswer((_) async => tProfileEntity);

      // When
      final result = await repository.getProfile(tAccountId);

      // Then
      expect(result, equals(tProfileEntity));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockProfileHttpService.getProfile(tAccountId)).called(1);
      verifyNever(() => mockProfileSocketService.getProfile(any()));
      verifyNoMoreInteractions(mockProfileSocketService);
      verifyNoMoreInteractions(mockLoggerService);
    });

    test('Given HTTP service returns null, When getProfile is called, Then throws NullResponseException', () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(false);
      when(() => mockProfileHttpService.getProfile(tAccountId)).thenAnswer((_) async => null);

      // When
      call() => repository.getProfile(tAccountId);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockProfileHttpService.getProfile(tAccountId)).called(1);
      verifyNever(() => mockProfileSocketService.getProfile(any()));
      verifyNoMoreInteractions(mockProfileSocketService);
      verifyNoMoreInteractions(mockLoggerService);
    });

    test(
        'Given socket fails with SERVICE_NOT_FOUND but HTTP also returns null, When getProfile is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockSocketCaller.isReadyForCall).thenReturn(true);
      when(() => mockProfileSocketService.getProfile(tAccountId))
          .thenThrow(ApiException(type: 'SERVICE_NOT_FOUND', message: 'Service not found'));
      when(() => mockProfileHttpService.getProfile(tAccountId)).thenAnswer((_) async => null);

      // When
      call() => repository.getProfile(tAccountId);

      // Then
      expect(call, throwsA(isA<NullResponseException>()));
      verify(() => mockSocketCaller.isReadyForCall).called(1);
      verify(() => mockProfileSocketService.getProfile(tAccountId)).called(1);
      verify(() => mockProfileHttpService.getProfile(tAccountId)).called(1);
      verifyNoMoreInteractions(mockLoggerService);
    });
  });
}
