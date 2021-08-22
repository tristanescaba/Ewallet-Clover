import 'dart:async';
import 'dart:ui';

import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPView extends StatefulWidget {
  final String title;
  final String mobileNumber;
  final Function onSuccess;

  const OTPView({
    this.title = 'One-Time PIN',
    this.mobileNumber,
    this.onSuccess,
  });

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final APIService _apiService = new APIService();
  final _pinPutController = new TextEditingController();
  final _pinPutFocusNode = new FocusNode();
  Timer _timer;
  int _remaining = 0;

  void startTimer() {
    _remaining = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_remaining == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _remaining--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingDialog = MyLoadingDialog(context);
    final BoxDecoration _pinPutDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(color: kPrimaryColor),
      color: Colors.grey[100],
    );

    Future<bool> requestOTP() async {
      loadingDialog.show(message: 'Requesting OTP...');
      final ResponseModel response = await _apiService.requestOTP(mobileNumber: widget.mobileNumber);

      if (response.resultCode == 00) {
        loadingDialog.hide();
        return true;
      } else {
        loadingDialog.hide();
        await showDialog(
          context: context,
          child: MyDialog(
            title: response.title,
            message: response.message,
            button1Title: 'Okay',
            hasError: response.hasError,
          ),
        );
        return false;
      }
    }

    Future<bool> validateOTP({String otp}) async {
      loadingDialog.show(message: 'Validating OTP...');
      final ResponseModel response = await _apiService.validateOTP(mobileNumber: widget.mobileNumber, otp: otp);

      if (response.resultCode == 00) {
        loadingDialog.hide();
        return true;
      } else {
        loadingDialog.hide();
        await showDialog(
          context: context,
          child: MyDialog(
            title: response.title,
            message: response.message,
            button1Title: 'Okay',
            hasError: response.hasError,
          ),
        );
        return false;
      }
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kScreenPadding, horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 30.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'An OTP was sent to: ${widget.mobileNumber.toString().substring(0, 4)}****${widget.mobileNumber.toString().substring(widget.mobileNumber.toString().length - 3, widget.mobileNumber.toString().length)}',
                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 40.0),
                  PinPut(
                    fieldsCount: 6,
                    autofocus: true,
                    mainAxisSize: MainAxisSize.max,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration,
                    submittedFieldDecoration: _pinPutDecoration,
                    onSubmit: (String pin) async {
                      if (await validateOTP(otp: pin)) {
                        await widget.onSuccess();
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn\'t get the OTP? ',
                      ),
                      _remaining == 0
                          ? FlatButton(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                'Tap to resend',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              onPressed: () async {
                                if (await requestOTP()) {
                                  startTimer();
                                }
                              },
                            )
                          : FlatButton(
                              padding: EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Resend in ',
                                  ),
                                  Text('${_remaining}s'),
                                ],
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
