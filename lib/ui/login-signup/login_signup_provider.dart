import 'package:emergancy_call/provider/base.dart';

class AuthProvider extends BaseChangeNotifier {
  bool _isLoggingIn = false;

  bool get isLoggingIn => _isLoggingIn;

  Future<bool> login() async {
    try {
      _isLoggingIn = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 3));
      return true;
    } catch (e) {
      return false;
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

  Future<bool> signUp() async {
    try {
      _isLoggingIn = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 3));
      return true;
    } catch (e) {
      return false;
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }
}
