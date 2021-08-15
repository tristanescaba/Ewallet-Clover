import 'dart:ui';

import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class MPINView extends StatefulWidget {
  final String title;
  final bool forSettings;
  final Function onSuccess;

  const MPINView({
    this.title = 'Enter your MPIN',
    this.forSettings = false,
    this.onSuccess,
  });

  @override
  _MPINViewState createState() => _MPINViewState();
}

class _MPINViewState extends State<MPINView> {
  final _pinPutController = new TextEditingController();
  final _pinPutFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final BoxDecoration _pinPutDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      border: Border.all(color: kPrimaryColor),
    );

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kScreenPadding),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100.0),
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 75.0),
                    child: PinPut(
                      fieldsCount: 6,
                      autofocus: true,
                      obscureText: '',
                      eachFieldConstraints: BoxConstraints(minWidth: 22.0, minHeight: 20.0),
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      selectedFieldDecoration: _pinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration,
                      submittedFieldDecoration: _pinPutDecoration.copyWith(
                        color: kPrimaryLightColor,
                      ),
                      onSubmit: (String pin) async {
                        await widget.onSuccess();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
