import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  // Target
  String _targetName;
  String _targetMobileNumber;
  String _targetObscureMobileNumber;

  // Amount
  double _transferAmount;

  // Fields
  bool _isMobileFieldEnabled = true;
  bool _isAmountFieldEnabled = true;

  // Others
  bool _isFormValid = false;
  bool _isTransferSuccess = false;
  bool _isQRScanned = false;
  String _errorMessage;
  String _mobileRefID;
  String _coreRefID;
  String _transDateTime;

  get targetAccountNumber => _targetName;
  set targetAccountNumber(String newValue) {
    _targetName = newValue;
    notifyListeners();
  }

  get targetAccountObscureNumber => _targetObscureMobileNumber;
  set targetAccountObscureNumber(String newValue) {
    _targetObscureMobileNumber = newValue;
    notifyListeners();
  }

  get targetName => _targetName;
  set targetName(String newValue) {
    _targetName = newValue;
    notifyListeners();
  }

  get targetMobileNumber => _targetMobileNumber;
  set targetMobileNumber(String newValue) {
    _targetMobileNumber = newValue;
    notifyListeners();
  }

  get transferAmount => _transferAmount;
  set transferAmount(double newValue) {
    _transferAmount = newValue;
    notifyListeners();
  }

  get isMobileFieldEnabled => _isMobileFieldEnabled;
  set isMobileFieldEnabled(bool newValue) {
    _isMobileFieldEnabled = newValue;
    notifyListeners();
  }

  get isAmountFieldEnabled => _isAmountFieldEnabled;
  set isAmountFieldEnabled(bool newValue) {
    _isAmountFieldEnabled = newValue;
    notifyListeners();
  }

  get isFormValid => _isFormValid;
  set isFormValid(bool newValue) {
    _isFormValid = newValue;
    notifyListeners();
  }

  get isTransferSuccess => _isTransferSuccess;
  set isTransferSuccess(bool newValue) {
    _isTransferSuccess = newValue;
    notifyListeners();
  }

  get isQRScanned => _isQRScanned;
  set isQRScanned(bool newValue) {
    _isQRScanned = newValue;
    notifyListeners();
  }

  get errorMessage => _errorMessage;
  set errorMessage(String newValue) {
    _errorMessage = newValue;
    notifyListeners();
  }

  get mobileRefID => _mobileRefID;
  set mobileRefID(String newValue) {
    _mobileRefID = newValue;
    notifyListeners();
  }

  get coreRefID => _coreRefID;
  set coreRefID(String newValue) {
    _coreRefID = newValue;
    notifyListeners();
  }

  get transDateTime => _transDateTime;
  set transDateTime(String newValue) {
    _transDateTime = newValue;
    notifyListeners();
  }

  void resetValues() {
    _targetName = null;
    _targetObscureMobileNumber = null;
    _targetMobileNumber = null;

    // Amount
    _transferAmount = null;

    // Fields
    _isMobileFieldEnabled = true;
    _isAmountFieldEnabled = true;

    // Others
    _isFormValid = false;
    _isTransferSuccess = false;
    _isQRScanned = false;
    _errorMessage = null;
    _mobileRefID = null;
  }
}
