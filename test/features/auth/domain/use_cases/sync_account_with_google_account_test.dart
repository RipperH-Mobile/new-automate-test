import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/data/models/requests/update_linking_account_with_social_request.dart';
import 'package:uchat/features/auth/domain/entities/social_link_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';

// Mock classes
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

// Fake classes for fallback values
class FakeUpdateLinkingAccountWithSocialRequest extends Fake implements UpdateLinkingAccountWithSocialRequest {}

void main() {
  late MockAuthServerRepository mockAuthServerRepository;
  late UpdateLinkingAccountWithSocialRequest testRequest;
  late SocialLinkEntity testSocialLinkEntity;

  setUpAll(() {
    mockAuthServerRepository = MockAuthServerRepository();
    registerFallbackValue(FakeUpdateLinkingAccountWithSocialRequest());

    GetIt.I.registerSingleton<AuthServerRepository>(mockAuthServerRepository);
  });

  setUp(() {
    testRequest = UpdateLinkingAccountWithSocialRequest(
      token: 'test-google-token',
      actionToken: 'test-action-token',
    );

    testSocialLinkEntity = SocialLinkEntity(
      googleAccount: 'test@google.com',
      isSuccess: true,
    );
  });

  tearDownAll(() {
    // Reset GetIt instance
    GetIt.I.reset();
  });

  group('SyncAccountWithGoogleAccount', () {
    group('call', () {
      test('Given valid request, When use case is called, Then returns SocialLinkEntity successfully', () async {
        // Given
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(any()))
            .thenAnswer((_) async => testSocialLinkEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithGoogle(testRequest);

        // Then
        expect(result, equals(testSocialLinkEntity));
        expect(result.googleAccount, equals('test@google.com'));
        expect(result.isSuccess, isTrue);
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(testRequest)).called(1);
        verifyNoMoreInteractions(mockAuthServerRepository);
      });

      test('Given successful linking, When use case is called, Then returns entity with success flag true', () async {
        // Given
        final successEntity = SocialLinkEntity(
          googleAccount: 'success@google.com',
          isSuccess: true,
        );
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(any()))
            .thenAnswer((_) async => successEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithGoogle(testRequest);

        // Then
        expect(result.isSuccess, isTrue);
        expect(result.googleAccount, equals('success@google.com'));
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(testRequest)).called(1);
      });

      test('Given failed linking, When use case is called, Then returns entity with success flag false', () async {
        // Given
        final failedEntity = SocialLinkEntity(
          googleAccount: null,
          isSuccess: false,
        );
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(any()))
            .thenAnswer((_) async => failedEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithGoogle(testRequest);

        // Then
        expect(result.isSuccess, isFalse);
        expect(result.googleAccount, isNull);
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(testRequest)).called(1);
      });

      test('Given repository throws Exception, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithGoogle(testRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(testRequest)).called(1);
        verifyNoMoreInteractions(mockAuthServerRepository);
      });

      test('Given empty token in request, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        final emptyTokenRequest = UpdateLinkingAccountWithSocialRequest(
          token: '',
          actionToken: 'test-action-token',
        );
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithGoogle(emptyTokenRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(emptyTokenRequest)).called(1);
      });

      test('Given empty action token in request, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        final emptyActionTokenRequest = UpdateLinkingAccountWithSocialRequest(
          token: 'test-google-token',
          actionToken: '',
        );
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithGoogle(emptyActionTokenRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithGoogle(emptyActionTokenRequest)).called(1);
      });
    });
  });
}
