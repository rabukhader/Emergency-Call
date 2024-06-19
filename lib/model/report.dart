import 'package:emergancy_call/model/car.dart';
import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/location.dart';
import 'package:emergancy_call/utils/formatter.dart';

class Report {
  final String title;
  final String description;
  final DateTime date;
  final bool? death;
  final EmergencyType type;
  int? userNumber;
  List<Car>? cars;
  List<String>? imagesUrl;
  List<String>? injuries;
  Location? location;
  String? weather;
  String policeOfficer;

  Report(
      {this.userNumber,
      this.death,
      required this.policeOfficer,
      this.weather,
      this.injuries,
      required this.title,
      this.imagesUrl,
      required this.description,
      this.cars,
      this.location,
      required this.date,
      required this.type});

  Map<String, dynamic> toJson() => {
        if (location != null) "location": location!.toJson(),
        "title": title,
        "description": description,
        "date": date,
        "type": "POLICE",
        "policeOfficer": policeOfficer,
        "weather": weather,
        if (injuries != null) "injuries": injuries,
        if (death != null) "death": death,
        if (imagesUrl != null) "images": imagesUrl,
        if (userNumber != null) "number": userNumber,
        if (cars != null) "cars": cars!.map((e) => e.toJson()),
      };

  factory Report.fromJson(Map<String, dynamic> json) => Report(
      location: (json['location']) != null
          ? Location.fromJson(json['location'])
          : null,
      weather: json['weather'] ?? "Cloudy",
      death: json['death'],
      policeOfficer: json['policeOfficer'],
      cars: (json['cars'] != null) ? json['cars'].map((e) => Car.fromJson(e)) : null,
      userNumber: json['number'],
      title: json['title'],
      imagesUrl: (json['images'] != null) ? json['images'].map((e) => e) : null,
      injuries: (json['injuries'] != null) ? json['injuries'].map((e) => e) : null,
      description: json['description'],
      date: Formatter.convertTimestampToDateTime(json['date']),
      type: Formatter.stringToEmergencyType(json['type']));
}
