import 'package:emergancy_call/ui/home/emeregency_dashboard/emeregency_dashboard_provider.dart';
import 'package:emergancy_call/utils/loader.dart';
import 'package:emergancy_call/utils/report_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  final String type;
  const DashboardPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => EmergencyDashboardProvider(type: type),
        builder: (context, snapshot) {
          EmergencyDashboardProvider provider = context.watch();
          return provider.isFetching
              ? const LoaderWidget()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.reports?.length,
                        itemBuilder: (context, index) {
                          return ReportCard(report: provider.reports![index]);
                        },
                      ),
                    )
                  ],
                );
        });
  }
}
