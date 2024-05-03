// ignore_for_file: unused_local_variable

import 'package:emergancy_call/provider/base.dart';
import 'package:geolocator/geolocator.dart';


class HomePageProvider extends BaseChangeNotifier {
  HomePageProvider(){
    init();
  }

  init(){
    getLocationPermission();
  }

  Future<void> getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
    } else if (permission == LocationPermission.deniedForever) {
    } else {
      getLocation();
    }
  }

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Use the position data as needed
    double latitude = position.latitude;
    double longitude = position.longitude;
  }
}