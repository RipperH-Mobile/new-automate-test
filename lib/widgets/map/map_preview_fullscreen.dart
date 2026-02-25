import 'dart:async';
import 'dart:io' show Platform;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as map_launcher;
import 'package:uchat/api/payloads/map/map_info.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/gps.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/map/map.dart';
import 'package:uchat/widgets/map/message_box.dart';
import 'package:uchat/widgets/sheet/modal_bottom_sheet.dart';
import 'package:uchat/widgets/sheet/uchat_bottom_sheet_divider.dart';
import 'package:uchat/widgets/sheet/uchat_bottom_sheet_item.dart';
import 'package:uchat/widgets/web_browser/web_browser_launcher.dart';

final _log = useLogger();

class MapPreviewFullScreen extends StatefulWidget {
  final MapInfoResponse mapInfo;

  const MapPreviewFullScreen({
    super.key,
    required this.mapInfo,
  });

  @override
  State<MapPreviewFullScreen> createState() => _MapPreviewFullScreenState();
}

class _MapPreviewFullScreenState extends State<MapPreviewFullScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final markers = <MarkerId, Marker>{};
  final _customInfoWindowController = CustomInfoWindowController();
  LatLng? userLocation;

  Position? lastUserPositionRequest;
  bool isLoadingCurrentPosition = false;
  List<map_launcher.AvailableMap> maps = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initialUserLocation();
      maps = await map_launcher.MapLauncher.installedMaps;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _customInfoWindowController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: _handleLocationNavigator,
            child: const Icon(Icons.location_pin),
          ),
          // SizedBox(width: 10,),
          // if((userLocation != null))FloatingActionButton(
          //   heroTag: UniqueKey(),
          //   onPressed: _handleLocationNavigatorVisibleRegion,
          //   child: Icon(Icons.zoom_in_map),
          // ),
        ],
      ),
      appBar: appBar(),
      body: Stack(
        children: [
          map(),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 75,
            width: 250,
            offset: 50,
          ),
          searchUserLocationButton(),
        ],
      ),
    );
  }

  Future<void> initialUserLocation() async {
    try {
      setState(() {
        isLoadingCurrentPosition = true;
      });
      try {
        lastUserPositionRequest = await determinePosition();
      } catch (e, stackTrace) {
        _log.e('Verify error(2).', e, stackTrace);
        return;
      }

      if (lastUserPositionRequest != null) {
        userLocation = LatLng(
          lastUserPositionRequest!.latitude,
          lastUserPositionRequest!.longitude,
        );

        final marker = Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(204),
          markerId: const MarkerId('user_location'),
          position: LatLng(
            userLocation!.latitude,
            userLocation!.longitude,
          ),
        );
        setState(() {
          markers[const MarkerId('user_location')] = marker;
          isLoadingCurrentPosition = false;
        });
        // await _moveCamera();
      }
    } catch (e) {
      _log.e('initial user location error: $e');
    }
  }

  PreferredSizeWidget appBar() {
    Widget title() => SizedBox(
          width: Get.width,
          child: Text(
            widget.mapInfo.name ?? 'Unable to get name'.tr,
            maxLines: 1,
            style: const TextStyle(color: Colors.black),
          ),
        );
    Widget description() {
      Widget child = Container();

      if (widget.mapInfo.locationFormattedAddress != null || widget.mapInfo.vicinity != null) {
        child = SizedBox(
          width: Get.width,
          child: AutoSizeText(
            widget.mapInfo.locationFormattedAddress ?? widget.mapInfo.vicinity!,
            maxLines: 2,
            minFontSize: 10,
            style: TextStyle(
                color: widget.mapInfo.name == null ? Colors.grey : Colors.black.withValues(alpha: 0.6),
                height: 1.1,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
        );
      }
      return child;
    }

    return AppBar(
      elevation: 0,
      backgroundColor: UTheme.color.background,
      toolbarHeight: (widget.mapInfo.locationFormattedAddress != null || widget.mapInfo.vicinity != null) ? 75 : 60,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(),
          description(),
        ],
      ),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          )),
      actions: [
        IconButton(
            onPressed: _handleOpenMap,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ))
      ],
    );
  }

  Widget searchUserLocationButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: _handleSearchCurrentUserLocation,
          mini: true,
          backgroundColor: UTheme.color.primary,
          child: isLoadingCurrentPosition == true
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(
                  Icons.location_searching,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }

  Widget map() {
    return MapWidget(
      mapPadding: 0,
      markers: markers.values.toSet(),
      initCameraPosition: CameraPosition(
        target: LatLng(
          widget.mapInfo.location!.latitude,
          widget.mapInfo.location!.longitude,
        ),
        zoom: 18,
      ),
      onMapCreate: _onMapCreate,
      onMapTap: (_) {},
      onCameraMoveStarted: () {
        _customInfoWindowController.hideInfoWindow?.call();
      },
      onCameraMove: (controller) {
        _customInfoWindowController.onCameraMove?.call();
      },
      onCameraIdle: addInfoWindowHelper,
      mapId: () async {
        final controller = await _controller.future;
        return controller.mapId;
      },
    );
  }

  Future<void> _onMapCreate(GoogleMapController controller) async {
    _controller.complete(controller);
    final initialLocation = LatLng(
      widget.mapInfo.location!.latitude,
      widget.mapInfo.location!.longitude,
    );
    final marker = Marker(
      markerId: const MarkerId('place_name'),
      position: initialLocation,
    );
    setState(() {
      markers[const MarkerId('place_name')] = marker;
    });
    _customInfoWindowController.googleMapController = controller;
    await Future.delayed(const Duration(milliseconds: 200), () {});
    addInfoWindowHelper();
  }

  Future<void> _handleLocationNavigator() async {
    final cameraSetting = CameraPosition(
      target: LatLng(
        widget.mapInfo.location!.latitude,
        widget.mapInfo.location!.longitude,
      ),
      zoom: 18,
    );
    final cameraUpdate = CameraUpdate.newCameraPosition(cameraSetting);
    final controller = await _controller.future;
    await controller.animateCamera(cameraUpdate);
  }

  // Future<void> _handleLocationNavigatorVisibleRegion() async {
  //   LatLng? southwest;
  //   LatLng? northeast;
  //   if (widget.mapInfo.location!.latitude <= userLocation!.latitude) {
  //     southwest = widget.mapInfo.location!;
  //     northeast = userLocation!;
  //   } else {
  //     southwest = userLocation!;
  //     northeast = widget.mapInfo.location!;
  //   }
  //   LatLngBounds bound = LatLngBounds(
  //     southwest: southwest,
  //     northeast: northeast,
  //   );
  //   CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
  //   final controller = await _controller.future;
  //   controller.animateCamera(u2).then((void v) {
  //     _handleLocationNavigatorVisibleRegionHelper(
  //       u2,
  //       controller,
  //     );
  //   });
  // }

  // void _handleLocationNavigatorVisibleRegionHelper(
  //   CameraUpdate u,
  //   GoogleMapController c,
  // ) async {
  //   final controller = await _controller.future;
  //
  //   c.animateCamera(u);
  //   controller.animateCamera(u);
  //   LatLngBounds l1 = await c.getVisibleRegion();
  //   LatLngBounds l2 = await c.getVisibleRegion();
  //
  //   if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
  //     _handleLocationNavigatorVisibleRegionHelper(u, c);
  //   }
  // }

  Future<void> _handleSearchCurrentUserLocation() async {
    setState(() {
      isLoadingCurrentPosition = true;
    });
    Position? currentUserPositionRequest;
    try {
      currentUserPositionRequest = await determinePosition();
    } catch (e, stackTrace) {
      _log.e('Verify error(2).', e, stackTrace);
      return;
    }
    if (currentUserPositionRequest != null) {
      userLocation = LatLng(
        currentUserPositionRequest.latitude,
        currentUserPositionRequest.longitude,
      );

      final marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(204),
        markerId: const MarkerId('user_location'),
        position: LatLng(userLocation!.latitude, userLocation!.longitude),
      );
      setState(() {
        markers[const MarkerId('user_location')] = marker;
        isLoadingCurrentPosition = false;
      });
      await _moveCamera();
    }
  }

  Future<void> _handleOpenMap({LatLng? currentPosition}) async {
    showUChatModalBottomSheet(
      menus: <Widget>[
        UChatBottomSheetItem(
          label: 'Open with browser'.tr,
          icon: Icons.open_in_browser_outlined,
          onPressed: () {
            Get.back();
            openMap(
              targetLocation: widget.mapInfo.location!,
              currentUserLocation: userLocation,
              openWebBrowser: true,
            );
          },
        ),
        Platform.isIOS ? const UChatBottomSheetDivider() : const SizedBox.shrink(),
        Platform.isIOS
            ? UChatBottomSheetItem(
                label: 'Apple map'.tr,
                icon: Icons.apple,
                onPressed: () async {
                  Get.back();
                  openMap(
                    targetLocation: widget.mapInfo.location!,
                    currentUserLocation: userLocation,
                    mapType: map_launcher.MapType.apple,
                  );
                },
              )
            : const SizedBox.shrink(),
        const UChatBottomSheetDivider(),
        UChatBottomSheetItem(
          label: 'Google map'.tr,
          icon: Icons.android,
          onPressed: () async {
            Get.back();
            openMap(
              targetLocation: widget.mapInfo.location!,
              currentUserLocation: userLocation,
              mapType: map_launcher.MapType.google,
            );
          },
        ),
        userLocation != null ? const UChatBottomSheetDivider() : const SizedBox.shrink(),
        userLocation != null
            ? UChatBottomSheetItem(
                label: 'Navigate from current location.'.tr,
                icon: Icons.turn_right,
                onPressed: () async {
                  Get.back();
                  openMap(
                    targetLocation: widget.mapInfo.location!,
                    currentUserLocation: userLocation,
                  );
                },
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Future<void> _moveCamera() async {
    final GoogleMapController controller = await _controller.future;
    final cameraPosition = CameraPosition(
      target: LatLng(
        userLocation!.latitude,
        userLocation!.longitude,
      ),
      zoom: 18,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    await Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        await controller.showMarkerInfoWindow(
          const MarkerId('user_location'),
        );
        _customInfoWindowController.hideInfoWindow?.call();
      },
    );
  }

  void addInfoWindowHelper() {
    final initialLocation = LatLng(
      widget.mapInfo.location!.latitude,
      widget.mapInfo.location!.longitude,
    );
    final infoWidget = MessageBox(
      title: widget.mapInfo.name ?? 'Unable to get name'.tr,
    );
    _customInfoWindowController.addInfoWindow?.call(
      infoWidget,
      initialLocation,
    );
  }

  Future<void> openMap({
    required LatLng targetLocation,
    LatLng? currentUserLocation,
    bool openWebBrowser = false,
    map_launcher.MapType? mapType,
  }) async {
    bool isMapAvailable = true;
    map_launcher.AvailableMap? targetMap = maps.first;
    String mapUrl =
        'https://www.google.com/maps/dir/?api=1&destination=${targetLocation.latitude},${targetLocation.longitude}';

    if (mapType != null) {
      isMapAvailable = await map_launcher.MapLauncher.isMapAvailable(mapType);
      targetMap = maps.firstWhereOrNull(
        (element) => element.mapType == mapType,
      );
      if (mapType == map_launcher.MapType.apple) {
        mapUrl = 'https://maps.apple.com/?q=${targetLocation.latitude},${targetLocation.longitude}';
      }

      if (mapType == map_launcher.MapType.google) {
        mapUrl =
            'https://www.google.com/maps/dir/?api=1&${currentUserLocation != null ? 'origin=${currentUserLocation.latitude},${currentUserLocation.longitude}' : ''}&destination=${targetLocation.latitude},${targetLocation.longitude}&dir_action=navigate';
      }
    }

    if (openWebBrowser == false && maps.isNotEmpty && isMapAvailable && targetMap != null) {
      _log.d('show apple map');
      map_launcher.Coords? origin;
      if (currentUserLocation != null) {
        origin = map_launcher.Coords(
          currentUserLocation.latitude,
          currentUserLocation.longitude,
        );
      }

      await targetMap.showDirections(
        origin: origin,
        destination: map_launcher.Coords(
          targetLocation.latitude,
          targetLocation.longitude,
        ),
      );
    } else {
      WebBrowserLauncher.instance.open(mapUrl);
    }
  }
}
