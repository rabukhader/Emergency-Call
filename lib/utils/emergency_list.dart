import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/location.dart';

List<Emergency> emergencyList = [
  Emergency(Location(longitude: 34.0522, latitude: -118.2437), "0592844743",
      EmergencyType.police),
  Emergency(Location(longitude: 41.8781, latitude: -87.6298), "0592844743",
      EmergencyType.police),
  Emergency(Location(longitude: 29.7604, latitude: -95.3698), "0592844743",
      EmergencyType.police),
  Emergency(Location(longitude: 33.4484, latitude: -112.0740), "0592844743",
      EmergencyType.police),
  Emergency(Location(longitude: 34.0522, latitude: -118.2437), "0592844743",
      EmergencyType.ambulance),
  Emergency(Location(longitude: 41.8781, latitude: -87.6298), "0592844743",
      EmergencyType.ambulance),
  Emergency(Location(longitude: 29.7604, latitude: -95.3698), "0592844743",
      EmergencyType.ambulance),
  Emergency(Location(longitude: 33.4484, latitude: -112.0740), "0592844743",
      EmergencyType.ambulance),
  Emergency(Location(longitude: 41.8781, latitude: -87.6298), "0592844743",
      EmergencyType.civil),
  Emergency(Location(longitude: 34.0522, latitude: -118.2437), "0592844743",
      EmergencyType.civil),
  Emergency(Location(longitude: 29.7604, latitude: -95.3698), "0592844743",
      EmergencyType.civil),
  Emergency(Location(longitude: 33.4484, latitude: -112.0740), "0592844743",
      EmergencyType.civil),
];
