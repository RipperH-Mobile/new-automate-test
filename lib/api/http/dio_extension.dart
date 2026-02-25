import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

extension ToMapToListMap on Response {
  Map<String, dynamic>? toMap() {
    if (data.toString() == '') return null;

    if (data is Map<String, dynamic>) {
      return data;
    }

    final jsonData = json.decode(data.toString());
    return Map<String, dynamic>.from(jsonData);
  }

  Map<String, dynamic>? toMapV3() {
    if (data.toString() == '') return null;

    if (data is Map<String, dynamic>) {
      return data['data'] ?? data;
    }

    final jsonData = json.decode(data.toString());
    return Map<String, dynamic>.from(jsonData['data'] ?? jsonData);
  }

  List<dynamic>? toList() {
    if (data == null) return null;
    if (data.toString() == '') return null;

    if (data is List<dynamic>?) {
      return data;
    }

    final jsonData = json.decode(data.toString());

    return List<dynamic>.from(jsonData);
  }

  List<dynamic>? toListV3() {
    if (data['data'] == null) return null;
    if (data['data'].toString() == '') return null;

    if (data['data'] is List<dynamic>?) {
      return data['data'];
    }

    final jsonData = json.decode(data['data'].toString());

    return List<dynamic>.from(jsonData);
  }

  List<Map<String, dynamic>> toListMap() {
    if (data is List<dynamic>) {
      return (data as List<dynamic>).map((item) => item as Map<String, dynamic>).toList();
    }

    final jsonData = json.decode(data.toString());
    return List<Map<String, dynamic>>.from(jsonData);
  }

  T? mapToResponse<T>(T Function(Map<String, dynamic>) mapper) {
    Map<String, dynamic>? mapResp = toMap();
    if (mapResp != null) {
      return mapper(mapResp);
    }
    return null;
  }

  T? mapToResponseV3<T>(T Function(Map<String, dynamic>) mapper) {
    Map<String, dynamic>? mapResp = toMapV3();
    if (mapResp != null) {
      try {
        return mapper(mapResp);
      } catch (e, stackTrace) {
        useLogger().e('Error in mapToResponseV3', e, stackTrace);
      }
    }
    return null;
  }

  @Deprecated('Use listToResponseV3 instead')
  Iterable<T>? listToResponse<T>(
    T Function(Map<String, dynamic> result) mapper, {
    bool Function(Map<String, dynamic> result)? condition,
  }) {
    List<dynamic>? mapResp = toList();
    if (mapResp == null) return null;

    return mapResp.map((e) {
      if (((condition != null && condition(e)) || condition == null)) {
        return mapper(e);
      }

      return e;
    });
  }

  Iterable<T>? listToResponseV3<T>(
    T Function(Map<String, dynamic> result) mapper, {
    bool Function(Map<String, dynamic> result)? condition,
  }) {
    List<dynamic>? mapResp = toListV3();
    if (mapResp == null) return null;

    return mapResp.map((e) {
      if (((condition != null && condition(e)) || condition == null)) {
        return mapper(e);
      }

      return e;
    });
  }
}
