import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final AuthStore authStore;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  User? userData;

  ProfileProvider({required this.authStore}) {
    init();
  }

  void init() async {
    try {
      _isLoading = true;
      notifyListeners();
      userData = await authStore.getUser();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String? get getEmail => userData?.email;

  int? get getPhone => userData?.userNumber;
}
