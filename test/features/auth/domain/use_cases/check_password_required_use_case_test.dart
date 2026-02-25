import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/domain/entities/check_password_required_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

// Mock Definitions
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

void main() {
  late CheckPasswordRequiredUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = CheckPasswordRequiredUseCase(authServerRepository: mockAuthServerRepository);
    reset(mockAuthServerRepository); // Reset mock before each test
  });

  const tCheckPasswordRequiredEntity = CheckPasswordRequiredEntity(passwordRequired: true);
  final tNoParams = NoParams();

  test(
      'Given repository returns a CheckPasswordRequiredEntity, When CheckPasswordRequiredUseCase is called, Then returns the same entity',
      () async {
    // Given
    when(() => mockAuthServerRepository.checkPasswordRequired()).thenAnswer((_) async => tCheckPasswordRequiredEntity);

    // When
    final result = await useCase.call(tNoParams);

    // Then
    expect(result, tCheckPasswordRequiredEntity);
    verify(() => mockAuthServerRepository.checkPasswordRequired()).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });

  test(
      'Given repository throws an exception, When CheckPasswordRequiredUseCase is called, Then throws the same exception',
      () async {
    // Given
    final tException = Exception('Server error');
    when(() => mockAuthServerRepository.checkPasswordRequired()).thenThrow(tException);

    // When
    final call = useCase.call(tNoParams);

    // Then
    await expectLater(call, throwsA(equals(tException)));
    verify(() => mockAuthServerRepository.checkPasswordRequired()).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });
}
