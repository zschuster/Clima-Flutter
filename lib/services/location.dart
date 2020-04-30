import 'package:location/location.dart';

class CustomLocation {
  double latitude;
  double longitude;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<void> serviceEnabledCheck(Location location) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  Future<void> permissionsCheck(Location location) async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> getCurrentLocation() async {
    Location location = new Location();

    await serviceEnabledCheck(location);
    await permissionsCheck(location);

    try {
      _locationData = await location.getLocation();
      longitude = _locationData.longitude;
      latitude = _locationData.latitude;
    } catch (e) {
      print(e);
    }
  }
}
