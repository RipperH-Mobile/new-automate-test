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
      token: 'test-facebook-token',
      actionToken: 'test-action-token',
    );

    testSocialLinkEntity = SocialLinkEntity(
      facebookAccount: 'test@facebook.com',
      isSuccess: true,
    );
  });

  tearDownAll(() {
    // Reset GetIt instance
    GetIt.I.reset();
  });

  group('SyncAccountWithFacebookAccount', () {
    group('call', () {
      test('Given valid request, When use case is called, Then returns SocialLinkEntity successfully', () async {
        // Given
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(any()))
            .thenAnswer((_) async => testSocialLinkEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithFacebook(testRequest);

        // Then
        expect(result, equals(testSocialLinkEntity));
        expect(result.facebookAccount, equals('test@facebook.com'));
        expect(result.isSuccess, isTrue);
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(testRequest)).called(1);
        verifyNoMoreInteractions(mockAuthServerRepository);
      });

      test('Given successful linking, When use case is called, Then returns entity with success flag true', () async {
        // Given
        final successEntity = SocialLinkEntity(
          facebookAccount: 'success@facebook.com',
          isSuccess: true,
        );
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(any()))
            .thenAnswer((_) async => successEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithFacebook(testRequest);

        // Then
        expect(result.isSuccess, isTrue);
        expect(result.facebookAccount, equals('success@facebook.com'));
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(testRequest)).called(1);
      });

      test('Given failed linking, When use case is called, Then returns entity with success flag false', () async {
        // Given
        final failedEntity = SocialLinkEntity(
          facebookAccount: null,
          isSuccess: false,
        );
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(any()))
            .thenAnswer((_) async => failedEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithFacebook(testRequest);

        // Then
        expect(result.isSuccess, isFalse);
        expect(result.facebookAccount, isNull);
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(testRequest)).called(1);
      });

      test('Given repository throws Exception, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithFacebook(testRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(testRequest)).called(1);
        verifyNoMoreInteractions(mockAuthServerRepository);
      });

      test('Given empty token in request, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        final emptyTokenRequest = UpdateLinkingAccountWithSocialRequest(
          token: '',
          actionToken: 'test-action-token',
        );
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithFacebook(emptyTokenRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(emptyTokenRequest)).called(1);
      });

      test('Given empty action token in request, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        final emptyActionTokenRequest = UpdateLinkingAccountWithSocialRequest(
          token: 'test-facebook-token',
          actionToken: '',
        );
        when(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithFacebook(emptyActionTokenRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountLinkAccountWithFacebook(emptyActionTokenRequest)).called(1);
      });
    });
  });
}
