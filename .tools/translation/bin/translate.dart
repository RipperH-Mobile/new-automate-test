import 'package:translation/lang.dart';
import 'package:translation/logger.dart';
import 'package:translation/translation/key_mapper.dart';
import 'package:translation/translation/scanner.dart';
import 'package:translation/translation/translate.dart';
import 'package:translation/translation/writer.dart';

void main() async {
  logger.info('Scanning translation keys...');
  await scanTranslationKey();

  final futures = <Future<void>>[];

  for (final supportedLangKey in supportedLanguages.keys) {
    futures.add(runTranslate(supportedLangKey));
  }

  try {
    await Future.wait(futures);
    logger.info('Translate complete...');
  } catch (e, stackTrace) {
    logger.err('Error: $e');
    print(stackTrace);
  }
}

Future<void> runTranslate(String supportedLangKey) async {
  logger.info('[$supportedLangKey] Start translating...');

  final currentSupportLang = supportedLanguages[supportedLangKey]!;
  final lang = LangData(
    name: currentSupportLang['name']!,
    filePath: currentSupportLang['filePath']!,
    jsonDataFilePath: currentSupportLang['jsonData']!,
    langConstName: currentSupportLang['langFunctionName']!,
  );

  if (lang != originalTranslation) {
    await readExistingTranslations(lang);
    await translateOnePerTime(lang);
  }
  await writeTranslation(lang);
}
