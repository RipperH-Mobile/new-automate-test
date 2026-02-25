import 'package:flutter_test/flutter_test.dart';
import "package:uchat/core/event_bus/event_bus.dart";
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/append_or_update_many_message_to_state.dart';

void main() {
  setUpAll(() {
    // Initialize event bus once for all tests if needed
    try {
      // Try to access eventBus to see if it's initialized
      eventBus;
    } catch (_) {
      // If not initialized, initialize it
      initializeEventBus(enableTracking: false);
    }
  });

  group('* appendOrUpdateManyMessageToState', () {
    test('There are no message in chat list when add a message, it should be added', () {
      List<MessageCollection> incomingMessages = [
        MessageCollection(ref: '1'),
      ];
      List<MessageCollection> chatMessages = [];
      final actualMessages = appendOrUpdateManyMessageToState(incomingMessages, chatMessages, 0);

      expect(actualMessages, incomingMessages);
    });

    test('As a Local event, There are messages in chat list when add a new message, it should be added at 0 index', () {
      List<MessageCollection> incomingMessages = [MessageCollection(ref: '3')];
      List<MessageCollection> chatMessages = [MessageCollection(ref: '2'), MessageCollection(ref: '1')];
      final actualMessages = appendOrUpdateManyMessageToState(incomingMessages, chatMessages, 0);
      expect(actualMessages.length, equals(3));
      expect(actualMessages.map((m) => m.ref), orderedEquals(['3', '2', '1']));
    });

    test(
        'As a Local event, There are messages in chat list when add message between chat list message, it should be added correct index',
        () {
      List<MessageCollection> incomingMessages = [
        MessageCollection(ref: '2', sequence: 2, id: '2'),
      ];
      List<MessageCollection> chatMessages = [
        MessageCollection(ref: '3', sequence: 3, id: '3'),
        MessageCollection(ref: '1', sequence: 1, id: '1'),
      ];
      final actualMessages = appendOrUpdateManyMessageToState(incomingMessages, chatMessages, 0);
      expect(actualMessages.length, equals(3));
      expect(actualMessages.map((m) => m.ref), orderedEquals(['3', '2', '1']));
    });

    test('As a Local event, There are messages in chat list when add message, it should be added correct index', () {
      List<MessageCollection> incomingMessages = [
        MessageCollection(ref: '0', sequence: 0, id: '0'),
      ];
      List<MessageCollection> chatMessages = [
        MessageCollection(ref: '2', sequence: 2, id: '2'),
        MessageCollection(ref: '1', sequence: 1, id: '1'),
      ];
      final actualMessages = appendOrUpdateManyMessageToState(incomingMessages, chatMessages, 0);
      expect(actualMessages.length, equals(3));
      expect(actualMessages.map((m) => m.ref), orderedEquals(['2', '1', '0']));
    });

    test(
        'As a Local event, There are messages in chat list when add a duplicate message, it should be added correct index',
        () {
      List<MessageCollection> incomingMessages = [MessageCollection(ref: '2', sequence: 2, id: '2')];
      List<MessageCollection> chatMessages = [
        MessageCollection(ref: '4', sequence: 4, id: '4'),
        MessageCollection(ref: '3', sequence: 3, id: '3'),
        MessageCollection(ref: '2', sequence: 2, id: '2'),
        MessageCollection(ref: '1', sequence: 1, id: '1')
      ];
      final actualMessages = appendOrUpdateManyMessageToState(incomingMessages, chatMessages, 0);
      expect(actualMessages.length, equals(4));
      expect(actualMessages.map((m) => m.ref), orderedEquals(['4', '3', '2', '1']));
    });

    test('As a Local event, There are messages in chat list when add message, it should be added correct index', () {
      List<MessageCollection> incomingMessages = [MessageCollection(ref: '3', id: '3', sequence: 2)];
      List<MessageCollection> chatMessages = [
        MessageCollection(ref: '2', id: '2', sequence: 2),
        MessageCollection(ref: '1', id: '1', sequence: 2)
      ];
      final actualMessages = appendOrUpdateManyMessageToState(incomingMessages, chatMessages, 0);
      expect(actualMessages.length, equals(3));
      expect(actualMessages.map((m) => m.ref), orderedEquals(['3', '2', '1']));
    });

    test('Kew scenario', () {
      List<MessageCollection> incomingMessages = [
        MessageCollection(ref: '2', id: 'A', sequence: 2, message: 'CCCC CCCCCC'),
      ];
      List<MessageCollection> chatMessages = [
        MessageCollection(ref: '2', id: 'A', sequence: 2, message: 'AAAAAA AAAAA'),
        MessageCollection(ref: '1', id: 'B', sequence: 2, message: 'BBBBB BBBBBB'),
      ];
      final actualMessages = appendOrUpdateManyMessageToState(incomingMessages, chatMessages, 0);
      expect(actualMessages.map((m) => m.message), orderedEquals(['CCCC CCCCCC', 'BBBBB BBBBBB']));
      expect(actualMessages.length, equals(2));
      // expect(actualMessages.map((m) => m.ref), orderedEquals(['3', '2', '1']));
    });

    test('Mai scenario??', () {
      List<MessageCollection> incomingMessages = [
        MessageCollection(ref: '2', sequence: 5, id: '2'),
      ];
      List<MessageCollection> chatMessages = [
        MessageCollection(ref: '4', sequence: 4, id: '4'),
        MessageCollection(ref: '3', sequence: 3, id: '3'),
        MessageCollection(ref: '2', sequence: 2, id: '2'),
        MessageCollection(ref: '1', sequence: 1, id: '1')
      ];
      final actualMessages = appendOrUpdateManyMessageToState(incomingMessages, chatMessages, 0);
      expect(actualMessages.length, equals(4));
      expect(actualMessages.map((m) => m.ref), orderedEquals(['4', '3', '2', '1']));
    });
  });
}
