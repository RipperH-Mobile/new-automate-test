import 'package:translation/env/env.dart';
import 'package:translation/lang.dart';
import 'package:translation/logger.dart';
import 'package:translation/translation/key_mapper.dart';

final projectLangPath = Env.projectLangPath;

void main() async {
  for (final supportedLangKey in supportedLanguages.keys) {
    logger.info('Translate: $supportedLangKey');

    final currentSupportLang = supportedLanguages[supportedLangKey]!;
    final lang = LangData(
      name: currentSupportLang['name']!,
      filePath: currentSupportLang['filePath']!,
      jsonDataFilePath: currentSupportLang['jsonData']!,
      langConstName: currentSupportLang['langFunctionName']!,
    );

    await readExistingTranslations(lang);
  }
}
