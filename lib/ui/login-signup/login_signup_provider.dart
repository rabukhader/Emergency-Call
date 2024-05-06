import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy_call/services/auth_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emergancy_call/model/user.dart' as e_user;
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthStore authStore;
  bool _isLoggingIn = false;

  AuthProvider({required this.authStore});

  bool get isLoggingIn => _isLoggingIn;

  Future<String> login(String email, String password) async {
    try {
      _isLoggingIn = true;
      notifyListeners();
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await _saveLoginInfo(user.user?.uid ?? "", email, password);
      return "pass";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        return 'Invalid Credintials';
      } else {
        return "Something went wrong, Please try again";
      }
    } catch (e) {
      return e.toString();
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

  Future<String> signUp(
      String email, String password, int phoneNumber, String gender) async {
    try {
      _isLoggingIn = true;
      notifyListeners();
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CollectionReference userCollectionRef =
          FirebaseFirestore.instance.collection('user');
      await userCollectionRef
          .doc(user.user?.uid ?? "")
          .set({"number": phoneNumber, "gender": gender});

      await _saveLoginInfo(user.user?.uid ?? "", email, password);
      return "pass";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return "Something went wrong, Please try again";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

  _saveLoginInfo(String id, String email, String password) async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('user').doc(id);
    DocumentSnapshot documentSnapshot = await userDocRef.get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    await authStore.saveUser(e_user.User(
        id: id,
        email: email,
        password: password,
        userNumber: data['number'],
        gender: data['gender']));
  }
}
