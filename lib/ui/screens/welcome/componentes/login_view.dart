import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/dashboard/dashboard_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
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
        user.getBalance();
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.savedMobileNumber} | '),
            GestureDetector(
              onTap: () {
                user.hasSavedMobileNumber = false;
              },
              child: Text(
                'Not my number',
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
                  loadingDialog.hide();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
