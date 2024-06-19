import 'dart:io';

import 'package:emergancy_call/model/car.dart';
import 'package:emergancy_call/model/location.dart';
import 'package:emergancy_call/model/report.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/utils/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class AddNewReportProvider extends ChangeNotifier {
  final AuthStore authStore;

  List<Car>? cars;

  Location? userLocation;

  bool _isAdding = false;

  bool get isAdding => _isAdding;
  AddNewReportProvider({required this.authStore}) {
    init();
  }

  void init() async {
    userLocation = await getLocation();
  }

  Future getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Use the position data as needed
    return Location(longitude: position.longitude, latitude: position.latitude);
  }

  Future<void> addNewReport(Report report) async {
    try {
      _isAdding = true;
      notifyListeners();
      await addReportToPolice(report);
    } catch (e) {
      print(e);
    } finally {
      _isAdding = false;
      notifyListeners();
    }
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

  addReportToPolice(Report report) async {
    report.location = userLocation;
    CollectionReference emergencyTypeRef =
        FirebaseFirestore.instance.collection("POLICE");
    emergencyTypeRef.add(report.toJson());
  }

  Future<String> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final projectLogo = File(pickedFile.path);
      String url = await uploadImageToStorage(projectLogo);
      return url;
    } else {
      print('not used correctly');
      return "false";
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('cars/${DateTime.now()}.png');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    await uploadTask.whenComplete(() {});
    final imageUrl = await storageRef.getDownloadURL();
    return imageUrl;
  }
}
