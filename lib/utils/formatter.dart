import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/model/emergency.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String formatDateTimeToString(DateTime dateTime) {
    // Using DateFormat class to format DateTime object with custom pattern
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  static String timestampToString(int timestamp) {
    // Convert timestamp (milliseconds since epoch) to DateTime object
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Using DateFormat class to format DateTime object as string
    DateFormat formatter = DateFormat('yy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }

  static String parseTimestampToString(Timestamp timestamp) {
    // Convert Timestamp to DateTime object
    DateTime dateTime = timestamp.toDate();

    // Using DateFormat class to format DateTime object as string
    DateFormat formatter = DateFormat('yy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }

  static DateTime convertTimestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  static String emergencyTypeToString(EmergencyType type) {
    switch (type) {
      case EmergencyType.ambulance:
        return "AMBULANCE";
      case EmergencyType.police:
        return "POLICE";
      case EmergencyType.civil:
        return "CIVIL";
      default:
        return "";
    }
  }

  static EmergencyType stringToEmergencyType(String type) {
    switch (type) {
      case "AMBULANCE":
        return EmergencyType.ambulance;
      case "POLICE":
        return EmergencyType.police;
      case "CIVIL":
        return EmergencyType.civil;
      default:
        return EmergencyType.civil;
    }
  }
}
