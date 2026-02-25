import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';

class MapInfoResponse {
  String? placeID;
  String? name;
  LatLng? location;
  String? vicinity;
  String? locationImgId;
  String? locationImgBlurhash;
  String? locationFormattedAddress;
  double? distance;

  MapInfoResponse({
    this.placeID,
    this.name,
    this.location,
    this.vicinity,
    this.locationImgId,
    this.locationImgBlurhash,
    this.locationFormattedAddress,
    this.distance,
  });

  factory MapInfoResponse.fromMap(Map<String, dynamic> json) {
    return MapInfoResponse(
      placeID: json['locationPlacesId'],
      name: json['locationName'],
      vicinity: json['locationVicinity'],
      location: (json['locationLat'] == null || json['locationLng'] == null)
          ? null
          : LatLng(json['locationLat'], json['locationLng']),
      locationFormattedAddress: json['locationFormattedAddress'],
      locationImgId: json['locationImgId'],
      locationImgBlurhash: json['locationImgBlurhash'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locationLat': location!.latitude,
      'locationLng': location!.longitude,
      'locationName': name,
      'locationFormattedAddress': locationFormattedAddress,
      'locationPlacesId': placeID,
      'locationImgId': locationImgId,
      'locationImgBlurhash': locationImgBlurhash,
      'locationVicinity': vicinity
    };
  }

  String? get mapPreview {
    if (locationImgId != null) {
      return FileService().getFileUrl(locationImgId!);
    }
    return null;
  }

  String? get mapBlurhashPreview {
    if (locationImgBlurhash != null) {
      return locationImgBlurhash;
    }
    return null;
  }

  @override
  String toString() {
    return 'MapInfoResponse(placeID: $placeID, name: $name, location: $location, vicinity: $vicinity, locationImgId: $locationImgId, locationImgBlurhash: $locationImgBlurhash, locationFormattedAddress: $locationFormattedAddress, distance: $distance)';
  }

  MapInfoResponse copyWith({
    String? placeID,
    String? name,
    LatLng? location,
    String? vicinity,
    String? locationImgId,
    String? locationImgBlurhash,
    String? locationFormattedAddress,
    double? distance,
  }) {
    return MapInfoResponse(
      placeID: placeID ?? this.placeID,
      name: name ?? this.name,
      location: location ?? this.location,
      vicinity: vicinity ?? this.vicinity,
      locationImgId: locationImgId ?? this.locationImgId,
      locationImgBlurhash: locationImgBlurhash ?? this.locationImgBlurhash,
      locationFormattedAddress: locationFormattedAddress ?? this.locationFormattedAddress,
      distance: distance ?? this.distance,
    );
  }
}
