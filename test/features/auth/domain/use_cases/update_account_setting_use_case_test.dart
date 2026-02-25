import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/account/update_account_setting.dart';
import 'package:uchat/api/payloads/account/user_response.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/update_account_setting_use_case.dart';

// Mock Definitions
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

void main() {
  // Given
  late UpdateAccountSettingUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;
  late UpdateAccountSettingRequest tRequest;
  late UserResponse tUserResponse;

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = UpdateAccountSettingUseCase(
      authServerRepository: mockAuthServerRepository,
    );
    
    // Reset mock before each test
    reset(mockAuthServerRepository);
    
    // Setup test data
    final accountSettings = AccountSettingsModel(
      // Initialize with minimal required settings
      call: CallSettingsModel(),
      chat: ChatSettingsModel(),
      friend: FriendSettingsModel(),
      notification: NotificationSettingsModel(),
      profile: ProfileSettingsModel(),
      security: SecuritySettingsModel(),
    );
    
    tRequest = UpdateAccountSettingRequest(
      accountSettingsModel: accountSettings,
    );
    
    tUserResponse = UserResponse();
    
    // Register fallback values for any custom types used in matchers
    registerFallbackValue(tRequest);
  });

  test(
    'Given auth repository returns UserResponse, When call is made, Then return UserResponse',
    () async {
      // Given
      when(() => mockAuthServerRepository.updateAccountSetting(any()))
          .thenAnswer((_) async => tUserResponse);

      // When
      final result = await useCase.call(tRequest);

      // Then
      expect(result, equals(tUserResponse));
      verify(() => mockAuthServerRepository.updateAccountSetting(tRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    },
  );

  test(
    'Given auth repository returns null, When call is made, Then return null',
    () async {
      // Given
      when(() => mockAuthServerRepository.updateAccountSetting(any()))
          .thenAnswer((_) async => null);

      // When
      final result = await useCase.call(tRequest);

      // Then
      expect(result, isNull);
      verify(() => mockAuthServerRepository.updateAccountSetting(tRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    },
  );

  test(
    'Given auth repository throws an exception, When call is made, Then propagate the exception',
    () async {
      // Given
      final tException = Exception('Test exception');
      when(() => mockAuthServerRepository.updateAccountSetting(any()))
          .thenThrow(tException);

      // When
      final call = useCase.call(tRequest);

      // Then
      await expectLater(call, throwsA(tException));
      verify(() => mockAuthServerRepository.updateAccountSetting(tRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    },
  );
}
