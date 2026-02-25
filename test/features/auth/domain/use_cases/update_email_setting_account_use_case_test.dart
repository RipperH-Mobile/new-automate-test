import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/data/models/requests/update_email_setting_account_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/update_email_setting_account_use_case.dart';

// Mock Definitions
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

void main() {
  late UpdateEmailSettingAccountUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = UpdateEmailSettingAccountUseCase(authServerRepository: mockAuthServerRepository);
    reset(mockAuthServerRepository); // Reset mock before each test
  });

  final tRequest = UpdateEmailSettingAccountRequest(
    actionToken: 'actionToken',
    newEmail: 'test@gmail.com',
  );

  test(
      'Given repository completes successfully, When UpdateEmailSettingAccountUseCase is called, Then completes without error',
      () async {
    // Given
    when(() => mockAuthServerRepository.updateEmailSettingAccount(tRequest)).thenAnswer((_) async => Future.value());

    // When
    final call = useCase.call(tRequest);

    // Then
    await expectLater(call, completes);
    verify(() => mockAuthServerRepository.updateEmailSettingAccount(tRequest)).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });

  test(
      'Given repository throws an exception, When UpdateEmailSettingAccountUseCase is called, Then throws the same exception',
      () async {
    // Given
    final tException = Exception('Server error');
    when(() => mockAuthServerRepository.updateEmailSettingAccount(tRequest)).thenThrow(tException);

    // When
    final call = useCase.call(tRequest);

    // Then
    await expectLater(call, throwsA(equals(tException)));
    verify(() => mockAuthServerRepository.updateEmailSettingAccount(tRequest)).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });
}
