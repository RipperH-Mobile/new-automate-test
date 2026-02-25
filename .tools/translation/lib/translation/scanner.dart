import 'package:translation/env/env.dart';
import 'package:translation/file/scan.dart';
import 'package:translation/json/helpers.dart';
import 'package:translation/logger.dart';
import 'package:translation/map/diff.dart';
import 'package:translation/map/sort.dart';

import 'key_extractor.dart';
import 'key_model.dart';

Future<void> scanTranslationKey() async {
  final projectPath = Env.projectPath;

  // Load translation keys
  final loadOldKeyProgress = logger.progress('Loading old data...');
  final oldDataKeys = await loadJsonToModel<TranslationKeyModel>('./data/translation_keys.json');
  loadOldKeyProgress.complete('Loading old data, Loaded!');

  logger.info('==> Found <${oldDataKeys.data.keys.length}> old data keys.', style: debugInfoStyle);

  // Scan process
  final scanningProgress = logger.progress('Scan translation key, Scanning...');

  final oldTranslationKeys = oldDataKeys.data.sortedByKey();

  // Scan new translation keys
  final files = await scanDirectory(projectPath);
  final ScanTranslationKeys newTranslationKeys = {};

  int allKeyCount = 0;
  int allTrCount = 0;
  await for (final file in files) {
    // logger.info('==> Scan file: ${file.path}', style: debugInfoStyle);
    final result = await TranslationKeyExtractor.processFile(file.path);
    if (result == null) {
      continue;
    }

    if (result.translationKeys.keys.isEmpty) {
      // logger.info('==> Scan file: ${file.path}, completed! (Key not found)', style: greenStyle);
      continue;
    }

    // logger.info('====================> Scanned file: ${file.path.replaceAll('../../', '')}', style: debugInfoStyle);
    allKeyCount += result.translationKeys.keys.length;
    allTrCount += result.trCount;

    for (final scannedTranslationKey in result.translationKeys.keys) {
      if (newTranslationKeys.containsKey(scannedTranslationKey)) {
        // print('==> Found duplicate key: $scannedTranslationKey');
        newTranslationKeys[scannedTranslationKey]!.files.addAll(result.translationKeys[scannedTranslationKey]!.files);
        newTranslationKeys[scannedTranslationKey]!.key = result.translationKeys[scannedTranslationKey]!.key;
        newTranslationKeys[scannedTranslationKey]!.context = result.translationKeys[scannedTranslationKey]!.context;
        continue;
      }

      newTranslationKeys[scannedTranslationKey] ??= result.translationKeys[scannedTranslationKey]!;
    }

    // logger.info('==> Scan file: ${file.path}, completed!');
  }

  scanningProgress.complete('Scan translation key, Scanned!');

  newTranslationKeys.sortedByKey();
  logger.info('==> Found <${newTranslationKeys.keys.length}> unique translation keys!', style: greenStyle);
  logger.info('==> Found <$allKeyCount> all translation keys!', style: debugInfoStyle);
  logger.info('==> Found <$allTrCount> all translation count!', style: debugInfoStyle);

  //
  final diffData = oldTranslationKeys.diffWith(newTranslationKeys);

  logger.info('====================', style: debugInfoStyle);
  logger.info('==> Found <${diffData.newKeys.length}> new key!', style: greenStyle);
  for (final key in diffData.newKeys) {
    logger.info('==> New key: $key', style: debugInfoStyle);
  }

  logger.info('====================', style: debugInfoStyle);
  logger.info('==> Found <${diffData.removedKeys.length}> remove key!', style: greenStyle);
  for (final key in diffData.removedKeys) {
    logger.info('==> Removed key: $key', style: debugInfoStyle);
  }

  logger.info('====================', style: debugInfoStyle);
  logger.info('==> Found <${diffData.commonKeys.length}> common key!', style: greenStyle);

  if (diffData.newKeys.isEmpty && diffData.removedKeys.isEmpty) {
    logger.info('==> No new or removed keys found!', style: debugInfoStyle);
    return;
  }

  final ScanTranslationKeys translationKeys = {};

  for (final key in newTranslationKeys.keys) {
    if (oldTranslationKeys.containsKey(key)) {
      translationKeys[key] = oldTranslationKeys[key]!;
      translationKeys[key]!.key = newTranslationKeys[key]!.key;
      translationKeys[key]!.context = newTranslationKeys[key]!.context;
      continue;
    }

    translationKeys[key] = newTranslationKeys[key]!;
  }

  logger.info('====================', style: debugInfoStyle);
  logger.info('==> Processed <${translationKeys.keys.length}> keys!', style: greenStyle);

  // Save process
  logger.info('====================', style: debugInfoStyle);

  logger.info('Saving translation key file...');
  await saveMapToJson(translationKeys.sortedByKey(), 'data/translation_keys.json', pretty: true);
  logger.info('Saved translation key file!');
}
