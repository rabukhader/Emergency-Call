import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/location.dart';
import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/utils/formatter.dart';

class Call {
  final User user;
  final DateTime time;
  final EmergencyType type;
  final Location location;

  Call({required this.type, required this.user, required this.time, required this.location});

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'time': time,
      'type': Formatter.emergencyTypeToString(type),
      'location' : location.toJson()
    };
  }

  // Create a Call object from a map (JSON)
  factory Call.fromJson(Map<String, dynamic> json) {
    return Call(
      location: Location.fromJson(json['location']),
        user: User.fromJson(json['user']),
        time: Formatter.convertTimestampToDateTime(json['time']),
        type: Formatter.stringToEmergencyType(json['type']));
  }
}
