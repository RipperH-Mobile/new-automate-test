import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/exceptions/invalid_token_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/get_session_expired_account_use_case.dart';

class MockAccountService extends Mock implements AccountService {}

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late GetSessionExpiredAccountUseCase useCase;
  late AccountService mockAccountService;
  late MockLoggerService mockLogger;

  setUpAll(() {
    mockLogger = MockLoggerService();
    mockAccountService = MockAccountService();

    GetIt.I.registerFactory<LoggerService>(() => mockLogger);

    when(() => mockLogger.e(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.d(any(), any(), any())).thenReturn(null);
  });

  setUp(() {
    useCase = GetSessionExpiredAccountUseCase(accountService: mockAccountService);
    reset(mockAccountService);
  });

  test('Given there is only 1 account and it is not expired, When called, Then returns empty expired account list',
      () async {
    // Given
    final user = UserEntity(id: 'user1', token: 'valid_token', isMAHidden: false);
    final params = GetSessionExpiredAccountParams(userList: [user]);

    when(() => mockAccountService.getProfileWithCustomToken('valid_token')).thenAnswer((_) async => Future.value());

    // When
    final response = await useCase.call(params);

    // Then
    expect(response.allExpiredAccounts, isEmpty);
    expect(response.visibleExpiredAccounts, isEmpty);
    expect(response.expiredHiddenAccountCount, 0);
    verify(() => mockAccountService.getProfileWithCustomToken('valid_token')).called(1);
  });

  test('Given there is 1 valid account and 1 expired account, When called, Then returns 1 expired account list',
      () async {
    // Given
    final user1 = UserEntity(id: 'user1', token: 'valid_token', isMAHidden: false);
    final user2 = UserEntity(id: 'user2', token: 'invalid_token', isMAHidden: false);
    final params = GetSessionExpiredAccountParams(userList: [user1, user2]);

    when(() => mockAccountService.getProfileWithCustomToken('valid_token')).thenAnswer((_) async => Future.value());
    when(() => mockAccountService.getProfileWithCustomToken('invalid_token'))
        .thenThrow(InvalidTokenException(message: 'token expired'));

    // When
    final response = await useCase.call(params);

    // Then
    expect(response.allExpiredAccounts, [user2]);
    expect(response.visibleExpiredAccounts, [user2]);
    expect(response.expiredHiddenAccountCount, 0);
    verify(() => mockAccountService.getProfileWithCustomToken('valid_token')).called(1);
    verify(() => mockAccountService.getProfileWithCustomToken('invalid_token')).called(1);
  });

  test('Given there is 1 valid account and 3 expired account, When called, Then returns 3 expired account list',
      () async {
    // Given
    final user1 = UserEntity(id: 'user1', token: 'valid_token', isMAHidden: false);
    final user2 = UserEntity(id: 'user2', token: 'invalid_token', isMAHidden: false);
    final user3 = UserEntity(id: 'user3', token: 'invalid_token', isMAHidden: false);
    final user4 = UserEntity(id: 'user4', token: 'invalid_token', isMAHidden: false);
    final params = GetSessionExpiredAccountParams(userList: [user1, user2, user3, user4]);

    when(() => mockAccountService.getProfileWithCustomToken('valid_token')).thenAnswer((_) async => Future.value());
    when(() => mockAccountService.getProfileWithCustomToken('invalid_token'))
        .thenThrow(InvalidTokenException(message: 'token expired'));

    // When
    final response = await useCase.call(params);

    // Then
    expect(response.allExpiredAccounts, [user2, user3, user4]);
    expect(response.visibleExpiredAccounts, [user2, user3, user4]);
    expect(response.expiredHiddenAccountCount, 0);
    verify(() => mockAccountService.getProfileWithCustomToken('valid_token')).called(1);
    verify(() => mockAccountService.getProfileWithCustomToken('invalid_token')).called(3);
  });

  test(
      'Given there is 1 valid account and 1 hidden expired account, When called, Then returns empty expired account list and 1 expire hidden count',
      () async {
    // Given
    final user1 = UserEntity(id: 'user1', token: 'valid_token', isMAHidden: false);
    final user2 = UserEntity(id: 'user2', token: 'invalid_token', isMAHidden: true);
    final params = GetSessionExpiredAccountParams(userList: [user1, user2]);

    when(() => mockAccountService.getProfileWithCustomToken('valid_token')).thenAnswer((_) async => Future.value());
    when(() => mockAccountService.getProfileWithCustomToken('invalid_token'))
        .thenThrow(InvalidTokenException(message: 'token expired'));

    // When
    final response = await useCase.call(params);

    // Then
    expect(response.allExpiredAccounts, [user2]);
    expect(response.visibleExpiredAccounts, []);
    expect(response.expiredHiddenAccountCount, 1);
    verify(() => mockAccountService.getProfileWithCustomToken('valid_token')).called(1);
    verify(() => mockAccountService.getProfileWithCustomToken('invalid_token')).called(1);
  });

  test(
      'Given there is 1 valid account and 3 hidden expired account, When called, Then returns empty expired account list and 3 expire hidden count',
      () async {
    // Given
    final user1 = UserEntity(id: 'user1', token: 'valid_token', isMAHidden: false);
    final user2 = UserEntity(id: 'user2', token: 'invalid_token', isMAHidden: true);
    final user3 = UserEntity(id: 'user3', token: 'invalid_token', isMAHidden: true);
    final user4 = UserEntity(id: 'user4', token: 'invalid_token', isMAHidden: true);
    final params = GetSessionExpiredAccountParams(userList: [user1, user2, user3, user4]);

    when(() => mockAccountService.getProfileWithCustomToken('valid_token')).thenAnswer((_) async => Future.value());
    when(() => mockAccountService.getProfileWithCustomToken('invalid_token'))
        .thenThrow(InvalidTokenException(message: 'token expired'));

    // When
    final response = await useCase.call(params);

    // Then
    expect(response.allExpiredAccounts, [user2, user3, user4]);
    expect(response.visibleExpiredAccounts, []);
    expect(response.expiredHiddenAccountCount, 3);
    verify(() => mockAccountService.getProfileWithCustomToken('valid_token')).called(1);
    verify(() => mockAccountService.getProfileWithCustomToken('invalid_token')).called(3);
  });

  test(
      'Given there is 1 valid account, 1 expired account and 1 hidden expired account, When called, Then returns 1 expired account list and 1 expire hidden count',
      () async {
    // Given
    final user1 = UserEntity(id: 'user1', token: 'valid_token', isMAHidden: false);
    final user2 = UserEntity(id: 'user2', token: 'invalid_token', isMAHidden: false);
    final user3 = UserEntity(id: 'user3', token: 'invalid_token', isMAHidden: true);
    final user4 = UserEntity(id: 'user4', token: 'valid_token', isMAHidden: false);
    final params = GetSessionExpiredAccountParams(userList: [user1, user2, user3, user4]);

    when(() => mockAccountService.getProfileWithCustomToken('valid_token')).thenAnswer((_) async => Future.value());
    when(() => mockAccountService.getProfileWithCustomToken('invalid_token'))
        .thenThrow(InvalidTokenException(message: 'token expired'));

    // When
    final response = await useCase.call(params);

    // Then
    expect(response.allExpiredAccounts, [user2, user3]);
    expect(response.visibleExpiredAccounts, [user2]);
    expect(response.expiredHiddenAccountCount, 1);
    verify(() => mockAccountService.getProfileWithCustomToken('valid_token')).called(2);
    verify(() => mockAccountService.getProfileWithCustomToken('invalid_token')).called(2);
  });

  test(
      'Given there is 1 valid account, 2 expired account and 2 hidden expired account, When called, Then returns 2 expired account list and 2 expire hidden count',
      () async {
    // Given
    final user1 = UserEntity(id: 'user1', token: 'valid_token', isMAHidden: false);
    final user2 = UserEntity(id: 'user2', token: 'invalid_token', isMAHidden: false);
    final user3 = UserEntity(id: 'user3', token: 'invalid_token', isMAHidden: true);
    final user4 = UserEntity(id: 'user4', token: 'invalid_token', isMAHidden: false);
    final user5 = UserEntity(id: 'user5', token: 'invalid_token', isMAHidden: true);
    final params = GetSessionExpiredAccountParams(userList: [user1, user2, user3, user4, user5]);

    when(() => mockAccountService.getProfileWithCustomToken('valid_token')).thenAnswer((_) async => Future.value());
    when(() => mockAccountService.getProfileWithCustomToken('invalid_token'))
        .thenThrow(InvalidTokenException(message: 'token expired'));

    // When
    final response = await useCase.call(params);

    // Then
    expect(response.allExpiredAccounts, [user2, user3, user4, user5]);
    expect(response.visibleExpiredAccounts, [user2, user4]);
    expect(response.expiredHiddenAccountCount, 2);
    verify(() => mockAccountService.getProfileWithCustomToken('valid_token')).called(1);
    verify(() => mockAccountService.getProfileWithCustomToken('invalid_token')).called(4);
  });
}
