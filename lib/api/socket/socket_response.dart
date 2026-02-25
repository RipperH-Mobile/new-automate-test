import 'dart:convert';

// import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

// final _log = useLogger();

class SocketResponse {
  dynamic data;
  List<dynamic>? rawData;

  SocketResponse({
    this.rawData,
    this.data,
  });

  Map<String, dynamic>? toMap() {
    if (data == null) return null;
    if (data.toString() == '') return null;

    if (data is Map<String, dynamic>?) {
      return data;
    }

    final jsonData = json.decode(data.toString());

    return Map<String, dynamic>.from(jsonData);
  }

  Map<String, dynamic>? toMapV3() {
    if (data == null) return null;
    if (data.toString() == '') return null;

    if (data is Map<String, dynamic>?) {
      return data['data'] ?? data;
    }

    final jsonData = json.decode(data.toString());

    return Map<String, dynamic>.from(jsonData['data'] ?? jsonData);
  }

  List<dynamic>? toList() {
    if (data.toString() == '') return null;

    if (data is List<dynamic>?) {
      return data;
    }

    final jsonData = json.decode(data.toString());

    return List<dynamic>.from(jsonData);
  }

  List<dynamic>? toListV3() {
    if (data['data'].toString() == '') return null;

    if (data['data'] is List<dynamic>?) {
      return data['data'];
    }

    final jsonData = json.decode(data['data'].toString());

    return List<dynamic>.from(jsonData);
  }

  T? mapToResponse<T>(
    T Function(Map<String, dynamic> result) mapper, {
    bool Function(Map<String, dynamic> result)? condition,
  }) {
    Map<String, dynamic>? mapResp = toMap();

    if (mapResp != null && ((condition != null && condition(mapResp)) || condition == null)) {
      return mapper(mapResp);
    }
    return null;
  }

  T? mapToResponseV3<T>(
      T Function(Map<String, dynamic> result) mapper, {
        bool Function(Map<String, dynamic> result)? condition,
      }) {
    Map<String, dynamic>? mapResp = toMapV3();

    if (mapResp != null && ((condition != null && condition(mapResp)) || condition == null)) {
      return mapper(mapResp);
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

  @override
  String toString() => 'SocketResponse: $data';
}
