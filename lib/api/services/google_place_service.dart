import 'dart:collection';
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/app_env.dart';

final _log = useLogger();

class GooglePlaceService with ServiceMixin {
  static final GooglePlaceService instance = GooglePlaceService._internal();

  factory GooglePlaceService() => instance;

  GooglePlaceService._internal();

  final String mapStaticUrl = 'https://maps.googleapis.com/maps/api/staticmap';

  String staticMapApi(LatLng location) {
    final query = <String, String>{
      'center': '${location.latitude},${location.longitude}',
      'zoom': '18',
      'size': '300x150',
      'maptype': 'roadmap',
      'markers': 'color:red | label:C |${location.latitude},${location.longitude}',
      'key': AppEnv.googleApiKey
    };

    return Uri.https('maps.googleapis.com', '/maps/api/staticmap', query).toString();
  }

  Future<List<MapInfoResponse>?> nearBySearch(
    LatLng location, {
    filter = false,
  }) async {
    final query = <String, String>{
      'location': '${location.latitude},${location.longitude}',
      'radius': '100',
      'language': Get.locale?.languageCode ?? 'en',
    };

    if (filter) {
      query['type'] = 'point_of_interest';
    }

    final socketResp = await socketCaller.emitCall(
      'map.nearBySearch',
      query,
    );

    return socketResp.listToResponse((e) => MapInfoResponse.fromMap(e))?.toList();
  }

  Future<List<MapInfoResponse>?> placeTextSearch(
    String input, {
    LatLng? location,
  }) async {
    final query = <String, dynamic>{
      'query': input,
      'language': Get.locale?.languageCode ?? 'en',
    };
    if (location != null) {
      query['location'] = '${location.latitude},${location.longitude}';
      query['radius'] = '30000';
    }

    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.placeTextSearch.socket,
          query,
        );
        if (socketResp.data == null) {
          return null;
        }

        return socketResp.listToResponse((e) => MapInfoResponse.fromMap(e))?.toList();
      } catch (e, stackTrace) {
        _log.w('placeTextSearch with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.get(
      BackendPath.placeTextSearch.http,
      data: query,
    );
    if (httpResp.data == null) {
      return null;
    }

    return httpResp.listToResponse((e) => MapInfoResponse.fromMap(e))?.toList();
  }

  List<MapInfoResponse> sortPlaceWithDistance({
    required LatLng targetLocation,
    required List<MapInfoResponse> places,
    bool fromNearest = true,
  }) {
    if (places.isEmpty) {
      return [];
    }

    for (var index = 0; index < places.length; index++) {
      MapInfoResponse place = places[index];
      if (place.location == null) {
        continue;
      }

      final distanceInMeters = Geolocator.distanceBetween(
        targetLocation.latitude,
        targetLocation.longitude,
        place.location!.latitude,
        place.location!.longitude,
      );

      places[index] = place.copyWith(distance: distanceInMeters);
    }

    if (fromNearest) {
      places.sort((a, b) {
        if (a.distance != null) {
          return a.distance!.compareTo(b.distance!);
        }
        return 0;
      });
    } else {
      places.sort((a, b) {
        if (b.distance != null) {
          return b.distance!.compareTo(a.distance!);
        }
        return 0;
      });
    }

    return places;
  }

  MapInfoResponse getNearestPlace({
    required LatLng targetLocation,
    required List<MapInfoResponse> places,
  }) {
    HashMap<double, int> distanceMap = HashMap();

    for (MapInfoResponse place in places) {
      if (place.location == null) {
        continue;
      }

      final distanceInMeters = Geolocator.distanceBetween(
        targetLocation.latitude,
        targetLocation.longitude,
        place.location!.latitude,
        place.location!.longitude,
      );

      distanceMap[distanceInMeters] = places.indexOf(place);
    }

    return places[distanceMap[distanceMap.keys.reduce(min)]!].copyWith(
      distance: distanceMap.keys.reduce(min),
      location: targetLocation,
    );
  }
}
