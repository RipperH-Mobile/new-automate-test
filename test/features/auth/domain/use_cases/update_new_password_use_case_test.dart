import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/data/models/requests/update_new_password_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/update_new_password_use_case.dart';

// Mock Definitions
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

void main() {
  late UpdateNewPasswordUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = UpdateNewPasswordUseCase(repository: mockAuthServerRepository);
    reset(mockAuthServerRepository); // Reset mock before each test
  });

  const tActionToken = 'test_action_token';
  const tNewPassword = 'TestNewPassword123!';
  final tUpdateNewPasswordRequest = UpdateNewPasswordRequest(
    actionToken: tActionToken,
    newPassword: tNewPassword,
  );

  test(
      'Given repository updates new password successfully, When UpdateNewPasswordUseCase is called, Then completes normally',
      () async {
    // Given
    when(() => mockAuthServerRepository.updateNewPassword(tUpdateNewPasswordRequest))
        .thenAnswer((_) async {}); // For Future<void>

    // When
    final call = useCase.call(tUpdateNewPasswordRequest);

    // Then
    await expectLater(call, completes);
    verify(() => mockAuthServerRepository.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });

  test(
      'Given repository throws an exception, When UpdateNewPasswordUseCase is called, Then throws the same exception',
      () async {
    // Given
    final tException = Exception('Network error');
    when(() => mockAuthServerRepository.updateNewPassword(tUpdateNewPasswordRequest))
        .thenThrow(tException);

    // When
    final call = useCase.call(tUpdateNewPasswordRequest);

    // Then
    await expectLater(call, throwsA(equals(tException)));
    verify(() => mockAuthServerRepository.updateNewPassword(tUpdateNewPasswordRequest)).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });
}