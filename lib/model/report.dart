import 'package:emergancy_call/model/car.dart';
import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/utils/formatter.dart';

class Report {
  final String title;
  final String description;
  final DateTime date;
  final EmergencyType type;
  int? userNumber;
  Car? userCar;

  Report(
      {this.userNumber,
      required this.title,
      required this.description,
      this.userCar,
      required this.date,
      required this.type});

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date": date,
        "type": "POLICE",
        if (userNumber != null) "number": userNumber,
        if(userCar != null) "userCar" : userCar!.toJson() 
      };

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    userCar: json['userCar'],
      userNumber: json['number'],
      title: json['title'],
      description: json['description'],
      date: Formatter.convertTimestampToDateTime(json['date']),
      type: Formatter.stringToEmergencyType(json['type']));
}
