import 'package:translation/env/env.dart';
import 'package:translation/json/helpers.dart';
import 'package:translation/lang.dart';
import 'package:translation/logger.dart';
import 'package:translation/map/sort.dart';
import 'package:translation/translation/key_model.dart';
import 'package:translation/translation/model.dart';
import 'package:translation/translation/parser.dart';

final projectLangPath = Env.projectLangPath;

Future<void> readExistingTranslations(LangData lang) async {
  // Progress indicators
  logger.info('[${lang.name}] Read existing translation initializing...');

  // Load translation keys
  final translationKeys = (await loadJsonToModel<TranslationKeyModel>('./data/translation_keys.json')).data;
  final translationModels = (await loadJsonToModel<TranslationModel>(lang.jsonDataFilePath)).data;

  final projectTranslationModelsFromFile = parseTranslationFile('$projectLangPath/${lang.filePath}');
  final projectTranslationModels = projectTranslationModelsFromFile.sortedByKey();

  logger.success('[${lang.name}] Read existing translation initialized!');

  logger.info('[${lang.name}] Translation Initializing...');

  // First update key exist in require translation text.
  for (final key in translationModels.keys) {
    translationModels[key]!.isKeyExist = translationKeys.containsKey(key);

    if (translationKeys.containsKey(key)) {
      translationModels[key]!.key = translationKeys[key]!.key;
      translationModels[key]!.context = translationKeys[key]!.context;
    }
  }

  // Process new translation.
  for (final key in translationKeys.keys) {
    final currentKey = translationKeys[key]!;

    final translationModel = translationModels.containsKey(key)
        ? translationModels[key]!
        : TranslationModel(key: currentKey.key, context: currentKey.context, createdAt: DateTime.now());

    // Force update key and context.
    translationModel.key = currentKey.key;
    translationModel.context = currentKey.context;

    // Update key exist in require translation text.
    translationModel.isKeyExist = translationKeys.containsKey(key);

    // Replace with project translation if exist, and not verified.
    if (projectTranslationModels.containsKey(key) && translationModel.canGetProjectTranslated) {
      translationModel.translatedText = projectTranslationModels[key]!.translatedText;
    }

    // Update translation model.
    translationModels[key] = translationModel;
  }

  logger.info('[${lang.name}] Saving to file (${lang.jsonDataFilePath})...');
  await saveMapToJson(translationModels.sortedByKey(), lang.jsonDataFilePath, pretty: true);
  logger.success('[${lang.name}] Saved to file...');

  logger.success('[${lang.name}] Translation Initialized!');
}
