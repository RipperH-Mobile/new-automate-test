import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_subscription_local_repository.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_has_first_other_in_room_use_case.dart';

class MockRoomSubscriptionLocalRepository extends Mock implements RoomSubscriptionLocalRepository {}

class MockRoomMemberLocalRepository extends Mock implements RoomMemberLocalRepository {}

class FakeRoomSubscriptionEntity extends Fake implements RoomSubscriptionEntity {}

void main() {
  late SyncHandleUpdateHasFirstOtherInRoomUseCase useCase;
  late MockRoomSubscriptionLocalRepository mockRoomSubscriptionLocalRepository;
  late MockRoomMemberLocalRepository mockRoomMemberLocalRepository;
  late RoomSubscriptionEntity testRoomSubscription;

  setUpAll(() {
    registerFallbackValue(FakeRoomSubscriptionEntity());
  });

  setUp(() {
    mockRoomSubscriptionLocalRepository = MockRoomSubscriptionLocalRepository();
    mockRoomMemberLocalRepository = MockRoomMemberLocalRepository();
    useCase = SyncHandleUpdateHasFirstOtherInRoomUseCase(
      roomSubscriptionLocalRepository: mockRoomSubscriptionLocalRepository,
      roomMemberLocalRepository: mockRoomMemberLocalRepository,
    );
    testRoomSubscription = const RoomSubscriptionEntity(
      id: 'sub123',
      roomId: 'room123',
      hasFirstOtherInRoom: false,
    );

    // Reset mocks before each test
    reset(mockRoomSubscriptionLocalRepository);
    reset(mockRoomMemberLocalRepository);
  });

  group('call', () {
    const testRoomId = 'room123';

    test(
        'Given room subscription exists and member count is greater than 1, When use case is called, Then hasFirstOtherInRoom is set to true',
        () async {
      // Given
      when(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).thenAnswer((_) async => 3);
      when(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId))
          .thenAnswer((_) async => testRoomSubscription);
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: false,
          )).thenAnswer((_) async => null);

      // When
      await useCase.call(testRoomId);

      // Then
      verify(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId)).called(1);

      final captured = verify(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: captureAny(named: 'roomSub'),
            useTxn: false,
          )).captured;

      final updatedRoomSub = captured.single as RoomSubscriptionEntity;
      expect(updatedRoomSub.hasFirstOtherInRoom, isTrue);
      expect(updatedRoomSub.id, equals(testRoomSubscription.id));
      expect(updatedRoomSub.roomId, equals(testRoomSubscription.roomId));
    });

    test(
        'Given room subscription exists and member count is 1, When use case is called, Then hasFirstOtherInRoom is set to false',
        () async {
      // Given
      final roomSubWithTrue = testRoomSubscription.copyWith(hasFirstOtherInRoom: true);
      when(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).thenAnswer((_) async => 1);
      when(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId))
          .thenAnswer((_) async => roomSubWithTrue);
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: false,
          )).thenAnswer((_) async => null);

      // When
      await useCase.call(testRoomId);

      // Then
      verify(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId)).called(1);

      final captured = verify(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: captureAny(named: 'roomSub'),
            useTxn: false,
          )).captured;

      final updatedRoomSub = captured.single as RoomSubscriptionEntity;
      expect(updatedRoomSub.hasFirstOtherInRoom, isFalse);
      expect(updatedRoomSub.id, equals(testRoomSubscription.id));
      expect(updatedRoomSub.roomId, equals(testRoomSubscription.roomId));
    });

    test(
        'Given room subscription exists and member count is 0, When use case is called, Then hasFirstOtherInRoom is set to false',
        () async {
      // Given
      final roomSubWithTrue = testRoomSubscription.copyWith(hasFirstOtherInRoom: true);
      when(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).thenAnswer((_) async => 0);
      when(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId))
          .thenAnswer((_) async => roomSubWithTrue);
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: false,
          )).thenAnswer((_) async => null);

      // When
      await useCase.call(testRoomId);

      // Then
      verify(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId)).called(1);

      final captured = verify(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: captureAny(named: 'roomSub'),
            useTxn: false,
          )).captured;

      final updatedRoomSub = captured.single as RoomSubscriptionEntity;
      expect(updatedRoomSub.hasFirstOtherInRoom, isFalse);
      expect(updatedRoomSub.id, equals(testRoomSubscription.id));
      expect(updatedRoomSub.roomId, equals(testRoomSubscription.roomId));
    });

    test('Given room subscription does not exist, When use case is called, Then putRoomSubscription is not called',
        () async {
      // Given
      when(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).thenAnswer((_) async => 3);
      when(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId))
          .thenAnswer((_) async => null);

      // When
      await useCase.call(testRoomId);

      // Then
      verify(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId)).called(1);
      verifyNever(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          ));
    });

    test('Given room member repository throws exception, When use case is called, Then exception is propagated',
        () async {
      // Given
      final exception = Exception('Member count error');
      when(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).thenThrow(exception);

      // When & Then
      expect(() => useCase.call(testRoomId), throwsA(equals(exception)));

      verify(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).called(1);
      verifyNever(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: any(named: 'roomId')));
      verifyNever(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          ));
    });

    test(
        'Given room subscription repository throws exception when getting subscription, When use case is called, Then exception is propagated',
        () async {
      // Given
      final exception = Exception('Get subscription error');
      when(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).thenAnswer((_) async => 3);
      when(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId))
          .thenThrow(exception);

      // When & Then
      await expectLater(() => useCase.call(testRoomId), throwsA(equals(exception)));

      verify(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId)).called(1);
      verifyNever(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          ));
    });

    test(
        'Given room subscription repository throws exception when putting subscription, When use case is called, Then exception is propagated',
        () async {
      // Given
      final exception = Exception('Put subscription error');
      when(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).thenAnswer((_) async => 3);
      when(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId))
          .thenAnswer((_) async => testRoomSubscription);
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: false,
          )).thenThrow(exception);

      // When & Then
      await expectLater(() => useCase.call(testRoomId), throwsA(equals(exception)));

      verify(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId)).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: false,
          )).called(1);
    });

    test('Given member count is exactly 2, When use case is called, Then hasFirstOtherInRoom is set to true', () async {
      // Given
      when(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).thenAnswer((_) async => 2);
      when(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId))
          .thenAnswer((_) async => testRoomSubscription);
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: false,
          )).thenAnswer((_) async => null);

      // When
      await useCase.call(testRoomId);

      // Then
      verify(() => mockRoomMemberLocalRepository.countMemberByRoomId(roomId: testRoomId)).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: testRoomId)).called(1);

      final captured = verify(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: captureAny(named: 'roomSub'),
            useTxn: false,
          )).captured;

      final updatedRoomSub = captured.single as RoomSubscriptionEntity;
      expect(updatedRoomSub.hasFirstOtherInRoom, isTrue);
    });
  });
}
