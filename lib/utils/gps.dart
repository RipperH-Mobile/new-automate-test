import 'package:geolocator/geolocator.dart';
import 'package:uchat/controllers/permission_controller.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position?> determinePosition() async {
  bool serviceEnabled;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  bool locationPerm = await PermissionController.instance.checkLocationPermission();
  if (!locationPerm) {
    return Future.error('Location permission is not granted');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
