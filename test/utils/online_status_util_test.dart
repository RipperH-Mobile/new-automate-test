import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_members_in_room_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_room_direct_is_block_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_room_direct_is_vibranium_shield_use_case.dart';
import 'package:uchat/utils/online_status_util.dart';

class MockGetAllMembersInRoomUseCase extends Mock implements GetAllMembersInRoomUseCase {}

class MockGetRoomDirectIsBlockUseCase extends Mock implements GetRoomDirectIsBlockUseCase {}

class MockGetRoomDirectIsVibraniumShieldUseCase extends Mock implements GetRoomDirectIsVibraniumShieldUseCase {}

void main() {
  //NOTE.declear variable for mock data and type
  final getIt = GetIt.instance;
  late MockGetAllMembersInRoomUseCase mockChatRoomLocalUseCase;
  late MockGetRoomDirectIsBlockUseCase mockIsBlockUseCase;
  late MockGetRoomDirectIsVibraniumShieldUseCase mockIsShieldUseCase;
  late List<RoomMemberEntity> response;
  late List<RoomMemberEntity> responseGroupOffline;

  setUp(() {
    //NOTE.mock data that we need
    mockChatRoomLocalUseCase = MockGetAllMembersInRoomUseCase();
    mockIsBlockUseCase = MockGetRoomDirectIsBlockUseCase();
    mockIsShieldUseCase = MockGetRoomDirectIsVibraniumShieldUseCase();
    response = [
      RoomMemberEntity(account: ContactModel(id: 'myId'), roomId: 'A', roomType: RoomType.direct),
      RoomMemberEntity(account: ContactModel(id: '007'), roomId: 'B', roomType: RoomType.direct),
    ];

    responseGroupOffline = [
      RoomMemberEntity(account: ContactModel(id: 'myId'), roomId: 'A', roomType: RoomType.direct),
      RoomMemberEntity(account: ContactModel(id: '404'), roomId: 'B', roomType: RoomType.direct),
    ];

    OnlineStatusUtil.myAccountId = 'myId';

    OnlineStatusUtil.onlineUsers = <dynamic, dynamic>{
      'myId': 'online',
      '001': 'online',
      '007': 'online',
    }.obs;

    //NOTE.inject mock use case to test with mock usecase instead of real usecase
    getIt.registerSingleton<GetAllMembersInRoomUseCase>(mockChatRoomLocalUseCase);
    getIt.registerSingleton<GetRoomDirectIsBlockUseCase>(mockIsBlockUseCase);
    getIt.registerSingleton<GetRoomDirectIsVibraniumShieldUseCase>(mockIsShieldUseCase);

    // default mock: all users not blocked/shielded
    when(() => mockIsBlockUseCase.call(any())).thenReturn(false);
    when(() => mockIsShieldUseCase.call(any())).thenReturn(false);
  });

  tearDown(() {
    getIt.reset();
  });

  test('getRxOnlineStatusDirectRoom returns Online when me is online', () {
    final status = OnlineStatusUtil.getRxOnlineStatusDirectRoom(accountId: 'myId');
    expect(status.value, OnlineStatus.online);
  });

  test('getRxOnlineStatusDirectRoom returns Online when user is online', () {
    final status = OnlineStatusUtil.getRxOnlineStatusDirectRoom(accountId: '001');
    expect(status.value, OnlineStatus.online);
  });

  test('getRxOnlineStatusDirectRoom returns Offline when user is offline', () {
    final status = OnlineStatusUtil.getRxOnlineStatusDirectRoom(accountId: '002');
    expect(status.value, OnlineStatus.offline);
  });

  test('getRxOnlineStatus returns Offline for unknown data type', () {
    final status = OnlineStatusUtil.getRxOnlineStatus('unknown');
    expect(status.value, OnlineStatus.offline);
  });

  test('getRxOnlineStatusGroupRoom returns Online if any member (excluding myself) is online', () {
    when(() => mockChatRoomLocalUseCase.call('groupId')).thenAnswer((_) => response);

    final status = OnlineStatusUtil.getRxOnlineStatusGroupRoom(groupId: 'groupId');

    expect(status.value, OnlineStatus.online);

    verify(() => mockChatRoomLocalUseCase.call('groupId')).called(1);
  });
  test('getRxOnlineStatusGroupRoom returns Offline if only have me online but other was not', () {
    when(() => mockChatRoomLocalUseCase.call('groupId2')).thenAnswer((_) => responseGroupOffline);

    final status = OnlineStatusUtil.getRxOnlineStatusGroupRoom(groupId: 'groupId2');

    expect(status.value, OnlineStatus.offline);

    verify(() => mockChatRoomLocalUseCase.call('groupId2')).called(1);
  });

  test('getRxOnlineStatusGroupRoom returns Offline if only online user is blocked', () {
    //NOTE. 007 is blocked but still online => offline
    when(() => mockChatRoomLocalUseCase.call('groupIdBlock')).thenReturn(response);
    when(() => mockIsBlockUseCase.call('007')).thenReturn(true);
    when(() => mockIsShieldUseCase.call('007')).thenReturn(false);

    final status = OnlineStatusUtil.getRxOnlineStatusGroupRoom(groupId: 'groupIdBlock');

    expect(status.value, OnlineStatus.offline);
  });

  test('getRxOnlineStatusGroupRoom returns Offline if only online user is shielded', () {
    //NOTE. 007 is vibranium shield but still online => offline
    when(() => mockChatRoomLocalUseCase.call('groupIdShield')).thenReturn(response);
    when(() => mockIsBlockUseCase.call('007')).thenReturn(false);
    when(() => mockIsShieldUseCase.call('007')).thenReturn(true);

    final status = OnlineStatusUtil.getRxOnlineStatusGroupRoom(groupId: 'groupIdShield');

    expect(status.value, OnlineStatus.offline);
  });
}
