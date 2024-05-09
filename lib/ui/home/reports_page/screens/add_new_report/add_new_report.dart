import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/ui/home/reports_page/screens/add_new_report/add_new_report_provider.dart';
import 'package:emergancy_call/utils/buttons.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:emergancy_call/utils/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AddNewReport extends StatefulWidget {
  const AddNewReport({super.key});

  @override
  State<AddNewReport> createState() => _AddNewReportState();
}

class _AddNewReportState extends State<AddNewReport> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _policeName = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  DateTime? selectedDate = DateTime.now();
  EmergencyType? _selectedType;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AddNewReportProvider(authStore: GetIt.I<AuthStore>()),
        builder: (context, snapshot) {
          AddNewReportProvider model = context.watch();
          return SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formState,
                  child: Column(
                    children: [
                      const Center(
                        child: Text("New Report",
                            style: TextStyle(color: kPrimaryDarkerColor)),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _formState.currentState!.validate();
                                _validateInput();
                              });
                            },
                            controller: _title,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Title",
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: TextFormField(
                            maxLines: 6,
                            onChanged: (value) {
                              setState(() {
                                _formState.currentState!.validate();
                                _validateInput();
                              });
                            },
                            controller: _description,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Description",
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _formState.currentState!.validate();
                                _validateInput();
                              });
                            },
                            controller: _policeName,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Police Officer",
                                hintStyle:
                                    TextStyle(color: kPrimaryDarkerColor)),
                          )),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        child: GestureDetector(
                          onTap: () async {
                            selectedDate = await model.showDate(context);
                            setState(() {});
                          },
                          child: DatePicker(
                            date: selectedDate ?? DateTime.now(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: QPrimaryButton(
                          label: "Add",
                          enabled: _validateInput(),
                          onPressed: () {
                            model.addNewReport(Report(
                              userCar: model.userCar, 
                                type: _selectedType ?? EmergencyType.ambulance,
                                title: _title.text,
                                description: _description.text,
                                date: selectedDate ?? DateTime.now()));
                            clear();
                            setState(() {});
                          },
                          isLoading: model.isAdding,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  _validateInput() {
    return (_title.text.isNotEmpty &&
        _description.text.isNotEmpty &&
        _policeName.text.isNotEmpty);
  }

  clear() {
    _title.text = "";
    _description.text = "";
    _policeName.text = "";
    selectedDate = DateTime.now();
  }
}
