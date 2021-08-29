import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ewallet_clover/core/functions/check_internet.dart';
import 'package:http/http.dart' as http;

Future<ResponseModel> requestHandler({String url, Map<String, String> headers, dynamic body, bool isGet}) async {
  if (await checkInternet()) {
    try {
      http.Response response;
      if (isGet != null && isGet) {
        response = await http.get(url, headers: headers).timeout(Duration(minutes: 1));
      } else {
        response = await http.post(url, headers: headers, body: body).timeout(Duration(minutes: 1));
      }

      var utf8Body;
      try {
        utf8Body = jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {
        utf8Body = null;
      }

      print('');
      print('- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -');
      print('// URL: $url');
      print('// HEADER: $headers');
      print('// REQUEST: $body');
      print('// STATUS: ${response.statusCode}');
      print('// RESPONSE: $utf8Body');
      print('- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -');
      print('');

      if (response.statusCode == 200) {
        if (utf8Body['retCode'] == '00') {
          return ResponseModel(
            resultCode: 00,
            title: 'Success',
            message: utf8Body['message'],
            result: utf8Body,
            hasError: false,
          );
        } else {
          return ResponseModel(
            resultCode: 01,
            title: 'Failed',
            message: utf8Body['message'],
            result: utf8Body,
            hasError: false,
          );
        }
      } else {
        return ResponseModel(
          resultCode: 90,
          title: 'Uncaught Error',
          message: 'Something went wrong, Please try again later.',
          result: utf8Body,
          hasError: true,
        );
      }
    } on TimeoutException catch (e) {
      return ResponseModel(
        resultCode: 97,
        title: 'Request Timeout',
        message: 'Looks like the server is taking to long to respond, Please try again.',
        result: e.toString(),
        hasError: false,
      );
    } on SocketException catch (e) {
      return ResponseModel(
        resultCode: 98,
        title: 'Server Error',
        message: 'Can\'t connect to server, this may be caused by either poor connectivity or an error with our servers.',
        result: e.toString(),
        hasError: true,
      );
    } on Error catch (e) {
      return ResponseModel(
        resultCode: 99,
        title: 'Uncaught Error',
        message: 'Something went wrong, Please try again later.',
        result: e.toString(),
        hasError: true,
      );
    }
  } else {
    return ResponseModel(
      resultCode: 100,
      title: 'Internet Error',
      message: 'Looks like you have an unstable network at the moment, please try again when network stabilizes.',
      result: null,
      hasError: false,
    );
  }
}

class ResponseModel {
  final dynamic result;
  final int resultCode;
  final String message;
  final String title;
  final bool hasError;

  ResponseModel({
    this.result,
    this.hasError,
    this.resultCode,
    this.title,
    this.message,
  });
}
