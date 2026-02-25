import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:uchat/lang/lang.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

import 'models/client_error.dart';
import 'models/collection.dart';
import 'models/gif.dart';
import 'models/languages.dart';
import 'models/rating.dart';

final _log = useLogger();

// TODO: convert to clean architecture (GiphyRepository)
class GiphyClient {
  static final baseUri = Uri(scheme: 'https', host: 'api.giphy.com');

  final String _apiKey;
  final Dio _client;

  GiphyClient({
    required String apiKey,
    Dio? client,
  })  : _apiKey = apiKey,
        _client = client ?? Dio();

  Future<GiphyCollection> trending({
    int offset = 0,
    int limit = 30,
    String rating = GiphyRating.g,
  }) async {
    return _fetchCollection(
      baseUri.replace(
        path: 'v1/gifs/trending',
        queryParameters: <String, String>{
          'offset': '$offset',
          'limit': '$limit',
          'rating': rating,
        },
      ),
    );
  }

  Future<GiphyCollection> search(
    String query, {
    int offset = 0,
    int limit = 30,
    String rating = GiphyRating.g,
    String? reqLang,
  }) async {
    return _fetchCollection(
      baseUri.replace(
        path: 'v1/gifs/search',
        queryParameters: <String, String>{
          'q': query,
          'offset': '$offset',
          'limit': '$limit',
          'rating': rating,
          'lang': reqLang ?? lang,
          'bundle': 'clips_grid_picker',
        },
      ),
    );
  }

  Future<GiphyGif?> random({
    String? tag,
    String? rating = GiphyRating.g,
  }) async {
    return _fetchGif(
      baseUri.replace(
        path: 'v1/gifs/random',
        queryParameters: <String, String?>{
          'tag': tag,
          'rating': rating,
        },
      ),
    );
  }

  Future<GiphyGif?> byId(String id) async {
    return _fetchGif(baseUri.replace(path: 'v1/gifs/$id'));
  }

  Future<GiphyGif?> _fetchGif(Uri uri) async {
    final response = await _getWithAuthorization(uri);

    if (response.data != null) {
      return GiphyGif.fromJson(response.data);
    }

    return null;
  }

  Future<GiphyCollection> _fetchCollection(Uri uri) async {
    final response = await _getWithAuthorization(uri);

    return GiphyCollection.fromJson(response.data);
  }

  Future<Response> _getWithAuthorization(Uri uri) async {
    final params = Map<String, String>.from(uri.queryParameters)..putIfAbsent('api_key', () => _apiKey);

    try {
      final response = await _client.getUri<Map<String, dynamic>>(
        uri.replace(queryParameters: params),
      );

      return response;
    } on DioException catch (e, stackTrace) {
      _log.d('Giphy fetch error.', e, stackTrace);
      throw GiphyClientError(
        statusCode: e.response?.statusCode,
        statusMessage: e.response?.statusMessage,
        exception: e,
      );
    } catch (e, stackTrace) {
      _log.d('Giphy fetch error.', e, stackTrace);
      throw GiphyClientError(
        statusMessage: e.toString(),
        exception: e as Exception,
      );
    }
  }

  String get lang {
    String lang = GiphyLanguage.english;
    if (getx.Get.locale == thLocale) {
      lang = GiphyLanguage.thai;
    } else if (getx.Get.locale == zhTwLocale) {
      lang = GiphyLanguage.chineseTraditional;
    } else if (getx.Get.locale == zhCnLocale) {
      lang = GiphyLanguage.chineseSimplified;
    }

    return lang;
  }
}
