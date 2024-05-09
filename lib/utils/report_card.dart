import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/ui/home/report_details_page/report_details_page.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final Report report;
  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportDetailsPage(
                      report: report,
                    )));
      },
      child: Container(
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
                  "Title : ${report.title}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text("Date : ${Formatter.formatDateTimeToString(report.date)}"),
                Text("Description : ${report.description}"),
                if (report.userCar != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Car Number : ${report.userCar!.carNumber}"),
                      Text("Car Name : ${report.userCar!.carName}"),
                      const SizedBox(
                        height: 14,
                      )
                    ],
                  ),
                if (report.location != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User Latitude : ${report.location!.latitude}"),
                      Text("User Longitude : ${report.location!.longitude}"),
                      const SizedBox(
                        height: 14,
                      )
                    ],
                  ),
                if (report.imagesUrl != null && report.imagesUrl!.isNotEmpty)
                  Row(
                    children: report.imagesUrl!
                        .map((e) => Expanded(
                              child: Image.network(
                                e,
                                width: 160,
                                height: 160,
                              ),
                            ))
                        .toList(),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
