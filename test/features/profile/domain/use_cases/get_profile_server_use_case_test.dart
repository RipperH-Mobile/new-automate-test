import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/features/profile/domain/use_cases/get_profile_server_use_case.dart';

// Mock Definitions
class MockProfileServerRepository extends Mock implements ProfileServerRepository {}

void main() {
  late GetProfileServerUseCase useCase;
  late MockProfileServerRepository mockProfileServerRepository;
  late ProfileEntity tProfileEntity;
  const tAccountId = 'account123';

  setUp(() {
    mockProfileServerRepository = MockProfileServerRepository();
    useCase = GetProfileServerUseCase(
      profileServerRepository: mockProfileServerRepository,
    );
    tProfileEntity = ProfileEntity(
      id: tAccountId,
      username: 'testuser',
      phoneNumber: '+1234567890',
      displayName: 'Test User',
      statusMessage: 'Test status',
      avatarId: 'avatar123',
      avatarBlurhash: 'blurhash123',
      onlineStatus: OnlineStatus.online,
      deleted: false,
      isBlocked: false,
      settings: AccountSettingsModel(),
      currentSessionKeyId: 'session123',
      isFriend: true,
      friendNickname: 'Test Friend',
    );
    reset(mockProfileServerRepository);
  });

  group('call', () {
    test('Given server repository returns ProfileEntity, When call is executed, Then returns ProfileEntity', () async {
      // Given
      when(() => mockProfileServerRepository.getProfile(tAccountId)).thenAnswer((_) async => tProfileEntity);

      // When
      final result = await useCase.call(tAccountId);

      // Then
      expect(result, equals(tProfileEntity));
      verify(() => mockProfileServerRepository.getProfile(tAccountId)).called(1);
      verifyNoMoreInteractions(mockProfileServerRepository);
    });

    test('Given server repository throws exception, When call is executed, Then exception is propagated', () async {
      // Given
      final testException = Exception('Server error');
      when(() => mockProfileServerRepository.getProfile(tAccountId)).thenThrow(testException);

      // When
      call() => useCase.call(tAccountId);

      // Then
      expect(call, throwsA(equals(testException)));
      verify(() => mockProfileServerRepository.getProfile(tAccountId)).called(1);
      verifyNoMoreInteractions(mockProfileServerRepository);
    });
  });
}
