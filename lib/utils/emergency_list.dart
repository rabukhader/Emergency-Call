import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/location.dart';

List<Emergency> emergencyList = [
  Emergency(Location(34.0522, -118.2437), "0592844743", EmergencyType.police),
  Emergency(Location(41.8781, -87.6298), "0592844743", EmergencyType.police),
  Emergency(Location(29.7604, -95.3698), "0592844743", EmergencyType.police),
  Emergency(Location(33.4484, -112.0740), "0592844743", EmergencyType.police),
  Emergency(Location(34.0522, -118.2437), "0592844743", EmergencyType.ambulance),
  Emergency(Location(41.8781, -87.6298), "0592844743", EmergencyType.ambulance),
  Emergency(Location(29.7604, -95.3698), "0592844743", EmergencyType.ambulance),
  Emergency(Location(33.4484, -112.0740), "0592844743", EmergencyType.ambulance),
  Emergency(Location(41.8781, -87.6298), "0592844743", EmergencyType.civil),
  Emergency(Location(34.0522, -118.2437), "0592844743", EmergencyType.civil),
  Emergency(Location(29.7604, -95.3698), "0592844743", EmergencyType.civil),
  Emergency(Location(33.4484, -112.0740), "0592844743", EmergencyType.civil),
];
