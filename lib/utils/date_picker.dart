import 'package:emergancy_call/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final DateTime date;
  const DatePicker({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [const Text("Date"), Text(date.formatDateTime("yyyy-MM-dd"))],
        ));
  }
}
extension C on DateTime {
  String formatDateTime(String formatKey) {
    return DateFormat(formatKey, 'en').format(this);
  }
}