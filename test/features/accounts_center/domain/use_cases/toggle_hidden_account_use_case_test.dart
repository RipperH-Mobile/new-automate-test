import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/accounts_center/domain/events/hidden_account_update_event.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/toggle_hidden_account_use_case.dart';

class MockUserLocalRepository extends Mock implements UserLocalRepository {}

class MockEventBus extends Mock implements EventBus {}

void main() {
  late ToggleHiddenAccountUseCase useCase;
  late MockUserLocalRepository mockUserLocalRepository;
  late MockEventBus mockEventBus;

  setUpAll(() {
    registerFallbackValue(HiddenAccountUpdateEvent(accountId: 'id', isHidden: false));
    registerFallbackValue(UserEntity(id: 'userId', isMAHidden: false));
  });

  setUp(() {
    mockUserLocalRepository = MockUserLocalRepository();
    mockEventBus = MockEventBus();
    useCase = ToggleHiddenAccountUseCase(userLocalRepository: mockUserLocalRepository, eventBus: mockEventBus);
    reset(mockUserLocalRepository);
    reset(mockEventBus);
  });

  test(
    'Given user exists, When call is invoked, Then updates user and fires HiddenAccountUpdateEvent',
    () async {
      // Given
      const accountId = 'account_1';
      const isHidden = true;
      final params = ToggleHiddenAccountParams(accountId: accountId, isHidden: isHidden);
      final localUser = UserEntity(id: accountId, isMAHidden: false);

      when(() => mockUserLocalRepository.getUser(accountId)).thenAnswer((_) async => localUser);
      when(() => mockUserLocalRepository.putUser(any())).thenAnswer((_) async {});

      // When
      await useCase.call(params);

      // Then
      verify(() => mockUserLocalRepository.getUser(accountId)).called(1);
      verify(() => mockUserLocalRepository.putUser(any())).called(1);
      verify(() => mockEventBus.fire(any(that: isA<HiddenAccountUpdateEvent>()))).called(1);
      verifyNoMoreInteractions(mockUserLocalRepository);
    },
  );

  test(
    'Given user does not exist, When call is invoked, Then does nothing',
    () async {
      // Given
      const accountId = 'missing_account';
      final params = ToggleHiddenAccountParams(accountId: accountId, isHidden: true);
      when(() => mockUserLocalRepository.getUser(accountId)).thenAnswer((_) async => null);

      // When
      await useCase.call(params);

      // Then
      verify(() => mockUserLocalRepository.getUser(accountId)).called(1);
      verifyNever(() => mockUserLocalRepository.putUser(any()));
      verifyNever(() => mockEventBus.fire(any()));
      verifyNoMoreInteractions(mockUserLocalRepository);
    },
  );
}
