import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/controller/utils/location_controller_utils.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  late final LocationUtilsController _locationController;

  @override
  void initState() {
    super.initState();
    _locationController = Get.put(LocationUtilsController());
    _locationController.checkLocationPermission();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _saveLocation() {
    if (_locationController.selectedAddress?.value == null ||
        _locationController.selectedLocation.value == null) {
      Get.snackbar('Error', 'Please select a location',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    Get.back(result: _locationController.selectedAddress?.value);
    print(_locationController.selectedAddress?.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter:
                    _locationController.selectedLocation.value ?? LatLng(0, 0),
                initialZoom: _locationController.selectedLocation.value != null
                    ? 15.0
                    : 2.0,
                minZoom: 1,
                maxZoom: 18,
                onTap: (tapPosition, point) =>
                    _locationController.getAddressFromLatLng(point),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: _locationController.selectedLocation.value != null
                      ? [
                          Marker(
                            point: _locationController.selectedLocation.value!,
                            width: 80,
                            height: 80,
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ]
                      : [],
                ),
              ],
            );
          }),
          Positioned(
            top: 30,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search location (e.g., 43H3+R6R, Batam Kota)',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (_searchController.text.isNotEmpty) {
                        _locationController
                            .searchLocation(_searchController.text);
                      }
                    },
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _locationController.searchLocation(value);
                  }
                },
              ),
            ),
          ),
          Obx(() {
            return _locationController.selectedAddress?.value != null
                ? Positioned(
                    bottom: 80,
                    left: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'Selected Address: ${_locationController.selectedAddress?.value}',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _locationController.getCurrentLocation,
            heroTag: 'current_location',
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _saveLocation,
            heroTag: 'save_location',
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
