import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/model/history_model.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider extends ChangeNotifier {
  final APIService _apiService = new APIService();
  final storage = new FlutterSecureStorage();

  // User Details
  String _userID;
  String _mobile;
  String _firstName;
  String _middleName;
  String _lastName;
  String _gender;
  String _dateOfBirth;
  String _maritalStatus;
  String _createdDateTime;
  String _email;
  String _address;
  bool _hasSecurityQuestion;
  // Balance
  bool _isBalanceLoading;
  double _totalBalance;
  double _availableBalance;
  // History
  bool _isHistoryLoading;
  int _getHistoryStatus;
  List<HistoryModel> _historyItems = [];
  // Others
  String _savedUserAccountID;
  String _savedMobileNumber;
  String _savedMPIN;
  bool _hasSavedMobileNumber;
  bool _hasSavedMPIN;

  // User Details
  get userID => _userID;
  get mobileNumber => _mobile;
  get firstName => _firstName;
  get middleName => _middleName;
  get lastName => _lastName;
  get gender => _gender;
  get dateOfBirth => _dateOfBirth;
  get maritalStatus => _maritalStatus;
  get createdDateTime => _createdDateTime;
  get email => _email;
  get address => _address;
  get hasSecurityQuestion => _hasSecurityQuestion;
  // Balance
  get isBalanceLoading => _isBalanceLoading;
  get totalBalance => _totalBalance;
  get availableBalance => _availableBalance;
  // History
  get isHistoryLoading => _isHistoryLoading;
  get getHistoryStatus => _getHistoryStatus;
  List<HistoryModel> get historyItems => _historyItems;

  // Others
  get savedUserAccountID => _savedUserAccountID;
  set savedUserAccountID(String newValue) {
    _savedUserAccountID = newValue;
    notifyListeners();
  }

  get savedMobileNumber => _savedMobileNumber;
  get hasSavedMobileNumber => _hasSavedMobileNumber;
  set hasSavedMobileNumber(bool newValue) {
    _hasSavedMobileNumber = newValue;
    notifyListeners();
  }

  get savedMPIN => _savedMPIN;
  get hasSavedMPIN => _hasSavedMPIN;
  set hasSavedMPIN(bool newValue) {
    _hasSavedMPIN = newValue;
    notifyListeners();
  }

  void resetValue() {
    // User Details
    _userID = null;
    _mobile = null;
    _firstName = null;
    _middleName = null;
    _lastName = null;
    _gender = null;
    _dateOfBirth = null;
    _maritalStatus = null;
    _createdDateTime = null;
    _hasSecurityQuestion = null;
    // Balance
    _isBalanceLoading = false;
    _totalBalance = null;
    _availableBalance = null;
    // History
    _isHistoryLoading = false;
    _getHistoryStatus = 2;
    _historyItems = [];
  }

  Future<void> checkSavedUser() async {
    _hasSavedMobileNumber = await storage.containsKey(key: 'mobileNumber');
    _savedMobileNumber = await storage.read(key: 'mobileNumber');
    _hasSavedMPIN = await storage.containsKey(key: 'mpin');
    _savedMPIN = await storage.read(key: 'mpin');
    notifyListeners();
  }

  Future<void> saveMobileNumber({String mobileNumber}) async {
    storage.write(key: 'mobileNumber', value: mobileNumber);
    await checkSavedUser();
  }

  Future<void> saveMPIN({String mpin}) async {
    storage.write(key: 'mpin', value: mpin);
    await checkSavedUser();
  }

  Future<void> removeSavedUser({String mobileNumber}) async {
    storage.delete(key: 'mobileNumber');
    storage.delete(key: 'mpin');
    await checkSavedUser();
  }

  Future<void> deleteMPIN({String mobileNumber}) async {
    storage.delete(key: 'mpin');
    await checkSavedUser();
  }

  Future<ResponseModel> signIn({String mobile, mpin}) async {
    ResponseModel response = await _apiService.signIn(
      mobile: mobile,
      mpin: mpin,
    );

    if (response.resultCode == 00) {
      saveMobileNumber(mobileNumber: mobile);
      _userID = response.result['data']['userID'];
      _mobile = response.result['data']['mobile'];
      _firstName = response.result['data']['firstname'];
      _middleName = response.result['data']['middleInitial'];
      _lastName = response.result['data']['lastname'];
      _gender = response.result['data']['gender'];
      _dateOfBirth = response.result['data']['dateOfBirth'];
      _maritalStatus = response.result['data']['maritalStatus'];
      _createdDateTime = response.result['data']['createdDateTime'];
      _hasSecurityQuestion = response.result['data']['hasSecurityQuestion'];
      _email = response.result['data']['email'][0]['emailAdd'];
      _address = response.result['data']['address'][0]['fullAddress'];
    }
    return response;
  }

  Future<ResponseModel> getBalance() async {
    _isBalanceLoading = true;
    notifyListeners();
    ResponseModel response = await _apiService.getBalance(
      mobile: _mobile,
    );

    if (response.resultCode == 00) {
      _totalBalance = double.parse(response.result['data']['totalBalance']);
      _availableBalance = double.parse(response.result['data']['availableBalance']);
    }
    _isBalanceLoading = false;
    notifyListeners();
    return response;
  }

  Future<void> getTransactionHistory() async {
    _isHistoryLoading = true;
    _historyItems.clear();
    notifyListeners();
    ResponseModel response = await _apiService.getTransactionHistory(
      mobile: _mobile,
    );

    if (response.resultCode == 00) {
      for (var item in response.result['data']) {
        _historyItems.add(HistoryModel.fromJson(item));
      }
      if (_historyItems.length > 0) {
        _getHistoryStatus = 0; // Has items
      } else {
        _getHistoryStatus = 1; // No items
      }
    } else {
      _getHistoryStatus = 2; // Failed to load
    }
    _isHistoryLoading = false;
    notifyListeners();
  }
}
