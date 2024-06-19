import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/model/call.dart';
import 'package:emergancy_call/model/car.dart';
import 'package:emergancy_call/model/location.dart';
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
        (reports ?? []).sort((a, b) => b.date.compareTo(a.date));
      }
      recentCalls = await getRecentCalls(type);
      (recentCalls ?? []).sort((a, b) => b.time.compareTo(a.time));
    } catch (e) {
      print(e);
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  _fetchPoliceReports() async {
    CollectionReference emergencyTypeRef = _firestore.collection("POLICE");

    QuerySnapshot reportsSnapshot = await emergencyTypeRef.get();
    List<Report> previousReport = [];
    for (var doc in reportsSnapshot.docs) {
      String title = doc['title'];
      String description = doc['description'];
      Timestamp dateTime = doc['date'];
      List<String> images = [];
      doc['images'].forEach((e) => images.add(e));
      List<String> injuries = [];
      doc['injuries'].forEach((e) => injuries.add(e));
      Location userLocation = Location.fromJson(doc['location']);
      List<Car> cars = [];
      if (doc['cars'] != null) {
        cars = (doc['cars'] as List<dynamic>)
            .map((e) => Car.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      Report report = Report(
          weather: doc['weather'] ?? "Cloudy",
          policeOfficer: doc['policeOfficer'],
          imagesUrl: images,
          location: userLocation,
          cars: cars,
          type: Formatter.stringToEmergencyType(type),
          title: title,
          description: description,
          injuries: injuries,
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
