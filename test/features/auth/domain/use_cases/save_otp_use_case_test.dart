import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';

// Mock classes
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

class FakeSaveOtpResponseRequest extends Fake implements SaveOtpResponseRequest {}
class FakeOtpEntity extends Fake implements OtpEntity {}

void main() {
  late SaveOtpUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;

  setUpAll(() {
    registerFallbackValue(FakeSaveOtpResponseRequest());
    registerFallbackValue(FakeOtpEntity()); 
  });

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = SaveOtpUseCase(authServerRepository: mockAuthServerRepository);
  });

  // Test data
  const tOtpEntity = OtpEntity(
    token: 'test_token',
    ref: 'test_ref',
    type: 'sms',
    actionToken: 'test_action_token',
  );

  final tSaveOtpResponseRequest = SaveOtpResponseRequest(
    otpEntity: tOtpEntity,
    phoneOrEmail: 'test@example.com',
  );

  final tException = Exception('Failed to save OTP');

  group('SaveOtpUseCase', () {
    test(
        'Given AuthServerRepository.saveOtpResponse completes successfully, When use case is called, Then completes normally',
        () async {
      // Given
      when(() => mockAuthServerRepository.saveOtpResponse(any()))
          .thenAnswer((_) async => Future.value()); // For Future<void>

      // When
      final call = useCase(tSaveOtpResponseRequest);

      // Then
      await expectLater(call, completes); // Verifies it doesn't throw
      verify(() => mockAuthServerRepository.saveOtpResponse(tSaveOtpResponseRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test(
        'Given AuthServerRepository.saveOtpResponse throws an exception, When use case is called, Then throws the exception',
        () async {
      // Given
      when(() => mockAuthServerRepository.saveOtpResponse(any()))
          .thenThrow(tException);

      // When
      final call = useCase(tSaveOtpResponseRequest);

      // Then
      await expectLater(call, throwsA(equals(tException)));
      verify(() => mockAuthServerRepository.saveOtpResponse(tSaveOtpResponseRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });
  });
}