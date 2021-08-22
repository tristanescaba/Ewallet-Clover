import 'package:flutter/material.dart';

class SharedProvider extends ChangeNotifier {
  bool _isAppInitiated = false;

  get isAppInitiated => _isAppInitiated;
  set isAppInitiated(bool newValue) {
    _isAppInitiated = newValue;
    notifyListeners();
  }
}
