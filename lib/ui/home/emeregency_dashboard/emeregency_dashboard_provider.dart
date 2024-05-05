import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:flutter/material.dart';

class EmergencyDashboardProvider extends ChangeNotifier {
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  final String type;

  List<Report>? reports;

  EmergencyDashboardProvider({required this.type}){
    init();
  }
  
  init() async {
        try {
      _isFetching = true;
      notifyListeners();
      CollectionReference emergencyTypeRef =
          FirebaseFirestore.instance.collection(type);

      QuerySnapshot reportsSnapshot = await emergencyTypeRef.get();
      List<Report> previousReport = [];
      for (var doc in reportsSnapshot.docs) {
        String title = doc['title'];
        String description = doc['description'];
        Timestamp dateTime = doc['date'];
        int userNumber = doc['userNumber'];
        Report report = Report(
          type: Formatter.stringToEmergencyType(type),
            title: title,
            userNumber: userNumber,
            description: description,
            date: Formatter.convertTimestampToDateTime(dateTime));
        previousReport.add(report);
      }
      reports = previousReport;
    } catch (e) {
      print(e);
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }
}
