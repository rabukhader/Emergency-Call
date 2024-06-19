import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/ui/home/report_details_page/report_details_page.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:emergancy_call/utils/weather_status.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Title : ${report.title}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                        width: 75,
                        height: 75,
                        child: WeatherStatus(
                            weatherStatus: report.weather ?? "Cloudy"))
                  ],
                ),
                const SizedBox(height: 5),
                Text("Date : ${Formatter.formatDateTimeToString(report.date)}"),
                Text("Description : ${report.description}"),
                Text("Police Officer : ${report.policeOfficer}"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: QPrimaryButton(
                          label: "More Details",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportDetailsPage(
                                          report: report,
                                        )));
                          },
                        ),
                      ),
                      SizedBox(width: 16.0,),
                      if (report.location != null)
                        Expanded(
                          child: QPrimaryButton(
                            label: "Open Location",
                            onPressed: () {
                              _launchMaps(report.location?.longitude,
                                  report.location?.latitude);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchMaps(longitude, latitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
