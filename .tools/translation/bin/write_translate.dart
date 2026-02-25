import 'package:translation/lang.dart';
import 'package:translation/logger.dart';
import 'package:translation/translation/scanner.dart';
import 'package:translation/translation/writer.dart';

void main() async {
  logger.info('Scanning translation keys...');
  await scanTranslationKey();

  final futures = <Future<void>>[];

  for (final supportedLangKey in supportedLanguages.keys) {
    futures.add(runWriteTranslate(supportedLangKey));
  }

  try {
    await Future.wait(futures);
    logger.info('Write translate complete...');
  } catch (e) {
    logger.err('Error: $e');
  }
}

Future<void> runWriteTranslate(String supportedLangKey) async {
  logger.info('[$supportedLangKey] Start write translating...');

  final currentSupportLang = supportedLanguages[supportedLangKey]!;
  final lang = LangData(
    name: currentSupportLang['name']!,
    filePath: currentSupportLang['filePath']!,
    jsonDataFilePath: currentSupportLang['jsonData']!,
    langConstName: currentSupportLang['langFunctionName']!,
  );

  await writeTranslation(lang);
}
