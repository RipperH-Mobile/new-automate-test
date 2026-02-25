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
  late String testRequest;

  setUpAll(() {
    mockAuthServerRepository = MockAuthServerRepository();
    registerFallbackValue(FakeUpdateLinkingAccountWithSocialRequest());

    GetIt.I.registerSingleton<AuthServerRepository>(mockAuthServerRepository);
  });

  setUp(() {
    testRequest = 'test-action-token';
  });

  tearDownAll(() {
    // Reset GetIt instance
    GetIt.I.reset();
  });

  group('UnSyncAccountWithFacebookAccount', () {
    group('call', () {
      test(
          'Given valid request, When use case is called, Then returns SocialLinkEntity successfully and facebookAccount is null',
          () async {
        // Given
        final testSocialLinkEntity = SocialLinkEntity(
          facebookAccount: null,
          isSuccess: true,
        );
        when(() => mockAuthServerRepository.settingAccountUnlinkAccountWithFacebook(any()))
            .thenAnswer((_) async => testSocialLinkEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithFacebook(testRequest);

        // Then
        expect(result, equals(testSocialLinkEntity));
        expect(result.facebookAccount, equals(null));
        expect(result.isSuccess, isTrue);
        verify(() => mockAuthServerRepository.settingAccountUnlinkAccountWithFacebook(testRequest)).called(1);
        verifyNoMoreInteractions(mockAuthServerRepository);
      });

      test('Given failed linking, When use case is called, Then returns entity with success flag false', () async {
        // Given
        final failedEntity = SocialLinkEntity(
          facebookAccount: null,
          isSuccess: false,
        );
        when(() => mockAuthServerRepository.settingAccountUnlinkAccountWithFacebook(any()))
            .thenAnswer((_) async => failedEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithFacebook(testRequest);

        // Then
        expect(result.isSuccess, isFalse);
        expect(result.facebookAccount, isNull);
        verify(() => mockAuthServerRepository.settingAccountUnlinkAccountWithFacebook(testRequest)).called(1);
      });

      test('Given repository throws Exception, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        when(() => mockAuthServerRepository.settingAccountUnlinkAccountWithFacebook(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithFacebook(testRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountUnlinkAccountWithFacebook(testRequest)).called(1);
        verifyNoMoreInteractions(mockAuthServerRepository);
      });

      test('Given empty token in request, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        final emptyTokenRequest = '';
        when(() => mockAuthServerRepository.settingAccountUnlinkAccountWithFacebook(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithFacebook(emptyTokenRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountUnlinkAccountWithFacebook(emptyTokenRequest)).called(1);
      });
    });
  });
}
