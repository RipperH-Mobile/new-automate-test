import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/chat_room/domain/params/oa_rich_menu_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_oa_rich_menu_use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';

class MockChatRoomServerRepository extends Mock implements ChatRoomServerRepository {}

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

void main() {
  late MockChatRoomServerRepository serverRepository;
  late MockContactLocalRepository contactLocalRepository;
  late GetOaRichMenuUseCase systemUnderTest;

  setUp(() {
    serverRepository = MockChatRoomServerRepository();
    contactLocalRepository = MockContactLocalRepository();
    systemUnderTest =
        GetOaRichMenuUseCase(serverRepository: serverRepository, contactLocalRepository: contactLocalRepository);
  });

  setUpAll(() {
    registerFallbackValue(RichMenuModel());
  });

  tearDown(() {
    reset(serverRepository);
    reset(contactLocalRepository);
  });

  group('GetOaRichMenuUseCase', () {
    test(
        'Given valid officialAccountId, When call is executed, Then returns RichMenuModel from server and saves to local',
        () async {
      // Given
      const officialAccountId = 'test_official_account_id';
      final params = OaRichMenuParams(officialAccountId: officialAccountId);
      final expectedRichMenu = RichMenuModel(
        officialAccountId: officialAccountId,
        updatedAt: DateTime.now(),
        publishedAt: DateTime.now(),
        publishMenu: RichMenuPublishModel(
          id: '697619f53dc39d9e678307db',
          container: RichMenuContainerModel(
            width: 340,
            height: 340,
            imageId: 'uploaded-image-id',
          ),
          actions: [
            RichMenuFunctionModel(
              index: 1,
              command: RichMenuFunctionModel.commandSendMessage,
              bounds: RichMenuBoundsModel(x: 0, y: 0, width: 170, height: 340),
              commandArg: RichMenuCommandArgModel(message: 'Hello!'),
            ),
            RichMenuFunctionModel(
              index: 2,
              command: RichMenuFunctionModel.commandOpenUrl,
              bounds: RichMenuBoundsModel(x: 170, y: 0, width: 170, height: 170),
              commandArg: RichMenuCommandArgModel(url: 'https://uchat.com/invite/xR4tBv81'),
            ),
            RichMenuFunctionModel(
              index: 3,
              command: RichMenuFunctionModel.commandNone,
              bounds: RichMenuBoundsModel(x: 170, y: 170, width: 170, height: 170),
              commandArg: RichMenuCommandArgModel(),
            ),
          ],
        ),
      );
      when(() => serverRepository.getOaRichMenu(officialAccountId)).thenAnswer((_) async => expectedRichMenu);
      when(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu))
          .thenAnswer((_) async {});

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result, equals(expectedRichMenu));
      expect(result?.officialAccountId, equals(officialAccountId));
      expect(result?.publishMenu?.id, equals('697619f53dc39d9e678307db'));
      expect(result?.publishMenu?.container?.width, equals(340));
      expect(result?.publishMenu?.container?.height, equals(340));
      expect(result?.publishMenu?.actions?.length, equals(3));
      verify(() => serverRepository.getOaRichMenu(officialAccountId)).called(1);
      verify(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu)).called(1);
    });

    test(
        'Given valid officialAccountId, When call is executed, Then returns RichMenuModel with correct action commands',
        () async {
      // Given
      const officialAccountId = 'test_official_account_id';
      final params = OaRichMenuParams(officialAccountId: officialAccountId);
      final expectedRichMenu = RichMenuModel(
        officialAccountId: officialAccountId,
        publishMenu: RichMenuPublishModel(
          id: 'menu_id',
          container: RichMenuContainerModel(width: 400, height: 300),
          actions: [
            RichMenuFunctionModel(
              index: 1,
              command: RichMenuFunctionModel.commandSendMessage,
              bounds: RichMenuBoundsModel(x: 0, y: 0, width: 200, height: 150),
              commandArg: RichMenuCommandArgModel(message: 'Test message'),
            ),
            RichMenuFunctionModel(
              index: 2,
              command: RichMenuFunctionModel.commandOpenUrl,
              bounds: RichMenuBoundsModel(x: 200, y: 0, width: 200, height: 150),
              commandArg: RichMenuCommandArgModel(url: 'https://example.com'),
            ),
          ],
        ),
      );
      when(() => serverRepository.getOaRichMenu(officialAccountId)).thenAnswer((_) async => expectedRichMenu);
      when(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu))
          .thenAnswer((_) async {});

      // When
      final result = await systemUnderTest.call(params);

      // Then
      final actions = result?.publishMenu?.actions;
      expect(actions?[0].isSendMessage, isTrue);
      expect(actions?[0].isOpenUrl, isFalse);
      expect(actions?[0].isNone, isFalse);
      expect(actions?[0].commandArg?.message, equals('Test message'));

      expect(actions?[1].isOpenUrl, isTrue);
      expect(actions?[1].isSendMessage, isFalse);
      expect(actions?[1].isNone, isFalse);
      expect(actions?[1].commandArg?.url, equals('https://example.com'));

      verify(() => serverRepository.getOaRichMenu(officialAccountId)).called(1);
      verify(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu)).called(1);
    });

    test('Given valid officialAccountId, When call is executed, Then returns RichMenuModel with correct bounds',
        () async {
      // Given
      const officialAccountId = 'test_official_account_id';
      final params = OaRichMenuParams(officialAccountId: officialAccountId);
      final expectedRichMenu = RichMenuModel(
        officialAccountId: officialAccountId,
        publishMenu: RichMenuPublishModel(
          id: 'menu_id',
          container: RichMenuContainerModel(width: 340, height: 340),
          actions: [
            RichMenuFunctionModel(
              index: 1,
              command: RichMenuFunctionModel.commandSendMessage,
              bounds: RichMenuBoundsModel(x: 10, y: 20, width: 100, height: 50),
              commandArg: RichMenuCommandArgModel(message: 'Hello'),
            ),
          ],
        ),
      );
      when(() => serverRepository.getOaRichMenu(officialAccountId)).thenAnswer((_) async => expectedRichMenu);
      when(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu))
          .thenAnswer((_) async {});

      // When
      final result = await systemUnderTest.call(params);

      // Then
      final action = result?.publishMenu?.actions?.first;
      expect(action?.bounds?.x, equals(10));
      expect(action?.bounds?.y, equals(20));
      expect(action?.bounds?.width, equals(100));
      expect(action?.bounds?.height, equals(50));

      // Test convenience getters
      expect(action?.x, equals(10));
      expect(action?.y, equals(20));
      expect(action?.width, equals(100));
      expect(action?.height, equals(50));

      verify(() => serverRepository.getOaRichMenu(officialAccountId)).called(1);
      verify(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu)).called(1);
    });

    test(
        'Given valid officialAccountId with empty actions, When call is executed, Then returns RichMenuModel with hasPublishedMenu false',
        () async {
      // Given
      const officialAccountId = 'test_official_account_id';
      final params = OaRichMenuParams(officialAccountId: officialAccountId);
      final expectedRichMenu = RichMenuModel(
        officialAccountId: officialAccountId,
        publishMenu: RichMenuPublishModel(
          id: 'menu_id',
          container: RichMenuContainerModel(width: 400, height: 300),
          actions: [],
        ),
      );
      when(() => serverRepository.getOaRichMenu(officialAccountId)).thenAnswer((_) async => expectedRichMenu);
      when(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu))
          .thenAnswer((_) async {});

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result?.hasPublishedMenu, isFalse);
      verify(() => serverRepository.getOaRichMenu(officialAccountId)).called(1);
      verify(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu)).called(1);
    });

    test(
        'Given valid officialAccountId with null publishMenu, When call is executed, Then returns RichMenuModel with hasPublishedMenu false',
        () async {
      // Given
      const officialAccountId = 'test_official_account_id';
      final params = OaRichMenuParams(officialAccountId: officialAccountId);
      final expectedRichMenu = RichMenuModel(
        officialAccountId: officialAccountId,
        publishMenu: null,
      );
      when(() => serverRepository.getOaRichMenu(officialAccountId)).thenAnswer((_) async => expectedRichMenu);
      when(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu))
          .thenAnswer((_) async {});

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result?.hasPublishedMenu, isFalse);
      verify(() => serverRepository.getOaRichMenu(officialAccountId)).called(1);
      verify(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu)).called(1);
    });

    test(
        'Given valid officialAccountId with actions, When call is executed, Then returns RichMenuModel with hasPublishedMenu true',
        () async {
      // Given
      const officialAccountId = 'test_official_account_id';
      final params = OaRichMenuParams(officialAccountId: officialAccountId);
      final expectedRichMenu = RichMenuModel(
        officialAccountId: officialAccountId,
        publishMenu: RichMenuPublishModel(
          id: 'menu_id',
          container: RichMenuContainerModel(width: 400, height: 300),
          actions: [
            RichMenuFunctionModel(
              index: 1,
              command: RichMenuFunctionModel.commandNone,
              bounds: RichMenuBoundsModel(x: 0, y: 0, width: 100, height: 100),
            ),
          ],
        ),
      );
      when(() => serverRepository.getOaRichMenu(officialAccountId)).thenAnswer((_) async => expectedRichMenu);
      when(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu))
          .thenAnswer((_) async {});

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result?.hasPublishedMenu, isTrue);
      verify(() => serverRepository.getOaRichMenu(officialAccountId)).called(1);
      verify(() => contactLocalRepository.putContactRichMenu(officialAccountId, expectedRichMenu)).called(1);
    });

    test('Given server throws exception and local has rich menu, When call is executed, Then returns local rich menu',
        () async {
      // Given
      const officialAccountId = 'test_official_account_id';
      final params = OaRichMenuParams(officialAccountId: officialAccountId);
      final localRichMenu = RichMenuModel(
        officialAccountId: officialAccountId,
        publishMenu: RichMenuPublishModel(
          id: 'local_menu_id',
          container: RichMenuContainerModel(width: 300, height: 200),
          actions: [
            RichMenuFunctionModel(
              index: 1,
              command: RichMenuFunctionModel.commandNone,
              bounds: RichMenuBoundsModel(x: 0, y: 0, width: 100, height: 100),
            ),
          ],
        ),
      );
      final localContact = ContactEntity(id: officialAccountId, richMenu: localRichMenu);

      when(() => serverRepository.getOaRichMenu(officialAccountId)).thenThrow(Exception('Server error'));
      when(() => contactLocalRepository.getContact(officialAccountId)).thenAnswer((_) async => localContact);

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result, equals(localRichMenu));
      expect(result?.publishMenu?.id, equals('local_menu_id'));
      verify(() => serverRepository.getOaRichMenu(officialAccountId)).called(1);
      verify(() => contactLocalRepository.getContact(officialAccountId)).called(1);
      verifyNever(() => contactLocalRepository.putContactRichMenu(any(), any()));
    });

    test('Given server throws exception and local has no rich menu, When call is executed, Then returns null',
        () async {
      // Given
      const officialAccountId = 'test_official_account_id';
      final params = OaRichMenuParams(officialAccountId: officialAccountId);
      final localContact = ContactEntity(id: officialAccountId, richMenu: null);

      when(() => serverRepository.getOaRichMenu(officialAccountId)).thenThrow(Exception('Server error'));
      when(() => contactLocalRepository.getContact(officialAccountId)).thenAnswer((_) async => localContact);

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result, isNull);
      verify(() => serverRepository.getOaRichMenu(officialAccountId)).called(1);
      verify(() => contactLocalRepository.getContact(officialAccountId)).called(1);
      verifyNever(() => contactLocalRepository.putContactRichMenu(any(), any()));
    });

    test('Given server throws exception and local contact not found, When call is executed, Then returns null',
        () async {
      // Given
      const officialAccountId = 'test_official_account_id';
      final params = OaRichMenuParams(officialAccountId: officialAccountId);

      when(() => serverRepository.getOaRichMenu(officialAccountId)).thenThrow(Exception('Server error'));
      when(() => contactLocalRepository.getContact(officialAccountId)).thenAnswer((_) async => null);

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result, isNull);
      verify(() => serverRepository.getOaRichMenu(officialAccountId)).called(1);
      verify(() => contactLocalRepository.getContact(officialAccountId)).called(1);
      verifyNever(() => contactLocalRepository.putContactRichMenu(any(), any()));
    });
  });

  group('RichMenuModel.fromJson', () {
    test('Given valid JSON, When fromJson is called, Then returns correct RichMenuModel', () {
      // Given
      final json = {
        'officialAccountId': 'oa_123',
        'updatedAt': '2026-01-28T10:00:00.000Z',
        'publishedAt': '2026-01-28T12:00:00.000Z',
        'publishMenu': {
          '_id': '697619f53dc39d9e678307db',
          'container': {
            'width': 340,
            'height': 340,
            'imageId': 'uploaded-image-id',
          },
          'actions': [
            {
              'index': 1,
              'command': 'TEXT',
              'bounds': {
                'x': 0,
                'y': 0,
                'width': 170,
                'height': 340,
              },
              'commandArg': {
                'message': "Hello O.B, you're looking very handsome today!",
              },
            },
            {
              'index': 2,
              'command': 'LINK',
              'bounds': {
                'x': 170,
                'y': 0,
                'width': 170,
                'height': 170,
              },
              'commandArg': {
                'url': 'https://uchat.com/invite/xR4tBv81',
              },
            },
            {
              'index': 3,
              'command': 'NONE',
              'bounds': {
                'x': 170,
                'y': 170,
                'width': 170,
                'height': 170,
              },
              'commandArg': {},
            },
          ],
        },
      };

      // When
      final result = RichMenuModel.fromJson(json);

      // Then
      expect(result.officialAccountId, equals('oa_123'));
      expect(result.publishMenu?.id, equals('697619f53dc39d9e678307db'));
      expect(result.publishMenu?.container?.width, equals(340));
      expect(result.publishMenu?.container?.height, equals(340));
      expect(result.publishMenu?.container?.imageId, equals('uploaded-image-id'));

      final actions = result.publishMenu?.actions;
      expect(actions?.length, equals(3));

      // First action - TEXT
      expect(actions?[0].index, equals(1));
      expect(actions?[0].command, equals('TEXT'));
      expect(actions?[0].isSendMessage, isTrue);
      expect(actions?[0].bounds?.x, equals(0));
      expect(actions?[0].bounds?.y, equals(0));
      expect(actions?[0].bounds?.width, equals(170));
      expect(actions?[0].bounds?.height, equals(340));
      expect(actions?[0].commandArg?.message, equals("Hello O.B, you're looking very handsome today!"));

      // Second action - LINK
      expect(actions?[1].index, equals(2));
      expect(actions?[1].command, equals('LINK'));
      expect(actions?[1].isOpenUrl, isTrue);
      expect(actions?[1].bounds?.x, equals(170));
      expect(actions?[1].bounds?.y, equals(0));
      expect(actions?[1].bounds?.width, equals(170));
      expect(actions?[1].bounds?.height, equals(170));
      expect(actions?[1].commandArg?.url, equals('https://uchat.com/invite/xR4tBv81'));

      // Third action - NONE
      expect(actions?[2].index, equals(3));
      expect(actions?[2].command, equals('NONE'));
      expect(actions?[2].isNone, isTrue);
      expect(actions?[2].bounds?.x, equals(170));
      expect(actions?[2].bounds?.y, equals(170));
      expect(actions?[2].bounds?.width, equals(170));
      expect(actions?[2].bounds?.height, equals(170));
    });

    test('Given JSON with null publishMenu, When fromJson is called, Then returns RichMenuModel with null publishMenu',
        () {
      // Given
      final json = {
        'officialAccountId': 'oa_123',
        'publishMenu': null,
      };

      // When
      final result = RichMenuModel.fromJson(json);

      // Then
      expect(result.officialAccountId, equals('oa_123'));
      expect(result.publishMenu, isNull);
      expect(result.hasPublishedMenu, isFalse);
    });

    test('Given JSON with empty actions, When fromJson is called, Then returns RichMenuModel with empty actions', () {
      // Given
      final json = {
        'officialAccountId': 'oa_123',
        'publishMenu': {
          '_id': 'menu_id',
          'container': {
            'width': 400,
            'height': 300,
          },
          'actions': [],
        },
      };

      // When
      final result = RichMenuModel.fromJson(json);

      // Then
      expect(result.publishMenu?.actions, isEmpty);
      expect(result.hasPublishedMenu, isFalse);
    });
  });

  group('RichMenuModel.toJson', () {
    test('Given RichMenuModel, When toJson is called, Then returns correct JSON', () {
      // Given
      final richMenu = RichMenuModel(
        officialAccountId: 'oa_123',
        publishMenu: RichMenuPublishModel(
          id: '697619f53dc39d9e678307db',
          container: RichMenuContainerModel(
            width: 340,
            height: 340,
            imageId: 'uploaded-image-id',
          ),
          actions: [
            RichMenuFunctionModel(
              index: 1,
              command: RichMenuFunctionModel.commandSendMessage,
              bounds: RichMenuBoundsModel(x: 0, y: 0, width: 170, height: 340),
              commandArg: RichMenuCommandArgModel(message: 'Hello!'),
            ),
          ],
        ),
      );

      // When
      final result = richMenu.toJson();

      // Then
      expect(result['officialAccountId'], equals('oa_123'));
      expect(result['publishMenu']['_id'], equals('697619f53dc39d9e678307db'));
      expect(result['publishMenu']['container']['width'], equals(340));
      expect(result['publishMenu']['container']['height'], equals(340));
      expect(result['publishMenu']['container']['imageId'], equals('uploaded-image-id'));

      final actions = result['publishMenu']['actions'] as List;
      expect(actions.length, equals(1));
      expect(actions[0]['index'], equals(1));
      expect(actions[0]['command'], equals('TEXT'));
      expect(actions[0]['bounds']['x'], equals(0));
      expect(actions[0]['bounds']['y'], equals(0));
      expect(actions[0]['bounds']['width'], equals(170));
      expect(actions[0]['bounds']['height'], equals(340));
      expect(actions[0]['commandArg']['message'], equals('Hello!'));
    });
  });
}
