import 'package:ewallet_clover/ui/screens/dashboard/dashboard_screen.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/fund_transfer_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> screenRoutes = {
  '/dashboardScreen': (context) => DashboardScreen(),
  '/fundTransferScreen': (context) => FundTransferScreen(),
};
