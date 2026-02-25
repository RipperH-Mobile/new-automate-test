import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/domain/use_cases/toggle_message_selection_use_case.dart';

void main() {
  group('Message selection in message list', () {
    setUpAll(() {
      GetIt.I.registerFactory<ToggleMessageSelectionUseCase>(() => ToggleMessageSelectionUseCase());
    });

    test('When selected list is empty and message is selected, Should add the selected message to the list.', () {
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.text,
        accountId: 'account-1',
        message: 'aaa',
        sequence: 1,
      );
      final result = GetIt.I<ToggleMessageSelectionUseCase>().call(ToggleMessageSelectionParams(
        message: message1,
        selectedList: [],
      ));
      expect(result, [message1]);
    });

    test(
        'When selected list has 1 message that message is selected again, Should remove the selected message from the list.',
        () {
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.text,
        accountId: 'account-1',
        message: 'aaa',
        sequence: 1,
      );
      final result = GetIt.I<ToggleMessageSelectionUseCase>().call(ToggleMessageSelectionParams(
        message: message1,
        selectedList: [message1],
      ));
      expect(result, []);
    });

    test('When selected list has 1 message new message is selected, Should add the selected message to the list.', () {
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.text,
        accountId: 'account-1',
        message: 'aaa',
        sequence: 1,
      );
      final message2 = MessageCollection(
        id: '2',
        ref: 'ref-2',
        type: MessageType.text,
        accountId: 'account-2',
        message: 'bbb',
        sequence: 2,
      );
      final result = GetIt.I<ToggleMessageSelectionUseCase>().call(ToggleMessageSelectionParams(
        message: message2,
        selectedList: [message1],
      ));
      expect(result, [message1, message2]);
    });

    test('When select message type album with 1 file, Should add the selected message to the list.', () {
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.album,
        accountId: 'account-1',
        files: [
          MessageFileModel(
            id: 'message-1-file-1',
            refFile: 'message-1-file-1',
            messageId: '1',
          )
        ],
        sequence: 1,
      );
      final result = GetIt.I<ToggleMessageSelectionUseCase>().call(ToggleMessageSelectionParams(
        message: message1,
        selectedList: [],
      ));
      expect(result, [message1]);
    });

    test('When select message type album with 3 file, Should add the selected message to the list.', () {
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.album,
        accountId: 'account-1',
        files: [
          MessageFileModel(
            id: 'message-1-file-1',
            refFile: 'message-1-file-1',
            messageId: '1',
          ),
          MessageFileModel(
            id: 'message-1-file-2',
            refFile: 'message-1-file-2',
            messageId: '1',
          ),
          MessageFileModel(
            id: 'message-1-file-3',
            refFile: 'message-1-file-3',
            messageId: '1',
          ),
        ],
        sequence: 1,
      );
      final result = GetIt.I<ToggleMessageSelectionUseCase>().call(ToggleMessageSelectionParams(
        message: message1,
        selectedList: [],
      ));
      expect(result, [message1]);
    });

    test('When select message type image with 1 file, Should add the selected message to the list.', () {
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [
          MessageFileModel(
            id: 'message-1-file-1',
            refFile: 'message-1-file-1',
            messageId: '1',
          )
        ],
        sequence: 1,
      );
      final result = GetIt.I<ToggleMessageSelectionUseCase>().call(ToggleMessageSelectionParams(
        message: message1,
        selectedList: [],
      ));
      expect(result, [message1]);
    });

    test('When select message type image with 3 file, Should add 3 selected message to the list.', () {
      final file1 = MessageFileModel(
        id: 'message-1-file-1',
        refFile: 'message-1-file-1',
        messageId: '1',
      );
      final file2 = MessageFileModel(
        id: 'message-1-file-2',
        refFile: 'message-1-file-2',
        messageId: '1',
      );
      final file3 = MessageFileModel(
        id: 'message-1-file-3',
        refFile: 'message-1-file-3',
        messageId: '1',
      );
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file1, file2, file3],
        sequence: 1,
      );

      final result = GetIt.I<ToggleMessageSelectionUseCase>().call(ToggleMessageSelectionParams(
        message: message1,
        selectedList: [],
      ));

      final result1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file1],
        sequence: 1,
      );
      final result2 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file2],
        sequence: 1,
      );
      final result3 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file3],
        sequence: 1,
      );
      expect(result, [result1, result2, result3]);
    });

    test(
        'When select message type image with 3 file but 1 file of that message is already selected, Should add 2 unselected file to the list.',
        () {
      final file1 = MessageFileModel(
        id: 'message-1-file-1',
        refFile: 'message-1-file-1',
        messageId: '1',
      );
      final file2 = MessageFileModel(
        id: 'message-1-file-2',
        refFile: 'message-1-file-2',
        messageId: '1',
      );
      final file3 = MessageFileModel(
        id: 'message-1-file-3',
        refFile: 'message-1-file-3',
        messageId: '1',
      );
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file1, file2, file3],
        sequence: 1,
      );
      final selectedMessage = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file1],
        sequence: 1,
      );

      final result = GetIt.I<ToggleMessageSelectionUseCase>().call(ToggleMessageSelectionParams(
        message: message1,
        selectedList: [selectedMessage],
      ));

      final result1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file1],
        sequence: 1,
      );
      final result2 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file2],
        sequence: 1,
      );
      final result3 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file3],
        sequence: 1,
      );
      expect(result, [result1, result2, result3]);
    });

    test(
        'When select message type image with 3 file but all 3 file is already selected, Should remove all 3 selected file from the list.',
        () {
      final file1 = MessageFileModel(
        id: 'message-1-file-1',
        refFile: 'message-1-file-1',
        messageId: '1',
      );
      final file2 = MessageFileModel(
        id: 'message-1-file-2',
        refFile: 'message-1-file-2',
        messageId: '1',
      );
      final file3 = MessageFileModel(
        id: 'message-1-file-3',
        refFile: 'message-1-file-3',
        messageId: '1',
      );
      final messageInput = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file1, file2, file3],
        sequence: 1,
      );
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file1],
        sequence: 1,
      );
      final message2 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file2],
        sequence: 1,
      );
      final message3 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [file3],
        sequence: 1,
      );

      final result = GetIt.I<ToggleMessageSelectionUseCase>().call(ToggleMessageSelectionParams(
        message: messageInput,
        selectedList: [message1, message2, message3],
      ));

      expect(result, []);
    });
  });
}
