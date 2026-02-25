import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/core/exceptions/multiple_account_limit_exceed_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/process_before_add_account_use_case.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_api_service_new.dart';

class MockUserLocalRepository extends Mock implements UserLocalRepository {}

class MockAuthApiServiceNew extends Mock implements AuthApiServiceNew {}

class MockUserController extends Mock implements UserController {}

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late ProcessBeforeAddAccountUseCase useCase;
  late MockUserLocalRepository mockUserLocalRepository;
  late MockAuthApiServiceNew mockAuthApiServiceNew;
  late MockUserController mockUserController;
  late MockLoggerService mockLogger;

  setUpAll(() {
    mockLogger = MockLoggerService();

    GetIt.I.registerFactory<LoggerService>(() => mockLogger);

    when(() => mockLogger.e(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.d(any(), any(), any())).thenReturn(null);
  });

  setUp(() {
    mockUserLocalRepository = MockUserLocalRepository();
    mockAuthApiServiceNew = MockAuthApiServiceNew();
    mockUserController = MockUserController();
    useCase = ProcessBeforeAddAccountUseCase(
      userLocalRepository: mockUserLocalRepository,
      authApiServiceNew: mockAuthApiServiceNew,
      mockUserController: mockUserController,
    );
    reset(mockUserLocalRepository);
    reset(mockAuthApiServiceNew);
    reset(mockUserController);
  });

  test(
    'Given less than 4 accounts and new user not logged in, When called, Then completes without error',
    () async {
      // Given
      final params = ProcessBeforeAddAccountParams(user: UserEntity(id: 'newUser'));
      final user = UserEntity(id: 'existingUser');
      final user2 = UserEntity(id: 'existingUser2');
      when(() => mockUserLocalRepository.getUserCount()).thenAnswer((_) async => 2);
      when(() => mockUserLocalRepository.getAllUsersIncludeHidden()).thenAnswer((_) async => [user, user2]);

      // When
      final call = useCase.call(params);

      // Then
      await expectLater(call, completes);
      verify(() => mockUserLocalRepository.getUserCount()).called(1);
      verify(() => mockUserLocalRepository.getAllUsersIncludeHidden()).called(1);
    },
  );

  test(
    'Given 4 accounts and new user not logged in, When called, Then throws MultipleAccountLimitExceedException',
    () async {
      // Given
      final params = ProcessBeforeAddAccountParams(user: UserEntity(id: 'newUser'));
      final user = UserEntity(id: 'existingUser');
      final user2 = UserEntity(id: 'existingUser2');
      final user3 = UserEntity(id: 'existingUser3');
      final user4 = UserEntity(id: 'existingUser4');
      when(() => mockUserLocalRepository.getUserCount()).thenAnswer((_) async => 4);
      when(() => mockUserLocalRepository.getAllUsersIncludeHidden())
          .thenAnswer((_) async => [user, user2, user3, user4]);

      // When
      final call = useCase.call(params);

      // Then
      await expectLater(call, throwsA(isA<MultipleAccountLimitExceedException>()));
      verify(() => mockUserLocalRepository.getUserCount()).called(1);
      verify(() => mockUserLocalRepository.getAllUsersIncludeHidden()).called(1);
    },
  );

  test(
    'Given user already logged in, When called, Then does not throw and log out is called',
    () async {
      // Given
      final params = ProcessBeforeAddAccountParams(user: UserEntity(id: 'existingUser'));
      final user = UserEntity(id: 'existingUser', token: 'token');
      final user2 = UserEntity(id: 'existingUser2');
      when(() => mockUserLocalRepository.getUserCount()).thenAnswer((_) async => 2);
      when(() => mockUserLocalRepository.getAllUsersIncludeHidden()).thenAnswer((_) async => [user, user2]);
      when(() => mockUserController.isCurrentUser('existingUser')).thenReturn(false);
      when(() => mockAuthApiServiceNew.logout(accessToken: 'token')).thenAnswer((_) async {});

      // When
      final call = useCase.call(params);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthApiServiceNew.logout(accessToken: 'token')).called(1);
      verify(() => mockUserLocalRepository.getUserCount()).called(1);
      verify(() => mockUserLocalRepository.getAllUsersIncludeHidden()).called(1);
    },
  );

  test(
    'Given adding current user, When called, Then does not throw and log out is called',
    () async {
      // Given
      final params = ProcessBeforeAddAccountParams(user: UserEntity(id: 'existingUser'));
      final user = UserEntity(id: 'existingUser');
      final user2 = UserEntity(id: 'existingUser2');
      when(() => mockUserLocalRepository.getUserCount()).thenAnswer((_) async => 2);
      when(() => mockUserLocalRepository.getAllUsersIncludeHidden()).thenAnswer((_) async => [user, user2]);
      when(() => mockUserController.isCurrentUser('existingUser')).thenReturn(true);
      when(() => mockAuthApiServiceNew.logout()).thenAnswer((_) async {});

      // When
      final call = useCase.call(params);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthApiServiceNew.logout()).called(1);
      verify(() => mockUserLocalRepository.getUserCount()).called(1);
      verify(() => mockUserLocalRepository.getAllUsersIncludeHidden()).called(1);
    },
  );

  test(
    'Given 4 accounts and adding current user, When called, Then does not throw and log out is called',
    () async {
      // Given
      final params = ProcessBeforeAddAccountParams(user: UserEntity(id: 'existingUser'));
      final user = UserEntity(id: 'existingUser');
      final user2 = UserEntity(id: 'existingUser2');
      final user3 = UserEntity(id: 'existingUser3');
      final user4 = UserEntity(id: 'existingUser4');
      when(() => mockUserLocalRepository.getUserCount()).thenAnswer((_) async => 4);
      when(() => mockUserLocalRepository.getAllUsersIncludeHidden())
          .thenAnswer((_) async => [user, user2, user3, user4]);
      when(() => mockUserController.isCurrentUser('existingUser')).thenReturn(true);
      when(() => mockAuthApiServiceNew.logout()).thenAnswer((_) async {});

      // When
      final call = useCase.call(params);

      // Then
      await expectLater(call, completes);
      verify(() => mockAuthApiServiceNew.logout()).called(1);
      verify(() => mockUserLocalRepository.getUserCount()).called(1);
      verify(() => mockUserLocalRepository.getAllUsersIncludeHidden()).called(1);
    },
  );

  test(
    'Given 4 accounts and adding current user amd old user have set shortcutPasscode and isMAHidden, When called, Then does not throw and log out is called and return user with same shortcutPasscode and isMAHidden',
    () async {
      // Given
      final params = ProcessBeforeAddAccountParams(user: UserEntity(id: 'existingUser'));
      final user = UserEntity(id: 'existingUser', isMAHidden: true, shortcutPasscode: '000000');
      final user2 = UserEntity(id: 'existingUser2');
      final user3 = UserEntity(id: 'existingUser3');
      final user4 = UserEntity(id: 'existingUser4');
      when(() => mockUserLocalRepository.getUserCount()).thenAnswer((_) async => 4);
      when(() => mockUserLocalRepository.getAllUsersIncludeHidden())
          .thenAnswer((_) async => [user, user2, user3, user4]);
      when(() => mockUserController.isCurrentUser('existingUser')).thenReturn(true);
      when(() => mockAuthApiServiceNew.logout()).thenAnswer((_) async {});

      // When
      final result = await useCase.call(params);

      // Then
      expect(result.isMAHidden, true);
      expect(result.shortcutPasscode, '000000');
      verify(() => mockAuthApiServiceNew.logout()).called(1);
      verify(() => mockUserLocalRepository.getUserCount()).called(1);
      verify(() => mockUserLocalRepository.getAllUsersIncludeHidden()).called(1);
    },
  );
}
