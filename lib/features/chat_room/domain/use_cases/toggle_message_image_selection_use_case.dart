import 'package:collection/collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/use_cases/use_case.dart';

// TODO (refactor) Update MessageCollection to MessageEntity
class ToggleMessageImageSelectionParams {
  final MessageFileModel file;
  final MessageCollection message;
  final List<MessageCollection> selectedList;

  ToggleMessageImageSelectionParams({
    required this.file,
    required this.message,
    required this.selectedList,
  });
}

class ToggleMessageImageSelectionUseCase
    extends SimpleUseCaseSync<List<MessageCollection>, ToggleMessageImageSelectionParams> {
  @override
  List<MessageCollection> call(ToggleMessageImageSelectionParams params) {
    final newSelectedList = List<MessageCollection>.from(params.selectedList);
    final index = newSelectedList.indexWhere((e) => e.files?.firstOrNull?.refFile == params.file.refFile);
    if (index >= 0) {
      newSelectedList.removeAt(index);
    } else {
      final newMsg = params.message.copy()..files = [params.file];
      newSelectedList.add(newMsg);
    }
    return newSelectedList;
  }
}
