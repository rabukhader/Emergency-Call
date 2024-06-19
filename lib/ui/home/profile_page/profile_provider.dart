import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/model/car.dart';
import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final AuthStore authStore;
  final String userType;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  User? userData;
  Car? userCar;

  ProfileProvider({required this.authStore, required this.userType}) {
    init();
  }

  Future<void> init() async {
    try {
      _isLoading = true;
      notifyListeners();
      userData = await authStore.getUser();
      if (userType == "default") {
        await fetchUserCar();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String? get getEmail => userData?.email;

  int? get getPhone => userData?.userNumber;

  String? get getGender => userData?.gender;

  Future<void> refreshData() async {
    await init();
  }

  fetchUserCar() async {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    DocumentSnapshot user = await users.doc(userData!.id).get();
    Map userMap = user.data() as Map<String, dynamic>;
    userCar = Car.fromJson({
      "isGuranteed": userMap['isGuranteed'],
      "carName": userMap['carName'],
      "carYearModel": userMap['carYearModel'],
      "carNumber": userMap['carNumber'],
      "insuranceCompany": userMap['insuranceCompany']
    });
  }
}
