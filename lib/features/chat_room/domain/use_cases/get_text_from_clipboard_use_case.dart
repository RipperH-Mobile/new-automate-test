import 'package:super_clipboard/super_clipboard.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetTextFromClipboardUseCase extends SimpleUseCase<bool, NoParams> {
  @override
  Future<bool> call(NoParams params) async {
    final clipboard = SystemClipboard.instance;
    if (clipboard == null) {
      return false;
    }

    final reader = await clipboard.read();

    return reader.items.any((item) => item.canProvide(Formats.plainText));
  }
}
