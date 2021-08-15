import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  // Target
  int _targetCID;
  int _targetInstiCode;
  bool _targetIsRegistered;
  bool _targetAccountIsEnabled = false;
  String _targetQrID;
  String _targetBank;
  String _targetMobileNumber;
  String _targetSavingsToken;
  String _targetAccountHolder;
  String _targetAccountName;
  String _targetAccountNumber;
  String _targetAccountObscureNumber;

  // Amount
  double _transferAmount;
  double _minTransferAmount = 100;
  double _maxTransferAmount = 50000;
  double _totalCharge = 0;
  double _agentIncome = 0;
  double _bankIncome = 0;

  // Fields
  bool _isBankFieldEnabled = true;
  bool _isAccountFieldEnabled = true;
  bool _isAmountFieldEnabled = true;

  // Others
  bool _isFormValid = false;
  bool _isTransferSuccess = false;
  bool _isQRScanned = false;
  bool _soteriaHasError;
  String _errorMessage;
  String _transferRefID;
  String _string1;
  String _string2;
  String _string3;

  get targetCID => _targetCID;
  set targetCID(int newValue) {
    _targetCID = newValue;
    notifyListeners();
  }

  get targetInstiCode => _targetInstiCode;
  set targetInstiCode(int newValue) {
    _targetInstiCode = newValue;
    notifyListeners();
  }

  get targetQrID => _targetQrID;
  set targetQrID(String newValue) {
    _targetQrID = newValue;
    notifyListeners();
  }

  get targetIsRegistered => _targetIsRegistered;
  set targetIsRegistered(bool newValue) {
    _targetIsRegistered = newValue;
    notifyListeners();
  }

  get targetAccountIsEnabled => _targetAccountIsEnabled;
  set targetAccountIsEnabled(bool newValue) {
    _targetAccountIsEnabled = newValue;
    notifyListeners();
  }

  get targetBank => _targetBank;
  set targetBank(String newValue) {
    _targetBank = newValue;
    notifyListeners();
  }

  get targetAccountHolder => _targetAccountHolder;
  set targetAccountHolder(String newValue) {
    _targetAccountHolder = newValue;
    notifyListeners();
  }

  get targetAccountName => _targetAccountName;
  set targetAccountName(String newValue) {
    _targetAccountName = newValue;
    notifyListeners();
  }

  get targetAccountNumber => _targetAccountNumber;
  set targetAccountNumber(String newValue) {
    _targetAccountNumber = newValue;
    notifyListeners();
  }

  get targetAccountObscureNumber => _targetAccountObscureNumber;
  set targetAccountObscureNumber(String newValue) {
    _targetAccountObscureNumber = newValue;
    notifyListeners();
  }

  get targetMobileNumber => _targetMobileNumber;
  set targetMobileNumber(String newValue) {
    _targetMobileNumber = newValue;
    notifyListeners();
  }

  get targetAccountToken => _targetSavingsToken;
  set targetAccountToken(String newValue) {
    _targetSavingsToken = newValue;
    notifyListeners();
  }

  get transferAmount => _transferAmount;
  set transferAmount(double newValue) {
    _transferAmount = newValue;
    notifyListeners();
  }

  get minTransferAmount => _minTransferAmount;
  set minTransferAmount(double newValue) {
    _minTransferAmount = newValue;
    notifyListeners();
  }

  get maxTransferAmount => _maxTransferAmount;
  set maxTransferAmount(double newValue) {
    _maxTransferAmount = newValue;
    notifyListeners();
  }

  get totalCharge => _totalCharge;
  set totalCharge(double newValue) {
    _totalCharge = newValue;
    notifyListeners();
  }

  get bankIncome => _bankIncome;
  set bankIncome(double newValue) {
    _bankIncome = newValue;
    notifyListeners();
  }

  get agentIncome => _agentIncome;
  set agentIncome(double newValue) {
    _agentIncome = newValue;
    notifyListeners();
  }

  get isBankFieldEnabled => _isBankFieldEnabled;
  set isBankFieldEnabled(bool newValue) {
    _isBankFieldEnabled = newValue;
    notifyListeners();
  }

  get isAccountFieldEnabled => _isAccountFieldEnabled;
  set isAccountFieldEnabled(bool newValue) {
    _isAccountFieldEnabled = newValue;
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

  get soteriaHasError => _soteriaHasError;
  set soteriaHasError(bool newValue) {
    _soteriaHasError = newValue;
    notifyListeners();
  }

  get errorMessage => _errorMessage;
  set errorMessage(String newValue) {
    _errorMessage = newValue;
    notifyListeners();
  }

  get transferRefID => _transferRefID;
  set transferRefID(String newValue) {
    _transferRefID = newValue;
    notifyListeners();
  }

  get string1 => _string1;
  set string1(String newValue) {
    _string1 = newValue;
    notifyListeners();
  }

  get string2 => _string2;
  set string2(String newValue) {
    _string2 = newValue;
    notifyListeners();
  }

  get string3 => _string3;
  set string3(String newValue) {
    _string3 = newValue;
    notifyListeners();
  }

  void resetValues() {
    // Source
//    _sourceAccountName = selectedSavings.name;
//    _sourceAccountNumber = selectedSavings.number;
//    _sourceAccountToken = selectedSavings.token;
//    _sourceAccountAvailableBalance = selectedSavings.availableBalance;
//    _sourceAccountTotalBalance = selectedSavings.totalBalance;

    // Target
    _targetCID = null;
    _targetInstiCode = null;
    _targetBank = null;
    _targetAccountHolder = null;
    _targetAccountNumber = null;
    _targetAccountObscureNumber = null;
    _targetMobileNumber = null;
    _targetSavingsToken = null;

    // Amount
    _transferAmount = null;
    _minTransferAmount = 100;
    _maxTransferAmount = 50000;
    _totalCharge = 0;
    _agentIncome = 0;
    _bankIncome = 0;

    // Fields
    _isBankFieldEnabled = true;
    _isAccountFieldEnabled = true;
    _isAmountFieldEnabled = true;

    // Others
    _isFormValid = false;
    _isTransferSuccess = false;
    _isQRScanned = false;
    _errorMessage = null;
    _transferRefID = null;
  }
}
