import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQRScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My QR Code'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: kCardDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(kScreenPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  gradient: kLinearGradient,
                ),
                child: Text(
                  '${user.firstName}\'s QR Code'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'DigiWallet',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = kShaderGradient,
                ),
              ),
              SizedBox(height: 18.0),
              Center(
                child: QrImage(
                  data: '{"name":"${user.firstName} ${user.lastName}","mobileNumber":"${user.mobileNumber}"}',
                  size: 275.0,
                  version: 4,
                ),
              ),
              SizedBox(height: 18.0),
              Text(
                '${user.mobileNumber.toString().substring(0, 4)}****${user.mobileNumber.toString().substring(user.mobileNumber.toString().length - 3, user.mobileNumber.toString().length)}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 47.0),
            ],
          ),
        ),
      ),
    );
  }
}
