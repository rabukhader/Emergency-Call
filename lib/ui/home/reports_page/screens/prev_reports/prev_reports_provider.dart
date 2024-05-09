import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/location.dart';
import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:emergancy_call/utils/formatter.dart';
import 'package:flutter/material.dart';

class PreviousReportsProvider extends ChangeNotifier {
  final AuthStore authStore;
  Location? userLocation;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Report>? previousReports;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  PreviousReportsProvider({required this.authStore}) {
    init();
  }

  init() async {
    await getPreviousReports();
  }

  getPreviousReports() async {
    try {
      _isFetching = true;
      notifyListeners();
      User? user = await authStore.getUser();
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('user').doc(user?.id ?? "");
      CollectionReference reportsRef = userRef.collection('reports');
      QuerySnapshot reportsSnapshot = await reportsRef.get();
      List<Report> previousReport = [];
      for (var doc in reportsSnapshot.docs) {
        String title = doc['title'];
        String description = doc['description'];
        Timestamp dateTime = doc['date'];
        List<String> images = [];
        if (doc['images'] != null && doc['images'] is List) {
          (doc['images']).forEach(( value) {
            images.add(value);
          });
        }
        print(images);
        Location userLocation = Location.fromJson(doc['location']);
        EmergencyType type = Formatter.stringToEmergencyType(doc['type']);
        Report report = Report(
            imagesUrl: images,
            location: userLocation,
            type: type,
            title: title,
            description: description,
            date: Formatter.convertTimestampToDateTime(dateTime));
        previousReport.add(report);
      }
      previousReports = previousReport;
    } catch (e) {
      print(e);
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }
}
