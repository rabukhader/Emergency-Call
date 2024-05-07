import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/ui/home/reports_page/screens/prev_reports/prev_reports_provider.dart';
import 'package:emergancy_call/utils/empty_alternate.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:emergancy_call/utils/loader.dart';
import 'package:emergancy_call/utils/report_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              : model.previousReports == null || model.previousReports!.isEmpty
                  ? Center(
                      child: EmptyAlternate(
                          image: SvgPicture.asset(kThanks, height: 180,), text: "No Reports"))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: model.previousReports?.length,
                            itemBuilder: (context, index) {
                              return ReportCard(
                                  report: model.previousReports![index]);
                            },
                          ),
                        )
                      ],
                    );
        });
  }
}
