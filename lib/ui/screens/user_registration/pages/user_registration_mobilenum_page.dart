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

class UserRegistrationMobileNumPage extends StatefulWidget {
  final PageController pageController;
  const UserRegistrationMobileNumPage({
    this.pageController,
  });

  @override
  _UserRegistrationMobileNumPageState createState() => _UserRegistrationMobileNumPageState();
}

class _UserRegistrationMobileNumPageState extends State<UserRegistrationMobileNumPage> {
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
    final registration = Provider.of<RegistrationProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    Future<bool> checkMobileNumber() async {
      final ResponseModel response = await _apiService.inquireMobileNumber(mobileNumber: registration.mobileNumber);

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

    Future<bool> requestOTP() async {
      final ResponseModel response = await _apiService.requestOTP(mobileNumber: registration.mobileNumber);

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
                    title: 'Mobile Number',
                    prefixText: '+63',
                    controller: _mobileFieldController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    counterVisible: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please input mobile number.";
                      } else if (value.length != 10 || value.substring(0, 1) != "9") {
                        return "Mobile number is not valid.";
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
                title: 'Next',
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState.validate()) {
                    registration.mobileNumber = '0${_mobileFieldController.text}';
                    loadingDialog.show(message: 'Validating...');
                    if (await checkMobileNumber()) {
                      if (await requestOTP()) {
                        loadingDialog.hide();
                        widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                      }
                    }
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
