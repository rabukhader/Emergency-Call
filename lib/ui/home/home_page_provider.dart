// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/model/call.dart';
import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/location.dart';
import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/utils/emergency_list.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageProvider extends ChangeNotifier {
  final AuthStore authStore;
  double? userLatitude;
  double? userLongitude;

  User? userData;

  bool _isCalling = false;

  bool get isCalling => _isCalling;

  HomePageProvider(this.authStore) {
    init();
  }

  init() async {
    await getLocationPermission();
    await getUserData();
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
    userLatitude = position.latitude;
    userLongitude = position.longitude;
  }

  onCall(EmergencyType type) async {
    try {
      _isCalling = true;
      notifyListeners();
      Emergency nearestEmergency = await findNearest(type);
      String url = 'tel:${nearestEmergency.phone}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
      await updateRecentCallOnEmergency(Call(
          type: type,
          user: userData!,
          time: DateTime.now(),
          location: Location(
              latitude: userLatitude ?? 0, longitude: userLongitude ?? 0)));
    } catch (e) {
      print(e);
    } finally {
      _isCalling = false;
      notifyListeners();
    }
  }

  Future<Emergency> findNearest(EmergencyType type) async {
    List<Emergency> filteredList =
        emergencyList.where((element) => element.type == type).toList();
    Emergency nearestEmergency = filteredList.first;
    double minDistance = double.infinity;

    for (Emergency emergency in filteredList) {
      double distance = _calculateDistance(
          userLatitude ?? 0.0,
          userLongitude ?? 0.0,
          emergency.location.latitude,
          emergency.location.longitude);
      if (distance < minDistance) {
        minDistance = distance;
        nearestEmergency = emergency;
      }
    }

    return nearestEmergency;
  }

  double _calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    const double earthRadius = 6371; // Radius of the earth in km

    double dLat = _degreesToRadians(endLatitude - startLatitude);
    double dLon = _degreesToRadians(endLongitude - startLongitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(startLatitude)) *
            cos(_degreesToRadians(endLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c; // Distance in km

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  updateRecentCallOnEmergency(Call call) async {
    CollectionReference recentCalls =
        FirebaseFirestore.instance.collection('recent_calls');
    await recentCalls.add(call.toJson());
  }

  getUserData() async {
    userData = await authStore.getUser();
  }
}
