import 'package:emergancy_call/utils/formatter.dart';

class Report {
  final String title;
  final String description;
  final DateTime date;

  Report({required this.title,required this.description,required this.date});

   Map<String, dynamic> toJson() => {
    "title" : title,
    "description" :description,
    "date" : date
  };

    factory Report.fromJson(Map<String,dynamic> json) => Report(
    title: json['title'],
    description: json['description'],
    date: Formatter.convertTimestampToDateTime(json['date'])
  );
}
