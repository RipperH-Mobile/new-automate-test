import 'logger.dart';

class LangData {
  String name;
  String filePath;
  String jsonDataFilePath;
  String langConstName;

  LangData({
    required this.name,
    required this.filePath,
    required this.jsonDataFilePath,
    required this.langConstName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LangData && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

final originalTranslation = LangData(
  name: 'English (United States)',
  filePath: 'en_us.g.dart',
  jsonDataFilePath: './data/en_us.json',
  langConstName: 'enUs',
);

final supportedLanguages = {
  'English (United States)': {
    'name': 'English (United States)',
    'filePath': 'en_us.g.dart',
    'jsonData': './data/en_us.json',
    'langFunctionName': 'enUs',
  },
  'Thai': {
    'name': 'Thai',
    'filePath': 'th_th.g.dart',
    'jsonData': './data/th_th.json',
    'langFunctionName': 'thTh',
  },
  'Chinese (Traditional)': {
    'name': 'Chinese (Traditional)',
    'filePath': 'zh_tw.g.dart',
    'jsonData': './data/zh_tw.json',
    'langFunctionName': 'zhTw',
  },
  'Chinese (Simplified)': {
    'name': 'Chinese (Simplified)',
    'filePath': 'zh_cn.g.dart',
    'jsonData': './data/zh_cn.json',
    'langFunctionName': 'zhCn',
  },
  'Japanese': {
    'name': 'Japanese',
    'filePath': 'ja_jp.g.dart',
    'jsonData': './data/ja_jp.json',
    'langFunctionName': 'jaJp',
  },
  'Lao': {
    'name': 'Lao',
    'filePath': 'lo_la.g.dart',
    'jsonData': './data/lo_la.json',
    'langFunctionName': 'loLa',
  },
};

LangData chooseLang() {
  final lang = logger.chooseOne(
    'Select option:',
    choices: supportedLanguages.keys.toList(),
    defaultValue: supportedLanguages.keys.toList().first,
  );
  if (!supportedLanguages.containsKey(lang)) {
    throw Exception('Language $lang is not supported');
  }

  final currentLang = supportedLanguages[lang]!;

  return LangData(
    name: currentLang['name']!,
    filePath: currentLang['filePath']!,
    jsonDataFilePath: currentLang['jsonData']!,
    langConstName: currentLang['langFunctionName']!,
  );
}
