import 'package:emergancy_call/provider/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseChangeNotifier {
  bool _isLoggingIn = false;

  bool get isLoggingIn => _isLoggingIn;

  Future<String> login(String email, String password) async {
    try {
      _isLoggingIn = true;
      notifyListeners();
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await _saveLoginInfo(email, password);
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

  Future<String> signUp(String email, String password) async {
    try {
      _isLoggingIn = true;
      notifyListeners();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveLoginInfo(email, password);
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
      return e.toString();
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

  _saveLoginInfo(String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("USEREMAIL", email);
    await pref.setString("USERPASSWORD", password);
  }
}
