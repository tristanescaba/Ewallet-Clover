import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/dashboard/dashboard_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[kPrimaryLightColor, kPrimaryColor],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  final _formKey = GlobalKey<FormState>();
  final _mobileNumberController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    Future<bool> signIn() async {
      ResponseModel response = await user.signIn(
        mobile: _mobileNumberController.text,
        mpin: _pinController.text,
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

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kScreenPadding),
          child: Column(
            children: [
              Spacer(),
              Text(
                'E-Wallet',
                style: new TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextField(
                        labelText: 'Mobile Number',
                        controller: _mobileNumberController,
                      ),
                      MyTextField(
                        labelText: 'PIN',
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        counterVisible: false,
                        onChanged: (value) async {
                          if (value.length == 6) {
                            loadingDialog.show();
                            if (await signIn()) {
                              loadingDialog.hide();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
//              Container(
//                height: MediaQuery.of(context).size.width * 0.90,
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        CircleButton(title: '1'),
//                        CircleButton(title: '2'),
//                        CircleButton(title: '3'),
//                      ],
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        CircleButton(title: '4'),
//                        CircleButton(title: '5'),
//                        CircleButton(title: '6'),
//                      ],
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        CircleButton(title: '7'),
//                        CircleButton(title: '8'),
//                        CircleButton(title: '9'),
//                      ],
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        SizedBox(),
//                        CircleButton(title: '0'),
//                        SizedBox(),
//                      ],
//                    ),
//                  ],
//                ),
//              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
