import 'package:flutter/material.dart';

class PreviousReports extends StatelessWidget {
  const PreviousReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const PrevReportTile();
            },
          ),
        )
      ],
    );
  }
}

class PrevReportTile extends StatelessWidget {
  const PrevReportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Report 1",
              ),
              SizedBox(height: 5),
              Text("4-4-20245"),
            ],
          ),
        ),
      ),
    );
  }
}
