import 'package:geocoding/geocoding.dart' hide Location;
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:nul_app/constants/color.dart';

class LocationUtilsController extends GetxController {
  final Location _locationService = Location();
  final RxBool isLocationPermissionGranted = false.obs;
  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  final RxString? selectedAddress = ''.obs;

  Future<void> checkLocationPermission() async {
    bool serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permission = await _locationService.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _locationService.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }

    isLocationPermissionGranted.value = true;
  }

  Future<void> getCurrentLocation() async {
    if (!isLocationPermissionGranted.value) {
      await checkLocationPermission();
      if (!isLocationPermissionGranted.value) {
        Get.snackbar('Error', 'Location permission not granted',
            backgroundColor: appRed, colorText: appWhite);
        return;
      }
    }

    try {
      final locationData = await _locationService.getLocation();
      final lat = locationData.latitude ?? 0.0;
      final lon = locationData.longitude ?? 0.0;
      final placemarks = await placemarkFromCoordinates(lat, lon);
      final address = placemarks.isNotEmpty
          ? _formatAddress(placemarks.first)
          : 'Unknown address';

      selectedLocation.value = LatLng(lat, lon);
      selectedAddress?.value = address;
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location: $e',
          backgroundColor: appRed, colorText: appWhite);
    }
  }

  Future<void> searchLocation(String query) async {
    try {
      final locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final lat = location.latitude;
        final lon = location.longitude;
        final placemarks = await placemarkFromCoordinates(lat, lon);
        final address =
            placemarks.isNotEmpty ? _formatAddress(placemarks.first) : query;

        selectedLocation.value = LatLng(lat, lon);
        selectedAddress?.value = address;
      } else {
        Get.snackbar('Error', 'Location not found',
            backgroundColor: appRed, colorText: appWhite);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to search location: $e',
          backgroundColor: appRed, colorText: appWhite);
    }
  }

  Future<void> getAddressFromLatLng(LatLng point) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(point.latitude, point.longitude);
      final address = placemarks.isNotEmpty
          ? _formatAddress(placemarks.first)
          : 'Unknown address';

      selectedLocation.value = point;
      selectedAddress?.value = address;
    } catch (e) {
      Get.snackbar('Error', 'Failed to get address: $e',
          backgroundColor: appRed, colorText: appWhite);
    }
  }

  String _formatAddress(Placemark placemark) {
    final parts = [
      placemark.street,
      placemark.locality,
      placemark.administrativeArea,
      placemark.country,
    ].where((e) => e != null && e.isNotEmpty).join(', ');
    return parts.isEmpty ? 'Unknown address' : parts;
  }
}
