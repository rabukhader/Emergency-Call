import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/ui/home/reports_page/screens/prev_reports/prev_reports_provider.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:emergancy_call/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class PreviousReports extends StatelessWidget {
  const PreviousReports({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            PreviousReportsProvider(authStore: GetIt.I<AuthStore>()),
        builder: (context, snapshot) {
          PreviousReportsProvider model = context.watch();
          return model.isFetching
              ? const LoaderWidget()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: model.previousReports?.length,
                        itemBuilder: (context, index) {
                          return PrevReportTile(
                              report: model.previousReports![index]);
                        },
                      ),
                    )
                  ],
                );
        });
  }
}

class PrevReportTile extends StatelessWidget {
  final Report report;
  const PrevReportTile({super.key, required this.report});

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
              ),
              const SizedBox(height: 5),
              Text(Formatter.formatDateTimeToString(report.date)),
            ],
          ),
        ),
      ),
    );
  }
}
