import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:flutter/material.dart';

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
          leading: IconButton(icon: Icon(Icons.cancel),onPressed: () => Navigator.pop(context),),
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
                      Text(
                        "Title : ${report.title}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                          "Date : ${Formatter.formatDateTimeToString(report.date)}"),
                      Text("Description : ${report.description}"),
                      if (report.userCar != null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Car Number : ${report.userCar!.carNumber}"),
                            Text("Car Name : ${report.userCar!.carName}"),
                            const SizedBox(
                              height: 34,
                            )
                          ],
                        )
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
                ]),
          ),
        ));
  }
}
