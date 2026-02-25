import 'package:translation/chatgpt/api.dart';
import 'package:translation/chatgpt/translation_service.dart';
import 'package:translation/env/env.dart';
import 'package:translation/json/helpers.dart';
import 'package:translation/lang.dart';
import 'package:translation/list/chunk.dart';
import 'package:translation/logger.dart';
import 'package:translation/map/sort.dart';
import 'package:translation/translation/util.dart';

import 'model.dart';

Future<void> translates(LangData lang) async {
  final translatedTexts = (await loadJsonToModel<TranslationModel>(lang.jsonDataFilePath)).data;

  final chatGptApi = ChatGptApi(apiKey: Env.openAIApiKey, model: 'gpt-4-turbo');
  final translationService = TranslationService(chatGPT: chatGptApi);

  final initialProgress = logger.progress('Initializing...');
  final List<String> translatableKeys = [];
  for (final key in translatedTexts.keys) {
    final currentText = translatedTexts[key]!;
    if (currentText.suggestedTranslations.isNotEmpty || currentText.translatedText?.isNotEmpty == true) {
      continue;
    }

    if (!isOnlyVariable(key)) {
      translatableKeys.add(key);
    }
  }

  initialProgress.complete('Initialized!');

  final allItemLength = translatableKeys.length;
  int processedLength = 0;
  for (final keys in translatableKeys.chunks(5)) {
    processedLength += keys.length;
    logger.info('($processedLength/$allItemLength) Translating:\n- ${keys.join(',\n - ')}');
    final result = await translationService.translateTexts(
      texts: keys,
      targetLanguage: lang.name,
    );

    for (final resultItemKey in result.keys) {
      if (translatedTexts.containsKey(resultItemKey)) {
        final resultItems = result[resultItemKey]!;
        for (final item in resultItems) {
          final value = item.replaceAllMapped(
            RegExp(r'\\\\n'),
            (match) => r'\n',
          );

          // print('$resultItemKey : $value');

          translatedTexts[resultItemKey]!.suggestedTranslations.add(value);
        }
      } else {
        logger.warn('The key $resultItemKey is not found in the translation keys');
      }
    }

    await saveMapToJson(
      translatedTexts,
      lang.jsonDataFilePath,
      pretty: true,
    );
  }

  logger.info('Translation completed!');

  final finalizeProgress = logger.progress('Finalizing...');
  for (final key in translatedTexts.keys) {
    final translatedText = translatedTexts[key]!;

    if (translatedText.translatedText == null && translatedText.suggestedTranslations.isNotEmpty) {
      translatedText.translatedText = translatedText.suggestedTranslations.first;
    }
  }

  await saveMapToJson(
    translatedTexts.sortedByKey(),
    lang.jsonDataFilePath,
    pretty: true,
  );

  finalizeProgress.complete('Finalized!');
}

Future<void> translateOnePerTime(LangData lang) async {
  final translatedTexts = (await loadJsonToModel<TranslationModel>(lang.jsonDataFilePath)).data;

  final chatGptApi = ChatGptApi(apiKey: Env.openAIApiKey, model: 'gpt-4-turbo');
  final translationService = TranslationService(chatGPT: chatGptApi);

  logger.info('[${lang.name}] Translate process initializing...');

  final List<String> translatableModels = [];
  for (final key in translatedTexts.keys) {
    final currentTranslatableModel = translatedTexts[key]!;
    if (currentTranslatableModel.suggestedTranslations.isNotEmpty ||
        currentTranslatableModel.translatedText?.isNotEmpty == true) {
      continue;
    }

    if (!currentTranslatableModel.isKeyExist) {
      continue;
    }

    if (currentTranslatableModel.isVerified) {
      continue;
    }

    if (!currentTranslatableModel.isOnlyVariable) {
      translatableModels.add(key);
    }
  }

  logger.success('[${lang.name}] Translate process initialized!');

  final allItemLength = translatableModels.length;

  int processedLength = 0;
  try {
    for (final key in translatableModels) {
      processedLength += 1;

      final currentTranslatableModel = translatedTexts[key]!;

      // logger.info('[${lang.name}] ($processedLength/$allItemLength) Translating: <$key>');
      final result = await translationService.translate(currentTranslatableModel.key, lang.name);

      final value = result.replaceAllMapped(
        RegExp(r'\\\\n'),
        (match) => r'\n',
      );

      logger.success(
        '[${lang.name}] ($processedLength/$allItemLength) Translated:\n${currentTranslatableModel.key}\n$value\n',
      );

      translatedTexts[key]!.suggestedTranslations.add(value);
    }

    logger.success('[${lang.name}] Translation completed!');

    logger.info('[${lang.name}] Finalizing...');
    for (final key in translatedTexts.keys) {
      final translatedText = translatedTexts[key]!;

      if (translatedText.translatedText == null && translatedText.suggestedTranslations.isNotEmpty) {
        translatedText.translatedText = translatedText.suggestedTranslations.first;
      }
    }
  } catch (e) {
    logger.err('[${lang.name}] Error: $e');
  } finally {
    await saveMapToJson(
      translatedTexts.sortedByKey(),
      lang.jsonDataFilePath,
      pretty: true,
    );
    logger.success('[${lang.name}] Saved lang file!');
  }
}
