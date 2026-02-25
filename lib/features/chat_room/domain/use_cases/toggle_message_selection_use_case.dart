import 'package:collection/collection.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/use_cases/use_case.dart';

// TODO (refactor) Update MessageCollection to MessageEntity
class ToggleMessageSelectionParams {
  final MessageCollection message;
  final List<MessageCollection> selectedList;

  ToggleMessageSelectionParams({
    required this.message,
    required this.selectedList,
  });
}

class ToggleMessageSelectionUseCase extends SimpleUseCaseSync<List<MessageCollection>, ToggleMessageSelectionParams> {
  @override
  List<MessageCollection> call(ToggleMessageSelectionParams params) {
    final newSelectedList = List<MessageCollection>.from(params.selectedList);
    final containList = params.selectedList.where((e) => e.ref == params.message.ref);
    if ((params.message.files?.length ?? 0) > (containList.length) && params.message.type != MessageType.album) {
      // Not all images have been selected, then select it all
      // But Message type album doesn't care how many files is in the message because you can't select only some file in type album.
      for (final file in params.message.files!) {
        final checkDuplicate = containList.firstWhereOrNull((e) => e.files?.firstOrNull?.refFile == file.refFile);
        if (checkDuplicate == null) {
          final newMsg = params.message.copy()..files = [file];
          newSelectedList.add(newMsg);
        }
      }
    } else if (params.selectedList.contains(params.message) == true) {
      // All images are selected, toggle it out.
      newSelectedList.removeWhere((e) => e.ref == params.message.ref);
    } else {
      // Otherwise (Not image type), just add the message.
      newSelectedList.add(params.message);
    }
    return newSelectedList;
  }
}
