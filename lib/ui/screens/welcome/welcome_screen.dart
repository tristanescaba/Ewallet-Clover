import 'package:ewallet_clover/ui/screens/dashboard/dashboard_screen.dart';
import 'package:ewallet_clover/ui/screens/user_registration/user_registration_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[kPrimaryLightColor, kPrimaryColor],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
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
              Spacer(),
              Spacer(),
              GradientButton(
                title: 'Log in',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account? ', style: TextStyle(fontSize: 14.0)),
                  GestureDetector(
                    child: Text(
                      'Click here',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserRegistrationScreen()),
                      );
                    },
                  )
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
