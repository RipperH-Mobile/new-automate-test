import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_password_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_new_password_use_case.dart';

// Mock Definitions
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

void main() {
  late ValidateNewPasswordUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = ValidateNewPasswordUseCase(repository: mockAuthServerRepository);
    reset(mockAuthServerRepository); // Reset mock before each test
  });

  const tNewPassword = 'TestNewPassword123!';
  final tValidateNewPasswordRequest = ValidateNewPasswordRequest(
    newPassword: tNewPassword,
  );

  test(
      'Given repository validates new password successfully, When ValidateNewPasswordUseCase is called, Then completes normally',
      () async {
    // Given
    when(() => mockAuthServerRepository.validateNewPassword(tValidateNewPasswordRequest))
        .thenAnswer((_) async {}); // For Future<void>

    // When
    final call = useCase.call(tValidateNewPasswordRequest);

    // Then
    await expectLater(call, completes);
    verify(() => mockAuthServerRepository.validateNewPassword(tValidateNewPasswordRequest)).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });

  test(
      'Given repository throws an exception, When ValidateNewPasswordUseCase is called, Then throws the same exception',
      () async {
    // Given
    final tException = Exception('Validation service error');
    when(() => mockAuthServerRepository.validateNewPassword(tValidateNewPasswordRequest))
        .thenThrow(tException);

    // When
    final call = useCase.call(tValidateNewPasswordRequest);

    // Then
    await expectLater(call, throwsA(equals(tException)));
    verify(() => mockAuthServerRepository.validateNewPassword(tValidateNewPasswordRequest)).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });
}