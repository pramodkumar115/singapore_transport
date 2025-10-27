import 'package:geolocator/geolocator.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:intl/intl.dart';


Future<Position?> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users to enable the location services.
    // // print('Location services are disabled.');
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return null;
  }
  return await Geolocator.getCurrentPosition();
}

String calculateDistanceInMeters(
  double? startLatitude,
  double? startLongitude,
  double? endLatitude,
  double? endLongitude,
) {
  if (startLatitude != null &&
      startLongitude != null &&
      endLatitude != null &&
      endLongitude != null) {
    double distanceInMeters = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
    return NumberFormat('###,##0').format(distanceInMeters);
  }
  return "";
}
