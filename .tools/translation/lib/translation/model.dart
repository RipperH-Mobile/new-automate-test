import 'package:translation/json/cast.dart';
import 'package:translation/translation/util.dart' as util;

class TranslationModel implements JsonSerializer<TranslationModel> {
  bool isKeyExist;
  bool isVerified = false;
  String? translatedText;
  String key;
  String? context;

  List<String> suggestedTranslations;
  DateTime createdAt;

  TranslationModel({
    required this.key,
    required this.createdAt,
    this.context,
    this.translatedText,
    this.suggestedTranslations = const [],
    this.isKeyExist = false,
    this.isVerified = false,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      key: json['key'],
      context: json['context'],
      translatedText: json['translatedText'],
      suggestedTranslations: List<String>.from(json['suggestedTranslations'] ?? '[]'),
      isKeyExist: json['isKeyExist'] ?? false,
      isVerified: json['isVerified'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  bool get isOnlyVariable => util.isOnlyVariable(key);

  bool get hasDartVariable => util.hasDartVariable(key);

  bool get canGetProjectTranslated {
    return !isVerified && (translatedText == null || translatedText?.isEmpty == true);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'context': context,
      'translatedText': translatedText,
      'suggestedTranslations': suggestedTranslations,
      'isKeyExist': isKeyExist,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

typedef TranslationCollection = Map<String, TranslationModel>;
