import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/domain/use_cases/toggle_message_image_selection_use_case.dart';

void main() {
  group('Image selection in message list', () {
    setUpAll(() {
      GetIt.I.registerFactory<ToggleMessageImageSelectionUseCase>(() => ToggleMessageImageSelectionUseCase());
    });

    test('When selected list is empty and image is selected, Should add the selected image to the list.', () {
      final image1 = MessageFileModel(
        id: 'message-1-file-1',
        refFile: 'message-1-file-1',
        messageId: '1',
      );
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [image1],
        sequence: 1,
      );
      final result = GetIt.I<ToggleMessageImageSelectionUseCase>().call(ToggleMessageImageSelectionParams(
        file: image1,
        message: message1,
        selectedList: [],
      ));
      expect(result, [message1]);
    });

    test(
        'When selected list has 1 selected image and that image is selected again, should remove the selected image from the list',
        () {
      final image1 = MessageFileModel(
        id: 'message-1-file-1',
        refFile: 'message-1-file-1',
        messageId: '1',
      );
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [image1],
        sequence: 1,
      );
      final result = GetIt.I<ToggleMessageImageSelectionUseCase>().call(ToggleMessageImageSelectionParams(
        file: image1,
        message: message1,
        selectedList: [message1],
      ));
      expect(result, []);
    });

    test(
        'When selected list is empty and last image in a message is selected, Should add the selected image to the list.',
        () {
      final image1 = MessageFileModel(
        id: 'message-1-file-1',
        refFile: 'message-1-file-1',
        messageId: '1',
      );
      final image2 = MessageFileModel(
        id: 'message-1-file-2',
        refFile: 'message-1-file-2',
        messageId: '1',
      );
      final image3 = MessageFileModel(
        id: 'message-1-file-3',
        refFile: 'message-1-file-3',
        messageId: '1',
      );
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [image1, image2, image3],
        sequence: 1,
      );

      final result = GetIt.I<ToggleMessageImageSelectionUseCase>().call(ToggleMessageImageSelectionParams(
        file: image3,
        message: message1,
        selectedList: [],
      ));

      final selectedResult = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [image3],
        sequence: 1,
      );
      expect(result, [selectedResult]);
    });

    test(
        'When selected list has 1 selected image and that last image in a message is selected again, should remove the selected image from the list',
        () {
      final image1 = MessageFileModel(
        id: 'message-1-file-1',
        refFile: 'message-1-file-1',
        messageId: '1',
      );
      final image2 = MessageFileModel(
        id: 'message-1-file-2',
        refFile: 'message-1-file-2',
        messageId: '1',
      );
      final image3 = MessageFileModel(
        id: 'message-1-file-3',
        refFile: 'message-1-file-3',
        messageId: '1',
      );
      final message1 = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [image1, image2, image3],
        sequence: 1,
      );
      final selectedImage = MessageCollection(
        id: '1',
        ref: 'ref-1',
        type: MessageType.image,
        accountId: 'account-1',
        files: [image3],
        sequence: 1,
      );

      final result = GetIt.I<ToggleMessageImageSelectionUseCase>().call(ToggleMessageImageSelectionParams(
        file: image3,
        message: message1,
        selectedList: [selectedImage],
      ));

      expect(result, []);
    });
  });
}
