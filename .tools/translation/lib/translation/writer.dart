import 'package:translation/env/env.dart';
import 'package:translation/json/helpers.dart';
import 'package:translation/lang.dart';
import 'package:translation/logger.dart';

import 'key_model.dart';
import 'model.dart';
import 'parser.dart';

Future<void> writeTranslation(LangData lang) async {
  if (lang == originalTranslation) {
    return writeOriginalTranslation();
  }

  final projectLangPath = Env.projectLangPath;

  // Progress indicators
  logger.info('[${lang.name}] Prepare for write translation file...');

  // Load translation keys
  final translatedTexts = (await loadJsonToModel<TranslationModel>(lang.jsonDataFilePath)).data;

  // Process translations
  final Map<String, String> translations = {};

  for (final key in translatedTexts.keys) {
    final translatedText = translatedTexts[key]!;

    // Ignore when not translated.
    if (translatedText.translatedText == null) {
      continue;
    }

    // Ignore when key not exist in current.
    if (translatedText.isKeyExist == false) {
      continue;
    }

    // Ignore when key has only variable.
    if (translatedText.isOnlyVariable && translatedText.translatedText == key) {
      continue;
    }

    // Ignore when key has dart variable.
    if (translatedText.hasDartVariable) {
      continue;
    }

    translations[key] = translatedText.translatedText!;

    // print('Processing: $key => ${translatedText.translatedText}');
  }

  logger.success('[${lang.name}] Write translation file prepared!');

  logger.info('[${lang.name}] Writing translation file...');
  final translatePath = '$projectLangPath/${lang.filePath}';
  await writeTranslationFile(translatePath, translations, lang);
  logger.success('[${lang.name}] Write translation file completed! ($translatePath)');
}

Future<void> writeOriginalTranslation() async {
  final projectLangPath = Env.projectLangPath;

  final lang = originalTranslation;
  final translationKeys = (await loadJsonToModel<TranslationKeyModel>('./data/translation_keys.json')).data;

  // Process translations
  final Map<String, String> translations = {};

  for (final key in translationKeys.keys) {
    final translatedText = translationKeys[key]!;

    // Ignore when not translated.
    if (translatedText.translatedText == null) {
      continue;
    }

    // Ignore when key has only variable.
    if (translatedText.isOnlyVariable && translatedText.translatedText == key) {
      logger.err('[${lang.name}] isOnlyVariable');
      continue;
    }

    // Ignore when key has dart variable.
    if (translatedText.hasDartVariable) {
      logger.err('[${lang.name}] hasDartVariable');
      continue;
    }

    translations[key] = translatedText.translatedText!;

    // print('Processing: $key => ${translatedText.translatedText}');
  }

  logger.success('[${lang.name}] Write translation file prepared!');

  logger.info('[${lang.name}] Writing translation file...');
  final translatePath = '$projectLangPath/${lang.filePath}';
  await writeTranslationFile(translatePath, translations, lang);
  logger.success('[${lang.name}] Write translation file completed! ($translatePath)');
}
