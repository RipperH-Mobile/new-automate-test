import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translation/chatgpt/response.dart';

class ChatGptApi {
  final String apiKey;
  final String model;
  final String baseUrl = 'https://api.openai.com/v1';

  ChatGptApi({
    required this.apiKey,
    this.model = 'gpt-4-turbo-preview',
  });

  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $apiKey',
    };
  }

  Map<String, String> get _assistantHeaders {
    return {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $apiKey',
      'OpenAI-Beta': 'assistants=v2',
    };
  }

  Future<ChatGptResponse> sendMessage(
    String message, {
    List<Map<String, String>>? previousMessages,
  }) async {
    try {
      final messages = [
        if (previousMessages != null) ...previousMessages,
        {
          'role': 'user',
          'content': message,
        },
      ];

      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: _headers,
        body: jsonEncode({
          'model': model,
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 800,
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final mapData = jsonDecode(decodedResponse);

        return ChatGptResponse.fromJson(mapData);
      } else {
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception('Failed to send message: $e');
    }
  }

  Future<String> runAssistant(String assistantId, String threadId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/threads/$threadId/runs'),
      headers: _assistantHeaders,
      body: jsonEncode({
        'assistant_id': assistantId,
      }),
    );

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);

      final responseData = json.decode(decodedResponse);

      return responseData['id'];
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<String> createThread() async {
    final response = await http.post(
      Uri.parse('$baseUrl/threads'),
      headers: _assistantHeaders,
    );

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);

      final responseData = json.decode(decodedResponse);

      return responseData['id'];
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> addThreadMessage({
    required String threadId,
    required String content,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/threads/$threadId/messages'),
      headers: _assistantHeaders,
      body: jsonEncode({
        'role': 'user',
        'content': content,
      }),
    );

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final responseData = json.decode(decodedResponse);

      return responseData;
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<String> checkThreadRunStatus(String threadId, String runId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/threads/$threadId/runs/$runId'),
      headers: _assistantHeaders,
    );

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final responseData = json.decode(decodedResponse);

      return responseData['status'];
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<String> waitAndGetThreadMessages(String threadId, String runId) async {
    // Poll run status until completed
    while (true) {
      final status = await checkThreadRunStatus(threadId, runId);
      if (status == 'completed') {
        break;
      } else if (status == 'failed') {
        throw Exception('Translation failed');
      }
      await Future.delayed(Duration(seconds: 1));
    }

    final response = await http.get(
      Uri.parse('$baseUrl/threads/$threadId/messages'),
      headers: _assistantHeaders,
    );

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final responseData = json.decode(decodedResponse);

      // Return the latest assistant message content
      return responseData['data'][0]['content'][0]['text']['value'];
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }
}
