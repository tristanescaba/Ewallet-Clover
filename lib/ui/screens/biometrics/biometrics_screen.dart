import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/shared_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:ewallet_clover/ui/shared/widgets/state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class BiometricsScreen extends StatefulWidget {
  @override
  _BiometricsScreenState createState() => _BiometricsScreenState();
}

class _BiometricsScreenState extends State<BiometricsScreen> {
  final storage = new FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final _mobileFieldController = TextEditingController();
  final _mpinFieldController = TextEditingController();

  @override
  void dispose() {
    _mpinFieldController.dispose();
    _mobileFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final shared = Provider.of<SharedProvider>(context);
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
            message: response.message == 'Mobile number or MPIN is incorrect.' ? 'Incorrect MPIN' : response.message,
            button1Title: 'Okay',
            hasError: response.hasError,
          ),
        );
        return false;
      }
    }

    return StateWrapper(
      initState: () {
        _mobileFieldController.text = user.mobileNumber;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Biometrics'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: kLinearGradient,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child: Text(
                'To enable biometrics, please type your MPIN.',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kScreenPadding),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            MyTextField(
                              title: 'Mobile Number',
                              prefixIcon: Icons.smartphone,
                              controller: _mobileFieldController,
                              enabled: false,
                            ),
                            MyTextField(
                              title: 'Input MPIN',
                              controller: _mpinFieldController,
                              prefixIcon: Icons.lock,
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please input your MPIN.";
                                } else if (value.length != 6) {
                                  return "MPIN must be 6 digits.";
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(kScreenPadding),
                child: Container(
                  height: 50.0,
                  child: GradientButton(
                    title: 'Proceed',
                    onPressed: () async {
                      loadingDialog.show();
                      if (await signIn(mpin: _mpinFieldController.text)) {
                        loadingDialog.hide();
                        user.saveMPIN(mpin: _mpinFieldController.text);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
