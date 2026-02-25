import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/domain/repositories/social_auth_provider_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/reset_social_auth_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

// Mock classes
class MockSocialAuthProviderRepository extends Mock implements SocialAuthProviderRepository {}

void main() {
  late ResetSocialAuthUseCase useCase;
  late MockSocialAuthProviderRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    // Initialize mocks
    mockRepository = MockSocialAuthProviderRepository();
    
    // Initialize use case
    useCase = ResetSocialAuthUseCase(
      socialAuthProviderRepository: mockRepository,
    );
    
    // Reset mocks before each test
    reset(mockRepository);
  });

  group('ResetSocialAuthUseCase', () {
    test(
      'Given both social providers sign out successfully, When call is executed, Then completes successfully',
      () async {
        // Given
        when(() => mockRepository.signOutGoogle())
            .thenAnswer((_) async {});
        when(() => mockRepository.signOutFacebook())
            .thenAnswer((_) async {});

        // When
        await useCase(NoParams());

        // Then
        verify(() => mockRepository.signOutGoogle()).called(1);
        verify(() => mockRepository.signOutFacebook()).called(1);
      },
    );

    test(
      'Given signOutGoogle throws exception, When call is executed, Then throws exception',
      () async {
        // Given
        final exception = Exception('Google sign out error');
        when(() => mockRepository.signOutGoogle())
            .thenThrow(exception);
        when(() => mockRepository.signOutFacebook())
            .thenAnswer((_) async {});

        // When & Then
        expect(() => useCase(NoParams()), throwsException);
        verify(() => mockRepository.signOutGoogle()).called(1);
      },
    );

    test(
      'Given signOutFacebook throws exception, When call is executed, Then throws exception',
      () async {
        // Given
        final exception = Exception('Facebook sign out error');
        when(() => mockRepository.signOutGoogle())
            .thenAnswer((_) async {});
        when(() => mockRepository.signOutFacebook())
            .thenThrow(exception);

        // When & Then
        expect(() => useCase(NoParams()), throwsException);
        verify(() => mockRepository.signOutGoogle()).called(1);
        verify(() => mockRepository.signOutFacebook()).called(1);
      },
    );

    test(
      'Given both social providers throw exceptions, When call is executed, Then throws exception',
      () async {
        // Given
        final googleException = Exception('Google sign out error');
        final facebookException = Exception('Facebook sign out error');
        
        when(() => mockRepository.signOutGoogle())
            .thenThrow(googleException);
        when(() => mockRepository.signOutFacebook())
            .thenThrow(facebookException);

        // When & Then
        expect(() => useCase(NoParams()), throwsException);
        verify(() => mockRepository.signOutGoogle()).called(1);
      },
    );
  });
}