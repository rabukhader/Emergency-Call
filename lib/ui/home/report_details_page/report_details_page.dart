import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:emergancy_call/utils/weather_status.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetailsPage extends StatelessWidget {
  final Report report;
  const ReportDetailsPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text("Report Details"),
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
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
                      Text(
                          "Date : ${Formatter.formatDateTimeToString(report.date)}"),
                      Text("Description : ${report.description}"),
                      Text("Police Officer : ${report.policeOfficer}"),
                      Text(
                          "Any Death People : ${report.death == true ? "Yes" : " No"}"),
                      if (report.cars != null && report.cars!.isNotEmpty)
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 14,),
                              const Text(
                                "Cars in the report",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              ...report.cars!
                                  .map(
                                    (e) => Column(
                                      children: [
                                        Text(
                                            "Car Plate Number : ${e.carNumber}"),
                                        Text(
                                            "Car Year Model : ${e.carYearModel}"),
                                        Text("Car Name : ${e.carName}"),
                                        Text(
                                            "Car Insurance Company : ${e.insuranceCompany}"),
                                        const SizedBox(
                                          height: 14,
                                        )
                                      ],
                                    ),
                                  )
                                  ,
                            ]),
                      if (report.injuries != null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             const SizedBox(height: 14,),
                              const Text(
                                "Injuries in the report",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),),
                            ...report.injuries!
                              .map(
                                (e) => Column(
                                  children: [
                                    Text("Injury Degree : $e"),
                                    const SizedBox(
                                      height: 14,
                                    )
                                  ],
                                ),
                              )
                              ,]
                        ),
                    ],
                  ),
                  (report.imagesUrl != null && report.imagesUrl!.isNotEmpty)
                      ? Row(
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
                      : const SizedBox(
                          height: 35,
                        ),
                  if (report.location != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Center(
                        child: QPrimaryButton(
                          minSize: 42,
                          label: "Open Location",
                          onPressed: () {
                            _launchMaps(report.location!.longitude,
                                report.location!.latitude);
                          },
                        ),
                      ),
                    )
                ]),
          ),
        ));
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
