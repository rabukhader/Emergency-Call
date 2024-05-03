import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/date_picker.dart';
import 'package:flutter/material.dart';

class AddNewReport extends StatelessWidget {
  const AddNewReport({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            const Center(
              child: Text("New Report", style : TextStyle(color: kPrimaryDarkerColor)),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                      hintStyle: TextStyle(color: kPrimaryDarkerColor)),
                )),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Description",
                      hintStyle: TextStyle(color: kPrimaryDarkerColor)),
                )),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: GestureDetector(
                              onTap: () {
                                showDate(context);
                              },
                              child: DatePicker(
                                date: DateTime.now(),
                              ),
                            ),),

          ],
        ),
      ),
    );
  }

    Future<void> showDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
  }
}
