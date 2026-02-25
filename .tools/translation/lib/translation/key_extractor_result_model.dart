import 'key_extractor.dart';

class KeyExtractorResult {
  final int trCount;
  final ScanTranslationKeys translationKeys;

  KeyExtractorResult({
    required this.trCount,
    required this.translationKeys,
  });
}