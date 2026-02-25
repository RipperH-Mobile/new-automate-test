// import 'dart:async';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_animarker/flutter_map_marker_animation.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sliding_up_panel2/sliding_up_panel2.dart';
// import 'package:uchat/api/payloads/map/map_info.dart';
// import 'package:uchat/api/services/google_place_service.dart';
// import 'package:uchat/controllers/permission_controller.dart';
// import 'package:uchat/screens/map/map_screen.dart';
// import 'package:uchat/utils/gps.dart';
// import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

// final _log = useLogger();

// const currentMarkerId = 'current user';
// const selectedMarkerId = 'selected_id';

// class MapController extends GetxController {
//   GoogleMapController? mapController;
//   final Completer<int> mapId = Completer();

//   final globalKeyMarker = GlobalKey();
//   final searchController = TextEditingController();
//   final panelController = PanelController();
//   final focus = FocusNode();

//   final isPanelClose = true.obs;
//   final isFullScreen = false.obs;
//   final isLoading = true.obs;
//   final isSkipSearch = false.obs;
//   final multiplePadding = 1.0.obs;
//   final mapPadding = 0.obs;
//   final isSearchLoading = false.obs;
//   final isHasFocus = false.obs;

//   final selectedLocation = Rx<MapInfoResponse?>(null);
//   final nearBySearchMaps = <MapInfoResponse>[].obs;
//   final markers = <MarkerId, Marker>{}.obs;

//   final maxDistance = 100.0;
//   final minDistance = 20.0;

//   final minPanelHeight = Get.height * .135;
//   final maxPanelHeight = Get.height * .55;

//   // initial location at Bangkok
//   final initialPosition = const LatLng(
//     13.7567046,
//     100.499701,
//   ).obs;

//   final cameraPosition = Rx<CameraPosition?>(null);

//   final textSearchDebouncer = Debouncer(
//     delay: const Duration(milliseconds: 1000),
//   );

//   final onMapMoveDebouncer = Debouncer(
//     delay: const Duration(milliseconds: 100),
//   );

//   final PermissionController permissionController = Get.find();
//   final hasLocationPermission = false.obs;

//   @override
//   void onInit() async {
//     initialPosition(const LatLng(13.7567046, 100.499701));
//     cameraPosition(CameraPosition(
//       target: initialPosition.value,
//       zoom: 18,
//     ));

//     focus.addListener(onFocusChange);

//     try {
//       await moveToCurrentLocation();
//     } catch (e, stackTrace) {
//       _log.w('Call moveToCurrentLocation error.', e, stackTrace);
//       await checkLocationPermission();
//       return;
//     }

//     isLoading(false);

//     await checkLocationPermission();

//     super.onInit();
//   }

//   @override
//   void dispose() {
//     focus.removeListener(onFocusChange);
//     focus.dispose();
//     textSearchDebouncer.cancel();
//     onMapMoveDebouncer.cancel();

//     super.dispose();
//   }

//   void onPanelPositionChange(double position) {
//     if (position >= .7 && !isFullScreen.value) {
//       isFullScreen.value = true;
//       isPanelClose.value = false;
//     }

//     if (position < .7 && isFullScreen.value) {
//       isFullScreen.value = false;
//       isPanelClose.value = false;
//       focus.unfocus();
//     }
//   }

//   void onFocusChange() {
//     if (focus.hasFocus) {
//       panelController.open();
//       isHasFocus.value = true;
//     } else {
//       panelController.close();
//       isHasFocus.value = false;
//     }
//   }

//   void onSearchChanged(String input) {
//     if (input == '' || input.length <= 3) return;

//     textSearchDebouncer.call(() => onSearchChangedHelper(input));
//   }

//   Future<void> onSearchChangedHelper(String input) async {
//     isSearchLoading(true);
//     final result = await GooglePlaceService().placeTextSearch(
//       input,
//       location: cameraPosition.value?.target,
//     );

//     List<MapInfoResponse> searchResult = result ?? [];
//     if (cameraPosition.value != null) {
//       searchResult = GooglePlaceService().sortPlaceWithDistance(
//         targetLocation: cameraPosition.value!.target,
//         places: result ?? [],
//       );
//     }
//     if (result != null) {
//       nearBySearchMaps(searchResult);
//       isSearchLoading(false);
//     }
//   }

//   void onMapMoved(CameraPosition position) {
//     cameraPosition(position);
//   }

//   void onMapMovedEnd() {
//     if (isLoading()) return;

//     if (isSkipSearch()) {
//       isSkipSearch(false);
//       return;
//     }

//     isLoading(true);

//     if (markers.isNotEmpty && cameraPosition() != null) {
//       const markerId = MarkerId(selectedMarkerId);
//       final marker = markers[markerId]!;
//       final lat = cameraPosition()!.target.latitude;
//       final lng = cameraPosition()!.target.longitude;

//       final updatedMarker = marker.copyWith(
//         positionParam: LatLng(lat, lng),
//         infoWindowParam: InfoWindow(
//           title: cameraPosition()!.tilt.toString(),
//           snippet: '$lat, $lng, ',
//         ),
//       );

//       markers[markerId] = updatedMarker;
//     }

//     if (cameraPosition() != null) {
//       onMapMoveDebouncer.call(
//         () => onMapMovedEndHelper(cameraPosition()!.target),
//       );
//     }
//   }

//   Future<void> onMapMovedEndHelper(LatLng location) async {
//     try {
//       List<MapInfoResponse> searchResult = await GooglePlaceService.instance.nearBySearch(
//             location,
//             filter: true,
//           ) ??
//           [];

//       if (searchResult.isNotEmpty) {
//         if (searchResult.isNotEmpty) {
//           final MapInfoResponse nearestPlace = GooglePlaceService.instance.getNearestPlace(
//             targetLocation: location,
//             places: searchResult,
//           );

//           /// if distance <= 100 and distance > 20m, show "Near" text at the start of the name
//           if (nearestPlace.distance != null) {
//             if (nearestPlace.distance! <= maxDistance && nearestPlace.distance! > minDistance) {
//               nearestPlace.name = '${'Near'.tr} ${nearestPlace.name}';
//             }
//           }

//           if (cameraPosition.value != null) {
//             searchResult = GooglePlaceService().sortPlaceWithDistance(
//               targetLocation: cameraPosition.value!.target,
//               places: searchResult,
//             );
//           }

//           nearBySearchMaps(searchResult);
//           selectedLocation.value = nearestPlace;
//         }
//       }
//     } catch (e, stackTrace) {
//       _log.e('onMapMovedEndHelper : Google place service error', e, stackTrace);
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> onMapCreate(GoogleMapController controller) async {
//     mapController = controller;
//     mapId.complete(mapController!.mapId);

//     final markerBitmap = BitmapDescriptor.bytes(
//       await getBytesFromAsset(
//         mapPinPath,
//         1,
//       ),
//     );

//     await setSelectedLocation(
//       '',
//       '',
//       initialPosition(),
//       selectedMarkerId,
//       icon: markerBitmap,
//     );
//   }

//   Future<void> onMapTaped(LatLng latLng) async {
//     if (mapController == null) return;

//     panelController.close();
//     final byteToBitmap = await getBytesFromAsset(
//       mapPinPath,
//       1,
//     );

//     final markerBitmap = BitmapDescriptor.bytes(byteToBitmap);
//     await setSelectedLocation(
//       '',
//       '',
//       latLng,
//       selectedMarkerId,
//       icon: markerBitmap,
//     );
//   }

//   Future<void> moveToCurrentLocation() async {
//     Position? currentUserPositionRequest;

//     try {
//       currentUserPositionRequest = await determinePosition();
//     } catch (e, stackTrace) {
//       _log.w('Call moveToCurrentLocation error.', e, stackTrace);
//       return;
//     }

//     if (currentUserPositionRequest != null) {
//       final LatLng currentUserLatLng = LatLng(
//         currentUserPositionRequest.latitude,
//         currentUserPositionRequest.longitude,
//       );

//       final camera = CameraPosition(
//         target: currentUserLatLng,
//         zoom: 18,
//       );

//       await Future.delayed(
//         const Duration(milliseconds: 200),
//         () async => await mapController!.animateCamera(
//           CameraUpdate.newCameraPosition(camera),
//         ),
//       );
//     }
//   }

//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     final data = await rootBundle.load(path);
//     final codec = await ui.instantiateImageCodec(
//       data.buffer.asUint8List(),
//       targetWidth: width,
//     );
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
//   }

//   Future<void> setSelectedLocation(
//     String title,
//     String snippet,
//     LatLng position,
//     String markerId, {
//     BitmapDescriptor? icon,
//   }) async {
//     if (mapController == null) return;
//     focus.unfocus();
//     icon ??= BitmapDescriptor.defaultMarkerWithHue(204);

//     Marker marker = Marker(
//       markerId: MarkerId(markerId),
//       position: position,
//       icon: icon,
//       infoWindow: InfoWindow(
//         title: title,
//         snippet: snippet,
//       ),
//     );

//     if (markerId == currentMarkerId) {
//       marker = RippleMarker(
//         markerId: const MarkerId(currentMarkerId),
//         position: initialPosition(),
//         icon: BitmapDescriptor.defaultMarkerWithHue(204),
//         ripple: true,
//       );
//     }

//     markers[MarkerId(markerId)] = marker;

//     final latLng = LatLng(position.latitude, position.longitude);
//     final camera = CameraPosition(target: latLng, zoom: 18);
//     await mapController!.animateCamera(CameraUpdate.newCameraPosition(camera));
//     await Future.delayed(const Duration(milliseconds: 200));
//   }

//   double get mapScrollPadding {
//     double padding = ((Get.height * 0.5) * (1 - multiplePadding())) + (multiplePadding() == 0 ? 0 : 150);

//     if (padding < 0) {
//       padding = 0;
//     } else if (padding > Get.height * 0.5) {
//       padding = Get.height * 0.5;
//     }

//     return padding - 35;
//   }

//   double get mapHeight {
//     return (Get.height - 150) * (0.5 + (0.5 * multiplePadding())) + (multiplePadding() == 0 ? 40 : 0);
//   }

//   String get selectedTitle {
//     return selectedLocation()?.name ?? '';
//   }

//   String get selectedSubtitle {
//     return selectedLocation()!.locationFormattedAddress ?? selectedLocation()!.vicinity ?? '';
//   }

//   Future<int> waitForMapId() {
//     return mapId.future;
//   }

//   void onPressedCloseFullScreenSearchMap() {
//     if (isHasFocus.value) {
//       focus.unfocus();
//     }
//     panelController.close();
//   }

//   void onPressedDone() {
//     if (selectedLocation() != null) {
//       Get.back(result: selectedLocation());
//     }
//   }

//   void onPressedLeadingBack() {
//     Get.back();
//   }

//   void onPanelOpened() {
//     isFullScreen.value = true;
//     isPanelClose.value = false;
//   }

//   void onPanelClosed() {
//     isFullScreen.value = false;
//     isPanelClose.value = true;
//   }

//   Future<void> onSearchResultTaped(MapInfoResponse selectedItem) async {
//     isSkipSearch(true);
//     selectedLocation(selectedItem);

//     final markerBitmap = BitmapDescriptor.bytes(
//       await getBytesFromAsset(mapPinPath, 1),
//     );

//     setSelectedLocation(
//       selectedItem.name ?? '',
//       selectedItem.locationFormattedAddress ?? selectedItem.vicinity ?? '',
//       selectedLocation.value!.location!,
//       selectedMarkerId,
//       icon: markerBitmap,
//     );
//   }

//   Future<void> checkLocationPermission() async {
//     hasLocationPermission.value = await permissionController.checkLocationPermission();
//     _log.d('Permission value : ${hasLocationPermission.value}');
//   }
// }
