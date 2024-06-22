import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AppController extends GetxController {
  var currentPosition = const LatLng(32.158680, 74.189139).obs;
  GoogleMapController? mapController;

  var currentMarkerLocation = Rxn<Marker>();

  // Get permission from user device
  Future<Position> determinePosition() async {
    print('Determining position...'); // Debug statement
    if (await Permission.location.request().isGranted) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } else {
      return Future.error('Location permissions are denied');
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await determinePosition();
      print(
          'Current position: ${position.latitude}, ${position.longitude}'); // Debug statement
      currentPosition.value = LatLng(position.latitude, position.longitude);
      currentMarkerLocation.value = Marker(
        markerId: const MarkerId('currentLocation'),
        position: currentPosition.value,
        infoWindow: const InfoWindow(title: 'You are here', snippet: 'HI'),
      );
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentPosition.value, zoom: 16),
        ),
      );
    } catch (e) {
      print('Error in getting your current location: $e'); // Debug statement
    }
  }
}
