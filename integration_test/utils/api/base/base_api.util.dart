import 'package:http/http.dart' as http;
import 'dart:convert';
import '../endpoint_api.dart';

class BaseApiUtil {
  final http.Client _client;
  final baseUrl = endpoints.endpoint.baseUrl;
  String? _authToken;

  BaseApiUtil(this._client);

  void setAuthToken(String token) {
    _authToken = token;
  }

  Map<String, String> _getHeaders({Map<String, String>? customHeaders}) {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      ...?customHeaders,
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'API request failed with status ${response.statusCode}: ${response.reasonPhrase}\n'
        'URL: ${response.request?.url}\n'
        'Body: ${response.body}',
      );
    }
    if (response.statusCode == 204 || response.body.isEmpty) {
      return {
        'success': true,
        'message': 'Operation successful with no content.',
      };
    }
    return jsonDecode(response.body);
  }

  Future<dynamic> get(endpoint, {Map<String, String>? params}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
    final response = await _client.get(uri, headers: _getHeaders());
    return _handleResponse(response);
  }

  Future<dynamic> post(endpoint, {dynamic data}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await _client.post(
      uri,
      headers: _getHeaders(),
      body: data != null ? jsonEncode(data) : null,
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(endpoint, {dynamic data}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await _client.delete(
      uri,
      headers: _getHeaders(),
      body: data != null ? jsonEncode(data) : null,
    );
    return _handleResponse(response);
  }
}
