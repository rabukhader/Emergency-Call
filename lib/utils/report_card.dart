import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final Report report;
  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                report.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              Text(Formatter.formatDateTimeToString(report.date)),
              Text("Description : ${report.description}"),
              Text("Phone Number : 0${report.userNumber}"),
            ],
          ),
        ),
      ),
    );
  }
}
