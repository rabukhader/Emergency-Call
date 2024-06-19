import 'package:emergancy_call/ui/home/reports_page/screens/add_new_report/add_new_report.dart';
import 'package:emergancy_call/ui/home/reports_page/screens/prev_reports/prev_reports.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  final String type;
  const ReportsPage({super.key, required this.type});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DefaultTabController(
            length: 1,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: kPrimaryColor,
                  tabs: [
                    if(widget.type != "POLICE")const Tab(child: Text("My Reports", style: TextStyle(color: kPrimaryColor),)),
                    if(widget.type == "POLICE")const Tab(child: Text("Add new report", style: TextStyle(color: kPrimaryColor),)),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    children: [
                      if(widget.type != "POLICE")const PreviousReports(),
                      if(widget.type == "POLICE")const AddNewReport(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
