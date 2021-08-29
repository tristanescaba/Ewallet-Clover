import 'package:ewallet_clover/core/providers/shared_provider.dart';
import 'package:ewallet_clover/core/providers/transaction_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/welcome/welcome_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/providers/registration_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SharedProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DigiWallet',
        theme: ThemeData(
          primarySwatch: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            centerTitle: true,
          ),
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
