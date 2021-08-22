import 'package:ewallet_clover/core/functions/http_handler.dart';
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
  bool _hasSecurityQuestion;
  // Balance
  bool _isBalanceLoading;
  double _totalBalance;
  double _availableBalance;
  // Others
  String _savedMobileNumber;
  bool _hasSavedMobileNumber;

  // User Details
  get userID => _userID;
  get mobile => _mobile;
  get firstName => _firstName;
  get middleName => _middleName;
  get lastName => _lastName;
  get gender => _gender;
  get dateOfBirth => _dateOfBirth;
  get maritalStatus => _maritalStatus;
  get createdDateTime => _createdDateTime;
  get hasSecurityQuestion => _hasSecurityQuestion;
  // Balance
  get isBalanceLoading => _isBalanceLoading;
  get totalBalance => _totalBalance;
  get availableBalance => _availableBalance;
  // Others
  get savedMobileNumber => _savedMobileNumber;
  get hasSavedMobileNumber => _hasSavedMobileNumber;
  set hasSavedMobileNumber(bool newValue) {
    _hasSavedMobileNumber = newValue;
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
  }

  Future<void> checkSavedMobileNumber() async {
    _hasSavedMobileNumber = await storage.containsKey(key: 'mobileNumber');
    _savedMobileNumber = await storage.read(key: 'mobileNumber');
    notifyListeners();
    print('checkSavedMobileNumber => hasSavedMobileNumber: $_hasSavedMobileNumber');
    print('checkSavedMobileNumber => savedMobileNumber: $_savedMobileNumber');
  }

  Future<void> saveMobileNumber({String mobileNumber}) async {
    storage.write(key: 'mobileNumber', value: mobileNumber);
    await checkSavedMobileNumber();
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
}