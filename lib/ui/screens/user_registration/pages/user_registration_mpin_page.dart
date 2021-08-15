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

class UserRegistrationMPINPage extends StatefulWidget {
  final PageController pageController;
  const UserRegistrationMPINPage({
    this.pageController,
  });

  @override
  _UserRegistrationMPINPageState createState() => _UserRegistrationMPINPageState();
}

class _UserRegistrationMPINPageState extends State<UserRegistrationMPINPage> {
  final APIService _apiService = new APIService();
  final _formKey = GlobalKey<FormState>();
  final _mpinFieldController = TextEditingController();
  final _confirmMpinFieldController = TextEditingController();

  @override
  void dispose() {
    _mpinFieldController.dispose();
    _confirmMpinFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registration = Provider.of<RegistrationProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    Future<bool> registerUser() async {
      final ResponseModel response = await _apiService.registration(
        mobile: registration.mobileNumber,
        mpin: registration.mpin,
        email: registration.email,
        firstName: registration.firstName,
        middleName: registration.middleName,
        lastName: registration.lastName,
        birthDate: registration.birthDate,
        gender: registration.gender,
        maritalStatus: registration.maritalStatus,
        fullAddress: registration.fullAddress,
        deviceModel: '',
        deviceID: '',
      );

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
                  child: Column(
                    children: [
                      MyTextField(
                        title: 'Input MPIN',
                        controller: _mpinFieldController,
                        prefixIcon: Icons.lock,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please input your desired MPIN.";
                          } else if (value.length != 6) {
                            return "MPIN must be 6 digits.";
                          }
                        },
                      ),
                      MyTextField(
                        title: 'Confirm MPIN',
                        controller: _confirmMpinFieldController,
                        prefixIcon: Icons.lock,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please retype your MPIN.";
                          } else if (value.length != 6) {
                            return "MPIN must be 6 digits.";
                          } else if (value != _mpinFieldController.text) {
                            return "MPIN didn\'t matched.";
                          }
                        },
                      ),
                    ],
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
                title: 'Register',
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState.validate()) {
                    registration.mpin = _mpinFieldController.text;
                    loadingDialog.show();
//                    if (await registerUser()) {
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
