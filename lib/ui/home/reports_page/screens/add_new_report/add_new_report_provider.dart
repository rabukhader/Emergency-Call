import 'package:emergancy_call/model/car.dart';
import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:flutter/material.dart';

class AddNewReportProvider extends ChangeNotifier {
  final AuthStore authStore;

  Car? userCar;

  bool _isAdding = false;

  bool get isAdding => _isAdding;
  AddNewReportProvider({required this.authStore}) {
    init();
  }

  void init() {}

  Future<void> addNewReport(Report report) async {
    try {
      _isAdding = true;
      notifyListeners();
      User? user = await authStore.getUser();
      CollectionReference userReportsRef = FirebaseFirestore.instance
          .collection('user')
          .doc(user?.id)
          .collection('reports');

      await fetchUserCar();
      report.userCar = userCar;
      await userReportsRef.add(report.toJson());
      await addReportToPolice(report, user?.userNumber ?? 0);
    } catch (e) {
      print(e);
    } finally {
      _isAdding = false;
      notifyListeners();
    }
  }

  fetchUserCar() async {
    User? userData = await authStore.getUser();
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    DocumentSnapshot user = await users.doc(userData!.id).get();
    Map userMap = user.data() as Map<String, dynamic>;
    userCar = Car.fromJson({
      "isGuranteed": userMap['isGuranteed'],
      "carName": userMap['carName'],
      "carYearModel": userMap['carYearModel'],
      "carNumber": userMap['carNumber'],
    });
  }

  Future<DateTime?> showDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: kBlackedColor,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: kPrimaryDarkerColor), // Number color
            ),
          ),
          child: DatePickerTheme(
            data: const DatePickerThemeData(
              backgroundColor: kPrimaryColor,
            ),
            child: child!,
          ),
        );
      },
    );
    return selectedDate;
  }

  addReportToPolice(Report report, int userNumber) async {
    report.userNumber = userNumber;
    CollectionReference emergencyTypeRef =
        FirebaseFirestore.instance.collection("POLICE");
    emergencyTypeRef.add(report.toJson());
  }
}
