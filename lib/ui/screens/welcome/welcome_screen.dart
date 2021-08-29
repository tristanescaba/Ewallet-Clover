import 'package:ewallet_clover/core/providers/shared_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/welcome/componentes/login_view.dart';
import 'package:ewallet_clover/ui/screens/welcome/componentes/welcome_view.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[kPrimaryLightColor, kPrimaryColor],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final shared = Provider.of<SharedProvider>(context);

    Future<bool> appInit() async {
      await user.checkSavedUser();
      await shared.canCheckBiometrics();
      return true;
    }

    return StateWrapper(
      initState: () {
        Future.delayed(const Duration(milliseconds: 1500), () async {
          shared.getDeviceDetails();
          shared.getGreet();
          await user.checkSavedUser();
          shared.isAppInitiated = await appInit();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 30.0),
              width: double.infinity,
              child: Text(
                'DigiWallet',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
            ),
            Expanded(
              child: shared.isAppInitiated
                  ? user.hasSavedMobileNumber
                      ? LoginView()
                      : WelcomeView()
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
