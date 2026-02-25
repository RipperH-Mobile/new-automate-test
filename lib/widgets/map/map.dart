import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final double mapPadding;
  final Set<Marker> markers;
  final CameraPosition initCameraPosition;

  final void Function(GoogleMapController)? onMapCreate;
  final void Function(LatLng)? onMapTap;
  final void Function(CameraPosition)? onCameraMove;
  final void Function()? onCameraIdle;
  final void Function()? onCameraMoveStarted;

  final Future<int> Function() mapId;

  const MapWidget({
    super.key,
    required this.mapPadding,
    required this.markers,
    required this.initCameraPosition,
    required this.onMapCreate,
    required this.onMapTap,
    required this.onCameraMove,
    required this.mapId,
    required this.onCameraIdle,
    required this.onCameraMoveStarted,
  });

  @override
  Widget build(BuildContext context) {
    return buildMap();
  }

  Widget buildMap() {
    return Animarker(
      zoom: 18,
      useRotation: false,
      rippleColor: Colors.blue,
      rippleRadius: 0.15,
      curve: Curves.bounceInOut,
      duration: const Duration(seconds: 1500),
      markers: markers,
      mapId: mapId(),
      child: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        padding: EdgeInsets.only(bottom: mapPadding),
        markers: markers,
        mapType: MapType.normal,
        compassEnabled: false,
        initialCameraPosition: initCameraPosition,
        onMapCreated: onMapCreate,
        onTap: onMapTap,
        onCameraMove: onCameraMove,
        onCameraIdle: onCameraIdle,
        onCameraMoveStarted: onCameraMoveStarted,
      ),
    );
  }
}
