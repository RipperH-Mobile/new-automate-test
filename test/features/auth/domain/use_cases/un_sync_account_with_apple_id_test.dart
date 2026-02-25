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

  group('UnSyncAccountWithAppleID', () {
    group('call', () {
      test(
          'Given valid request, When use case is called, Then returns SocialLinkEntity successfully and appleId is null',
          () async {
        // Given
        final testSocialLinkEntity = SocialLinkEntity(
          appleId: null,
          isSuccess: true,
        );
        when(() => mockAuthServerRepository.settingAccountUnlinkAccountWithApple(any()))
            .thenAnswer((_) async => testSocialLinkEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithApple(testRequest);

        // Then
        expect(result, equals(testSocialLinkEntity));
        expect(result.appleId, equals(null));
        expect(result.isSuccess, isTrue);
        verify(() => mockAuthServerRepository.settingAccountUnlinkAccountWithApple(testRequest)).called(1);
        verifyNoMoreInteractions(mockAuthServerRepository);
      });

      test('Given failed linking, When use case is called, Then returns entity with success flag false', () async {
        // Given
        final failedEntity = SocialLinkEntity(
          appleId: null,
          isSuccess: false,
        );
        when(() => mockAuthServerRepository.settingAccountUnlinkAccountWithApple(any()))
            .thenAnswer((_) async => failedEntity);

        // When
        final result = await GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithApple(testRequest);

        // Then
        expect(result.isSuccess, isFalse);
        expect(result.appleId, isNull);
        verify(() => mockAuthServerRepository.settingAccountUnlinkAccountWithApple(testRequest)).called(1);
      });

      test('Given repository throws Exception, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        when(() => mockAuthServerRepository.settingAccountUnlinkAccountWithApple(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithApple(testRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountUnlinkAccountWithApple(testRequest)).called(1);
        verifyNoMoreInteractions(mockAuthServerRepository);
      });

      test('Given empty token in request, When use case is called, Then rethrows the same exception', () async {
        // Given
        final exception = Exception('error');
        final emptyTokenRequest = '';
        when(() => mockAuthServerRepository.settingAccountUnlinkAccountWithApple(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithApple(emptyTokenRequest),
          throwsA(equals(exception)),
        );
        verify(() => mockAuthServerRepository.settingAccountUnlinkAccountWithApple(emptyTokenRequest)).called(1);
      });
    });
  });
}
