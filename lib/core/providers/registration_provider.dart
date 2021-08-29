import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  String _email;
  String _mobileNumber;
  String _mpin;
  String _firstName;
  String _middleName;
  String _lastName;
  String _birthDate;
  String _gender;
  String _maritalStatus;
  String _fullAddress;
  String _deviceModel;
  String _deviceID;
  String _answerToken;

  void resetValue() {
    _mobileNumber = null;
    _mpin = null;
    _email = null;
    _firstName = null;
    _middleName = null;
    _lastName = null;
    _gender = null;
    _birthDate = null;
    _maritalStatus = null;
    _fullAddress = null;
    _deviceModel = null;
    _deviceID = null;
    _answerToken = null;
  }

  get email => _email;
  set email(String newValue) {
    _email = newValue;
    notifyListeners();
  }

  get mobileNumber => _mobileNumber;
  set mobileNumber(String newValue) {
    _mobileNumber = newValue;
    notifyListeners();
  }

  get mpin => _mpin;
  set mpin(String newValue) {
    _mpin = newValue;
    notifyListeners();
  }

  get firstName => _firstName;
  set firstName(String newValue) {
    _firstName = newValue;
    notifyListeners();
  }

  get middleName => _middleName;
  set middleName(String newValue) {
    _middleName = newValue;
    notifyListeners();
  }

  get lastName => _lastName;
  set lastName(String newValue) {
    _lastName = newValue;
    notifyListeners();
  }

  get birthDate => _birthDate;
  set birthDate(String newValue) {
    _birthDate = newValue;
    notifyListeners();
  }

  get gender => _gender;
  set gender(String newValue) {
    _gender = newValue;
    notifyListeners();
  }

  get maritalStatus => _maritalStatus;
  set maritalStatus(String newValue) {
    _maritalStatus = newValue;
    notifyListeners();
  }

  get fullAddress => _fullAddress;
  set fullAddress(String newValue) {
    _fullAddress = newValue;
    notifyListeners();
  }

  get deviceModel => _deviceModel;
  set deviceModel(String newValue) {
    _deviceModel = newValue;
    notifyListeners();
  }

  get deviceID => _deviceID;
  set deviceID(String newValue) {
    _deviceID = newValue;
    notifyListeners();
  }

  get answerToken => _answerToken;
  set answerToken(String newValue) {
    _answerToken = newValue;
    notifyListeners();
  }
}
