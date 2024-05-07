import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/model/call.dart';
import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:flutter/material.dart';

class EmergencyDashboardProvider extends ChangeNotifier {
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  final String type;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Report>? reports;
  List<Call>? recentCalls;

  EmergencyDashboardProvider({required this.type}) {
    init();
  }

  init() async {
    try {
      _isFetching = true;
      notifyListeners();
      if (type == "POLICE") {
        await _fetchPoliceReports();
      }
      recentCalls = await getRecentCalls(type);
    } catch (e) {
      print(e);
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  _fetchPoliceReports() async {
    CollectionReference emergencyTypeRef = _firestore.collection(type);

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
  }

  Future<List<Call>> getRecentCalls(String type) async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('recent_calls').get();
      return snapshot.docs
          .map((doc) => _callFromDocumentSnapshot(doc))
          .where((element) =>
              Formatter.emergencyTypeToString(element.type) == type)
          .toList();
    } catch (e) {
      print('Error fetching recent calls: $e');
      return [];
    }
  }

  Call _callFromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Call.fromJson(data);
  }
}
