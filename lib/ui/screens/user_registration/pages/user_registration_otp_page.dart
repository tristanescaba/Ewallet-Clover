import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/registration_provider.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRegistrationOTPPage extends StatefulWidget {
  final PageController pageController;
  const UserRegistrationOTPPage({
    this.pageController,
  });

  @override
  _UserRegistrationOTPPageState createState() => _UserRegistrationOTPPageState();
}

class _UserRegistrationOTPPageState extends State<UserRegistrationOTPPage> {
  final APIService _apiService = new APIService();
  final _formKey = GlobalKey<FormState>();
  final _otpFieldController = TextEditingController();

  @override
  void dispose() {
    _otpFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registration = Provider.of<RegistrationProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    Future<bool> validateOTP() async {
      final ResponseModel response = await _apiService.validateOTP(mobileNumber: registration.mobileNumber, otp: _otpFieldController.text);

      if (response.resultCode == 00) {
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

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kScreenPadding),
                child: Form(
                  key: _formKey,
                  child: MyTextField(
                    title: 'OTP Code',
                    controller: _otpFieldController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    obscureText: true,
                    counterVisible: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please input OTP code.";
                      } else if (value.length != 6) {
                        return "Please complete the input of OTP code.";
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kScreenPadding),
            child: Container(
              height: 50.0,
              child: GradientButton(
                title: 'Validate',
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState.validate()) {
                    loadingDialog.show();
//                    if (await validateOTP()) {
                      loadingDialog.hide();
                      widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
//                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
