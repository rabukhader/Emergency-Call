import 'dart:async';

import 'package:flutter/foundation.dart';

enum _NetworkStatus { loading, done }

abstract class BaseChangeNotifier extends ChangeNotifier {
  /// Indicates that ChangeNotifier is disposed or not.
  bool _disposed = false;

  /// Used along with network calls.
  /// to identify current network status.
  _NetworkStatus? _status;

  /// Errors.
  dynamic _error;

  StreamSubscription? baseStreamSubscription;

  @override
  void dispose() {
    _disposed = true;
    baseStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  void setError(dynamic error) {
    if (kDebugMode) {
      print("BaseChangeNotifier: setError: ${error.toString()}");
    }
    _error = error;
  }

  void hideError() {
    _error = null;
  }

  void setLoading([bool notify = true]) {
    _status = _NetworkStatus.loading;
    hideError();
    if (notify) {
      notifyListeners();
    }
  }

  void hideLoading() {
    _status = _NetworkStatus.done;
    notifyListeners();
  }

  dynamic get error => _error;

  bool isLoading() => _status == _NetworkStatus.loading;

  bool isError() => _error != null;

  bool isDone() => !isLoading() && !isError();
}