import 'package:emergancy_call/model/call.dart';
import 'package:emergancy_call/ui/home/emeregency_dashboard/emeregency_dashboard_provider.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/empty_alternate.dart';
import 'package:emergancy_call/utils/icons.dart';
import 'package:emergancy_call/utils/loader.dart';
import 'package:emergancy_call/utils/report_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              : _buildWidget(provider);
        });
  }

  _buildWidget(EmergencyDashboardProvider provider) {
    if (type == "POLICE") {
      return const PoliceDashboardPage();
    } else {
      return RecentCallsList(
        list: provider.recentCalls,
        isRecentCall: true,
      );
    }
  }
}

class RecentCallsList extends StatelessWidget {
  final List? list;
  final bool isRecentCall;
  const RecentCallsList({super.key, this.list, required this.isRecentCall});

  @override
  Widget build(BuildContext context) {
    return list != null && list!.isNotEmpty
        ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    return isRecentCall
                        ? RecentCallCard(call: list![index])
                        : ReportCard(report: list![index]);
                  },
                ),
              )
            ],
          )
        : EmptyAlternate(
            image: SvgPicture.asset(
              kThanks,
              height: 180,
            ),
            text: isRecentCall ? "No Recent Calls" : "No Reports");
  }
}

class PoliceDashboardPage extends StatelessWidget {
  const PoliceDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    EmergencyDashboardProvider provider = context.watch();
    return Column(
      children: [
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  indicatorColor: kPrimaryColor,
                  tabs: [
                    Tab(
                        child: Text(
                      "Recent Calls",
                      style: TextStyle(color: kPrimaryColor),
                    )),
                    Tab(
                        child: Text(
                      "Reports",
                      style: TextStyle(color: kPrimaryColor),
                    )),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    children: [
                      RecentCallsList(
                        list: provider.recentCalls,
                        isRecentCall: true,
                      ),
                      RecentCallsList(
                        list: provider.reports,
                        isRecentCall: false,
                      ),
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

class RecentCallCard extends StatelessWidget {
  final Call call;
  const RecentCallCard({super.key, required this.call});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User name: ${call.user.fullname ?? "Not Known"}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('User ID: ${call.user.nationalId}'),
            Text('Email: ${call.user.email}'),
            Text('Time: ${call.time}'),
            Text('Gender: ${call.user.gender}'),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Center(
                child: QPrimaryButton(
                  minSize: 42,
                  label: "Open Location",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
