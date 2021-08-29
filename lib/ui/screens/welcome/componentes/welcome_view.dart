import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/registration_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/screens/user_registration/user_registration_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final APIService _apiService = new APIService();
  final _formKey = GlobalKey<FormState>();
  final _mobileFieldController = TextEditingController();

  @override
  void dispose() {
    _mobileFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final registration = Provider.of<RegistrationProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    Future<bool> requestOTP() async {
      loadingDialog.show(message: 'Requesting OTP...');
      final ResponseModel response = await _apiService.requestOTP(mobileNumber: registration.mobileNumber);

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

    Future<void> checkMobileNumber() async {
      final ResponseModel response = await _apiService.inquireMobileNumber(mobileNumber: registration.mobileNumber);

      if (response.resultCode == 00) {
        loadingDialog.hide();
        await showDialog(
          context: context,
          child: MyDialog(
            title: 'Account Activation',
            message: 'This number is not yet registered, would you like to activate this number?',
            button1Title: 'Let\'s go!',
            button2Title: 'Not now',
            button1Function: () async {
              Navigator.pop(context);
              if (await requestOTP()) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistrationScreen()));
              }
            },
          ),
        );
      } else if (response.resultCode == 01) {
        await user.saveMobileNumber(mobileNumber: registration.mobileNumber);
        loadingDialog.hide();
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
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(kScreenPadding),
        child: Column(
          children: [
            Text(
              'Enter your mobile number to log in or activate if the number is not yet registered.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30.0),
            Form(
              key: _formKey,
              child: MyTextField(
                prefixText: '+63',
                maxLength: 10,
                controller: _mobileFieldController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please input mobile number.";
                  } else if (value.length != 10 || value.substring(0, 1) != "9") {
                    return "Mobile number is not valid.";
                  }
                },
              ),
            ),
            Spacer(),
            GradientButton(
              title: 'Proceed',
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  registration.resetValue();
                  registration.mobileNumber = '0${_mobileFieldController.text}';
                  loadingDialog.show(message: 'Validating...');
                  await checkMobileNumber();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
