import 'dart:convert';

import 'package:translation/chatgpt/api.dart';
import 'package:translation/env/env.dart';
import 'package:translation/logger.dart';

class TranslationService {
  final ChatGptApi chatGPT;
  final List<Map<String, String>> conversationHistory = [];
  final Map<String, String> threadIds = {};

  TranslationService({required this.chatGPT});

  Future<Map<String, List<String>>> translateTexts({
    required List<String> texts,
    required String targetLanguage,
  }) async {
    try {
      final textMapping = Map.fromEntries(
        texts.asMap().entries.map((entry) => MapEntry('text${entry.key + 1}', entry.value)),
      );

      final inputJson = jsonEncode(textMapping);

      final systemPrompt = '''
You are a professional translator. Please translate the given texts to $targetLanguage.
This is translation for application (Chat application).

Always maintain these rules:
1. Keep any placeholders like @variable, \${variable} and \$variable intact
2. Return only in JSON format
3. Be accurate and natural in the target language
4. Keep the same tone and meaning
5. Maintain exact same whitespace at the start and end of each text
6. Do not modify any spacing or formatting
7. Do not translate variable names or placeholders
8. Use the exact same key format as provided in the input
9. Sometimes text is attached to variables, such as text@variable. Just translate the text, not the variables.
10. If @ has "\\" before it (@), it's treated as a literal symbol rather than a variable.
11. The "UChat" is application name, not to be translated.
12. Remove end-of-sentence periods if they're not needed in the language you're translating to.
13. Use concise, easy-to-understand language.
14. If you encounter the @s variable (which appears in the format "text@s" - a variable used to make words plural, for example "text@s" becomes "texts" for plural or remains "text" for singular): omit this variable if the target language doesn't require plurals. If plurals are needed, keep the variable and attach it directly to the preceding word.
15. Keep "\\n" or "\\\\n" as it is. It's a line break.
''';

      print(systemPrompt);

      conversationHistory.clear();
      conversationHistory.add({
        'role': 'system',
        'content': systemPrompt,
      });

      final prompt = '''
Translate these texts to $targetLanguage language. Return to JSON format with exactly the same keys as shown below:

Input format:
$inputJson

Please maintain the same key structure in your response.
''';
      print(prompt);

      final response = await chatGPT.sendMessage(
        prompt,
        previousMessages: conversationHistory,
      );

      final firstChoice = response.choices.first;
      final jsonMap = firstChoice.message.getContentMap();
      final Map<String, List<String>> translations = {
        for (var entry in jsonMap.entries)
          if (entry.value is List)
            textMapping[entry.key]!: List<String>.from(entry.value)
          else if (entry.value is String)
            textMapping[entry.key]!: List<String>.from([entry.value])
      };

      conversationHistory.add({
        'role': 'user',
        'content': prompt,
      });
      conversationHistory.add({
        'role': 'assistant',
        'content': jsonEncode(firstChoice.message.content),
      });

      return translations;
    } catch (e) {
      logger.warn('Translation failed: $e');
      return {};
    }
  }

  Future<String> translate(String text, String targetLanguage) async {
    // Create thread
    if (!threadIds.containsKey(targetLanguage)) {
      final threadId = await chatGPT.createThread();
      threadIds[targetLanguage] = threadId;
    }

    final threadId = threadIds[targetLanguage]!;

    // Add message to thread
    await chatGPT.addThreadMessage(
      threadId: threadId,
      content: 'Translate the following text to $targetLanguage:\n$text',
    );

    // Run assistant
    final runId = await chatGPT.runAssistant(Env.openAIAssistantId, threadId);

    // Wait for completion and get result
    final messages = await chatGPT.waitAndGetThreadMessages(threadId, runId);

    return messages;
  }
}
