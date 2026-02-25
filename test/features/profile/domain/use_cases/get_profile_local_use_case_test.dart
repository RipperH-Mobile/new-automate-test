import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/features/profile/domain/use_cases/get_profile_local_use_case.dart';

// Mock Definitions
class MockProfileServerRepository extends Mock implements ProfileServerRepository {}

class MockProfileLocalRepository extends Mock implements ProfileLocalRepository {}

void main() {
  late GetProfileLocalUseCase useCase;
  late MockProfileLocalRepository mockProfileLocalRepository;
  late ProfileEntity tProfileEntity;
  const tAccountId = 'account123';

  setUp(() {
    mockProfileLocalRepository = MockProfileLocalRepository();
    useCase = GetProfileLocalUseCase(
      profileLocalRepository: mockProfileLocalRepository,
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
    reset(mockProfileLocalRepository);
  });

  group('call', () {
    test(
        'Given local repository returns ProfileEntity, When call is executed, Then returns ProfileEntity and server repository is not called',
        () async {
      // Given
      when(() => mockProfileLocalRepository.getContact(tAccountId)).thenAnswer((_) async => tProfileEntity);

      // When
      final result = await useCase.call(tAccountId);

      // Then
      expect(result, equals(tProfileEntity));
      verify(() => mockProfileLocalRepository.getContact(tAccountId)).called(1);
    });

    test(
        'Given local repository returns null, When call is executed, Then returns null and server repository is not called',
        () async {
      // Given
      when(() => mockProfileLocalRepository.getContact(tAccountId)).thenAnswer((_) async => null);

      // When
      final result = await useCase.call(tAccountId);

      // Then
      expect(result, isNull);
      verify(() => mockProfileLocalRepository.getContact(tAccountId)).called(1);
    });

    test(
        'Given local repository throws exception, When call is executed, Then exception is propagated and server repository is not called',
        () async {
      // Given
      final testException = Exception('Local storage error');
      when(() => mockProfileLocalRepository.getContact(tAccountId)).thenThrow(testException);

      // When
      call() => useCase.call(tAccountId);

      // Then
      expect(call, throwsA(equals(testException)));
      verify(() => mockProfileLocalRepository.getContact(tAccountId)).called(1);
    });
  });
}
