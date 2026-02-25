import 'package:super_clipboard/super_clipboard.dart';
import 'package:uchat/core/exceptions/unsupported_format_exception.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/get_images_from_clipboard_util.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetImagesFromClipboardUseCase extends SimpleUseCase<List<ClipboardDataReader>, NoParams> {
  @override
  Future<List<ClipboardDataReader>> call(NoParams params) async {
    final clipboard = SystemClipboard.instance;
    if (clipboard == null) {
      return [];
    }

    final reader = await clipboard.read();
    final fileLength = reader.items.length >= 10 ? 10 : reader.items.length;
    final fileItems = reader.items.take(fileLength).toList();
    final supportedItems = fileItems.where((e) => getAvailableFormats(e) != null).toList();

    if (fileItems.isNotEmpty && supportedItems.isEmpty) {
      throw UnsupportedFormatException();
    }

    return supportedItems;
  }
}
