import 'package:translation/json/cast.dart';
import 'package:translation/translation/util.dart' as util;

class TranslationKeyContextModel {
  final String key;
  final String? context;

  TranslationKeyContextModel({
    required this.key,
    this.context,
  });
}

class TranslationKeyModel implements JsonSerializer<TranslationKeyModel> {
  String key;
  String? context;
  String? translatedText;
  DateTime createdAt;
  List<TranslationKeyFileModel> files;

  TranslationKeyModel({
    required this.key,
    this.context,
    this.translatedText,
    this.files = const [],
    required this.createdAt,
  });

  factory TranslationKeyModel.fromJson(Map<String, dynamic> json) {
    final filesData = (json['files'] ?? []);
    final files = filesData.map<TranslationKeyFileModel>((file) => TranslationKeyFileModel.fromJson(file)).toList();

    return TranslationKeyModel(
      files: files,
      key: json['key'] ?? '',
      context: json['context'],
      translatedText: json['translatedText'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  bool get isOnlyVariable => util.isOnlyVariable(key);

  bool get hasDartVariable => util.hasDartVariable(key);

  @override
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'context': context,
      'translatedText': translatedText,
      'files': files,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class TranslationKeyFileModel implements JsonSerializer<TranslationKeyFileModel> {
  final String name;
  final int start;
  final int end;
  final int line;
  final DateTime createdAt;

  TranslationKeyFileModel({
    this.name = '',
    this.start = 0,
    this.end = 0,
    this.line = 0,
    required this.createdAt,
  });

  factory TranslationKeyFileModel.fromJson(Map<String, dynamic> json) {
    return TranslationKeyFileModel(
      name: json['name'],
      start: json['start'],
      end: json['end'],
      line: json['line'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'start': start,
      'end': end,
      'line': line,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TranslationKeyFileModel &&
        other.name == name &&
        other.start == start &&
        other.end == end &&
        other.line == line;
  }

  @override
  int get hashCode => Object.hash(name, start, end, line);
}

typedef TranslationKeyCollection = Map<String, TranslationKeyModel>;
