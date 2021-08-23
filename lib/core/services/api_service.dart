import 'dart:async';
import 'dart:convert';

import 'package:ewallet_clover/core/functions/http_handler.dart';

class APIService {
  String _url = 'https://thesisemoney.000webhostapp.com/mobileWallet';

  Future<ResponseModel> signIn({String mobile, mpin}) async {
    return await requestHandler(
      url: '$_url/signIn',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'mobile': mobile,
        'mpin': mpin,
      }),
    );
  }

  Future<ResponseModel> getBalance({String mobile, mpin}) async {
    return await requestHandler(
      url: '$_url/getBalance',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'mobile': mobile,
      }),
    );
  }

  Future<ResponseModel> inquireMobileNumber({String mobileNumber}) async {
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

  Future<ResponseModel> validateMobileNumber({String mobileNumber}) async {
    return await requestHandler(
      url: '$_url/validateAccount',
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
      url: '$_url/registration',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "mobile": mobile,
        "mpin": mpin,
        "emailAdd": email,
        "firstname": firstName,
        if (middleName != '') "middleInitial": middleName,
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

  Future<ResponseModel> checkEmail({String email}) async {
    return await requestHandler(
      url: '$_url/inquireEmail',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
      }),
    );
  }

  Future<ResponseModel> fundTransfer({String amount, source, target, refID}) async {
    return await requestHandler(
      url: '$_url/FT',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "trnDescription": "Fund Transfer",
        "amount": amount,
        "sourceMobile": source,
        "targetMobile": target,
        "mobileRef": refID,
      }),
    );
  }
}
