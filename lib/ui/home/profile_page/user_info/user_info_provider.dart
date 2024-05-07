import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/model/user.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:flutter/material.dart';

class UserInfoProvider extends ChangeNotifier {
  final AuthStore authStore;

  bool _isUpdating = false;

  UserInfoProvider({required this.authStore});
  bool get isUpdating => _isUpdating;

  updateInfo(Map<String, dynamic> data) async {
    try {
      _isUpdating = true;
      notifyListeners();
      await authStore.updateUser(data);
      await updateUserDataOnFireStore(data);
    } catch (e) {
      print(e);
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  updateUserDataOnFireStore(Map<String, dynamic> data) async {
    User? user = await authStore.getUser();
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    await users.doc(user!.id).update(data);
  }
}
