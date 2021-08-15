import 'dart:async';
import 'dart:convert';

import 'package:ewallet_clover/core/functions/http_handler.dart';

class APIService {
  String _url = 'https://thesisemoney.000webhostapp.com/mobileWallet';

  Future<ResponseModel> signIn({String username, password}) async {
    return await requestHandler(
      url: '$_url/signIn',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      }),
    );
  }

  Future<ResponseModel> checkMobileNumber({String mobileNumber}) async {
    return await requestHandler(
      url: '$_url/inquireMobile',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "mobile": mobileNumber,
      }),
    );
  }

  Future<ResponseModel> requestOTP({String mobileNumber}) async {
    return await requestHandler(
      url: '$_url/requestOTP',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "contactNumber": mobileNumber,
      }),
    );
  }

  Future<ResponseModel> validateOTP({String mobileNumber, otp}) async {
    return await requestHandler(
      url: '$_url/validateOTP',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "contactNumber": mobileNumber,
        "otp": otp,
      }),
    );
  }

  Future<ResponseModel> registration({String birthDate, email, mobile, mpin, firstName, middleName, lastName, gender, maritalStatus, deviceModel, deviceID, fullAddress}) async {
    return await requestHandler(
      url: '$_url/requestOTP',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "mobile": mobile,
        "mpin": mpin,
        "emailAdd": email,
        "firstname": firstName,
        "middleInitial": middleName,
        "lastname": lastName,
        "dateOfBirth": birthDate,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "fullAddress": fullAddress,
        "model": deviceModel,
        "imei": deviceID,
      }),
    );
  }
}