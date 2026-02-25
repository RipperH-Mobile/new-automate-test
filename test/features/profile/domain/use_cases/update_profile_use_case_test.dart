import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/features/profile/domain/use_cases/update_profile_use_case.dart';

// Mock Definitions
class MockProfileServerRepository extends Mock implements ProfileServerRepository {}

class MockProfileLocalRepository extends Mock implements ProfileLocalRepository {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

void main() {
  late UpdateProfileUseCase useCase;
  late MockProfileServerRepository mockProfileServerRepository;
  late MockProfileLocalRepository mockProfileLocalRepository;
  late ProfileEntity tProfileEntity;
  const tAccountId = 'account123';

  setUpAll(() {
    registerFallbackValue(FakeProfileEntity());
  });

  setUp(() {
    mockProfileServerRepository = MockProfileServerRepository();
    mockProfileLocalRepository = MockProfileLocalRepository();
    useCase = UpdateProfileUseCase(
      profileServerRepository: mockProfileServerRepository,
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
    reset(mockProfileServerRepository);
    reset(mockProfileLocalRepository);
  });

  group('call', () {
    test(
        'Given valid accountId, When call is executed, Then returns ProfileEntity from server and updates local repository',
        () async {
      // Given
      when(() => mockProfileServerRepository.getProfile(tAccountId)).thenAnswer((_) async => tProfileEntity);
      when(() => mockProfileLocalRepository.updateProfile(tProfileEntity)).thenAnswer((_) async {});

      // When
      final result = await useCase.call(tAccountId);

      // Then
      expect(result, equals(tProfileEntity));
      verify(() => mockProfileServerRepository.getProfile(tAccountId)).called(1);
      verify(() => mockProfileLocalRepository.updateProfile(tProfileEntity)).called(1);
      verifyNoMoreInteractions(mockProfileServerRepository);
      verifyNoMoreInteractions(mockProfileLocalRepository);
    });

    test(
        'Given server repository throws exception, When call is executed, Then exception is propagated and local repository is not called',
        () async {
      // Given
      final testException = Exception('Server error');
      when(() => mockProfileServerRepository.getProfile(tAccountId)).thenThrow(testException);

      // When
      call() => useCase.call(tAccountId);

      // Then
      expect(call, throwsA(equals(testException)));
      verify(() => mockProfileServerRepository.getProfile(tAccountId)).called(1);
      verifyNever(() => mockProfileLocalRepository.updateProfile(any()));
      verifyNoMoreInteractions(mockProfileServerRepository);
      verifyNoMoreInteractions(mockProfileLocalRepository);
    });

    test(
        'Given local repository throws exception after server success, When call is executed, Then exception is propagated',
        () async {
      // Given
      final testException = Exception('Local storage error');
      when(() => mockProfileServerRepository.getProfile(tAccountId)).thenAnswer((_) async => tProfileEntity);
      when(() => mockProfileLocalRepository.updateProfile(tProfileEntity)).thenThrow(testException);

      // When
      call() => useCase(tAccountId);

      // Then
      expect(call, throwsA(equals(testException)));
      verify(() => mockProfileServerRepository.getProfile(tAccountId)).called(1);
      verifyNever(() => mockProfileLocalRepository.updateProfile(any()));
      verifyNoMoreInteractions(mockProfileServerRepository);
      verifyNoMoreInteractions(mockProfileLocalRepository);
    });
  });
}
