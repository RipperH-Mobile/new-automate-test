import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/clear_otp_use_case.dart';

// Mock classes
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

void main() {
  late ClearOtpUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = ClearOtpUseCase(authServerRepository: mockAuthServerRepository);
  });

  // Test data
  const tPhoneOrEmail = 'test@example.com';
  final tException = Exception('Failed to clear OTP');

  group('ClearOtpUseCase', () {
    test(
        'Given AuthServerRepository.clearOtpResponse completes successfully, When use case is called, Then completes normally',
        () async {
      // Given
      // For Future<void>, thenAnswer with an empty async block or Future.value()
      when(() => mockAuthServerRepository.clearOtpResponse(any()))
          .thenAnswer((_) async {});

      // When
      final call = useCase(tPhoneOrEmail);

      // Then
      // Verifies that the Future completes without throwing an error
      await expectLater(call, completes);
      verify(() => mockAuthServerRepository.clearOtpResponse(tPhoneOrEmail)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test(
        'Given AuthServerRepository.clearOtpResponse throws an exception, When use case is called, Then throws the exception',
        () async {
      // Given
      when(() => mockAuthServerRepository.clearOtpResponse(any()))
          .thenThrow(tException);

      // When
      final call = useCase(tPhoneOrEmail);

      // Then
      await expectLater(call, throwsA(equals(tException)));
      verify(() => mockAuthServerRepository.clearOtpResponse(tPhoneOrEmail)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });
  });
}