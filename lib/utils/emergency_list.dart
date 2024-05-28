import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/location.dart';

List<Emergency> emergencyList = [
  Emergency(Location(longitude: 34.0522, latitude: -118.2437), "+972 56-823-8187",
      EmergencyType.police),
  Emergency(Location(longitude: 41.8781, latitude: -87.6298), "+972 56-823-8187",
      EmergencyType.police),
  Emergency(Location(longitude: 29.7604, latitude: -95.3698), "+972 56-823-8187",
      EmergencyType.police),
  Emergency(Location(longitude: 33.4484, latitude: -112.0740), "+972 56-823-8187",
      EmergencyType.police),
  Emergency(Location(longitude: 34.0522, latitude: -118.2437), "+972 56-823-8187",
      EmergencyType.ambulance),
  Emergency(Location(longitude: 41.8781, latitude: -87.6298), "+972 56-823-8187",
      EmergencyType.ambulance),
  Emergency(Location(longitude: 29.7604, latitude: -95.3698), "+972 56-823-8187",
      EmergencyType.ambulance),
  Emergency(Location(longitude: 33.4484, latitude: -112.0740), "+972 56-823-8187",
      EmergencyType.ambulance),
  Emergency(Location(longitude: 41.8781, latitude: -87.6298), "+972 56-823-8187",
      EmergencyType.civil),
  Emergency(Location(longitude: 34.0522, latitude: -118.2437), "+972 56-823-8187",
      EmergencyType.civil),
  Emergency(Location(longitude: 29.7604, latitude: -95.3698), "+972 56-823-8187",
      EmergencyType.civil),
  Emergency(Location(longitude: 33.4484, latitude: -112.0740), "+972 56-823-8187",
      EmergencyType.civil),
];
