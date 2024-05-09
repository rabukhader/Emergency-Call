import 'package:emergancy_call/model/car.dart';
import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/location.dart';
import 'package:emergancy_call/utils/formatter.dart';

class Report {
  final String title;
  final String description;
  final DateTime date;
  final EmergencyType type;
  int? userNumber;
  Car? userCar;
  List<String>? imagesUrl;
  Location? location;

  Report(
      {this.userNumber,
      required this.title,
      this.imagesUrl,
      required this.description,
      this.userCar,
      this.location,
      required this.date,
      required this.type});

  Map<String, dynamic> toJson() => {
        if (location != null) "location": location!.toJson(),
        "title": title,
        "description": description,
        "date": date,
        "type": "POLICE",
        if (imagesUrl != null) "images": imagesUrl,
        if (userNumber != null) "number": userNumber,
        if (userCar != null) "userCar": userCar!.toJson()
      };

  factory Report.fromJson(Map<String, dynamic> json) => Report(
      location: (json['location']) != null
          ? Location.fromJson(json['location'])
          : null,
      userCar: json['userCar'],
      userNumber: json['number'],
      title: json['title'],
      imagesUrl: (json['images'] != null) ? json['images'].map((e) => e) : null,
      description: json['description'],
      date: Formatter.convertTimestampToDateTime(json['date']),
      type: Formatter.stringToEmergencyType(json['type']));
}
