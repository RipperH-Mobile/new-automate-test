import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.local')
abstract class Env {
  @EnviedField(varName: 'OPENAI_API_KEY')
  static const String openAIApiKey = _Env.openAIApiKey;

  @EnviedField(varName: 'OPENAI_ASSISTANT_ID')
  static const String openAIAssistantId = _Env.openAIAssistantId;

  @EnviedField(varName: 'PROJECT_PATH')
  static const String projectPath = _Env.projectPath;

  @EnviedField(varName: 'PROJECT_LANG_PATH')
  static const String projectLangPath = _Env.projectLangPath;

  @EnviedField(varName: 'DEBUG')
  static const bool isDebug = _Env.isDebug;
}
