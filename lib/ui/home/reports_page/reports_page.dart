import 'package:emergancy_call/ui/home/reports_page/screens/add_new_report/add_new_report.dart';
import 'package:emergancy_call/ui/home/reports_page/screens/prev_reports/prev_reports.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

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
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: kPrimaryColor,
                  tabs: const [
                    Tab(child: Text("My Reports", style: TextStyle(color: kPrimaryColor),)),
                    Tab(child: Text("Add new report", style: TextStyle(color: kPrimaryColor),)),
                  ],
                ),
                const SizedBox(height: 10),
                const Expanded(
                  child: TabBarView(
                    children: [
                      PreviousReports(),
                      AddNewReport(),
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
