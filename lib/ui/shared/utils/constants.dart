import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//const kPrimaryColor = MaterialColor(
//  0xFF04540f,
//  const <int, Color>{
//    50: const Color(0xFF04540f),
//    100: const Color(0xFF04540f),
//    200: const Color(0xFF04540f),
//    300: const Color(0xFF04540f),
//    400: const Color(0xFF04540f),
//    500: const Color(0xFF04540f),
//    600: const Color(0xFF04540f),
//    700: const Color(0xFF04540f),
//    800: const Color(0xFF04540f),
//    900: const Color(0xFF04540f),
//  },
//);
//const kPrimaryLightColor = Color(0xffcbe6c9);
const kPrimaryColor = Colors.deepOrange;
const kPrimaryLightColor = Colors.orangeAccent;
const kSecondaryColor = Colors.greenAccent;
const kTextColor = Color(0xff5c5c5c);
const kLightGray = Color(0xfff5f5f5);
const kDangerColor = Color(0xfff8d7d9);
const double kScreenPadding = 18.0;
const LinearGradient kLinearGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [kPrimaryLightColor, kPrimaryColor],
);
const LinearGradient kDisabledGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Colors.white54, Colors.grey],
);
const kAnimationDuration = Duration(milliseconds: 200);

var money = NumberFormat("#,##0.00", "en_US");

var kCardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: Offset(0, 3),
      blurRadius: 15,
    )
  ],
);
