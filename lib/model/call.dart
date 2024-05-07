import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/utils/formatter.dart';

class Call {
  final User user;
  final DateTime time;
  final EmergencyType type;

  Call({required this.type, required this.user, required this.time});

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'time': time,
      'type': Formatter.emergencyTypeToString(type)
    };
  }

  // Create a Call object from a map (JSON)
  factory Call.fromJson(Map<String, dynamic> json) {
    return Call(
        user: User.fromJson(json['user']),
        time: Formatter.convertTimestampToDateTime(json['time']),
        type: Formatter.stringToEmergencyType(json['type']));
  }
}
