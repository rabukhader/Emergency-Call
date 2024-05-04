import 'package:emergancy_call/model/location.dart';

enum EmergencyType {police, ambulance, civil}

class Emergency {
  final Location location;
  final String phone;
  final EmergencyType type;

  Emergency(this.location, this.phone, this.type);
}


