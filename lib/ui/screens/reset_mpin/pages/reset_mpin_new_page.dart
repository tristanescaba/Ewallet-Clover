import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/registration_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/screens/welcome/welcome_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetMPINNewPage extends StatefulWidget {
  final PageController pageController;
  const ResetMPINNewPage({
    this.pageController,
  });

  @override
  _ResetMPINNewPageState createState() => _ResetMPINNewPageState();
}

class _ResetMPINNewPageState extends State<ResetMPINNewPage> {
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
    final user = Provider.of<UserProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    Future<bool> resetMPIN() async {
      final ResponseModel response = await _apiService.resetMPIN(
        mobile: user.savedMobileNumber,
        mpin: registration.mpin,
        token: registration.answerToken,
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
                        title: 'Input New MPIN',
                        controller: _mpinFieldController,
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please input your new MPIN.";
                          } else if (value.length != 6) {
                            return "MPIN must be 6 digits.";
                          }
                        },
                      ),
                      MyTextField(
                        title: 'Confirm New MPIN',
                        controller: _confirmMpinFieldController,
                        prefixIcon: Icons.lock,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
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
                title: 'Update MPIN',
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState.validate()) {
                    registration.mpin = _mpinFieldController.text;
                    loadingDialog.show();
                    if (await resetMPIN()) {
                      loadingDialog.hide();
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        child: MyDialog(
                          title: 'MPIN Reset',
                          message: 'Your MPIN was successfully reset, Please log in.',
                          button1Title: 'Okay',
                          button1Function: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()), (Route<dynamic> route) => false);
                          },
                        ),
                      );
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
