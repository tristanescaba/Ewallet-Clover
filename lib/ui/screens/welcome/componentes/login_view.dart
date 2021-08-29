import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/dashboard/dashboard_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();
  final _pinPutController = new TextEditingController();
  final _pinPutFocusNode = new FocusNode();
  final BoxDecoration _pinPutDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(color: kPrimaryColor),
    color: Colors.grey[100],
  );

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    Future<bool> signIn({String mpin}) async {
      ResponseModel response = await user.signIn(
        mobile: user.savedMobileNumber,
        mpin: mpin,
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

    Future<void> biometricsLogin() async {
      Future<bool> _isAuthenticated = auth.authenticateWithBiometrics(
        localizedReason: 'Authenticate to log in.',
        useErrorDialogs: true,
        stickyAuth: true,
      );
      if (await _isAuthenticated) {
        loadingDialog.show();
        if (await signIn(mpin: user.savedMPIN)) {
          user.getBalance();
          user.getTransactionHistory();
          loadingDialog.hide();
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
        }
      }
    }

    return StateWrapper(
      initState: () async {
        if (user.hasSavedMPIN) {
          await biometricsLogin();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kScreenPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${user.savedMobileNumber}'),
                        Text('  |  ', style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w300)),
                        GestureDetector(
                          onTap: () {
                            user.hasSavedMobileNumber = false;
                          },
                          child: Text(
                            'Change number',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(kScreenPadding),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: PinPut(
                          fieldsCount: 6,
                          autofocus: true,
                          obscureText: '•',
                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          selectedFieldDecoration: _pinPutDecoration,
                          followingFieldDecoration: _pinPutDecoration,
                          submittedFieldDecoration: _pinPutDecoration,
                          onSubmit: (String pin) async {
                            loadingDialog.show();
                            if (await signIn(mpin: pin)) {
                              user.getBalance();
                              user.getTransactionHistory();
                              loadingDialog.hide();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        user.hasSavedMobileNumber = false;
                      },
                      child: Text(
                        'Forgot MPIN',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (user.hasSavedMPIN)
            SafeArea(
              child: GestureDetector(
                onTap: () async {
                  await biometricsLogin();
                },
                child: Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Text('Use Biometrics'),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
