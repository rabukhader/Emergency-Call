import 'dart:convert';

import 'package:emergancy_call/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore {
  AuthStore();

  static const String userKey = "USER";

  Future saveUser(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(userKey, jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userString = pref.getString(userKey);

    if (userString != null && userString.isNotEmpty) {
      return User.fromJson(jsonDecode(userString));
    }
    return null;
  }

  updateUser(Map<String, dynamic> data) async {
    User? user = await getUser();
    if (user != null) {
      user.userNumber = data['number'] ?? user.userNumber;
      user.gender = data['gender'] ?? user.gender;
      user.fullname = data['fullname'] ?? user.fullname;
      user.bloodType = data['bloodType'] ?? user.bloodType;
      user.nationalId = data['nationalId'] ?? user.nationalId;
      user.height =
          (data['height'] != null && data['height'].toString().trim() != '') ? int.parse(data['height']) : user.height;
      user.weight =
          data['weight'] != null  && data['weight'].toString().trim() != '' ? int.parse(data['weight']) : user.weight;
      user.medicalHistory = data['medicalHistory'] ?? user.medicalHistory;
      if (data['dateOfBirth'] != null ||
          data['dateOfBirth'] == DateTime.now().toString()) {
        user.dateOfBirth = DateTime.parse(data['dateOfBirth']);
      }
      await saveUser(user);
    }
  }
}
