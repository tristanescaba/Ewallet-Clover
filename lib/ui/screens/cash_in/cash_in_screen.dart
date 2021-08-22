import 'package:ewallet_clover/ui/screens/cash_in/pages/cash_in_confirmation_page.dart';
import 'package:ewallet_clover/ui/screens/cash_in/pages/cash_in_input_page.dart';
import 'package:ewallet_clover/ui/screens/cash_in/pages/cash_in_mpin_page.dart';
import 'package:ewallet_clover/ui/screens/cash_in/pages/cash_in_receipt_page.dart';
import 'package:flutter/material.dart';

class CashInScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      CashInInputPage(pageController: _pageController),
      CashInConfirmationPage(pageController: _pageController),
      CashInMPINPage(pageController: _pageController),
      CashInReceiptPage(pageController: _pageController),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Cash-in'),
//        flexibleSpace: Container(
//          decoration: BoxDecoration(
//            gradient: kLinearGradient,
//          ),
//        ),
      ),
      body: PageView(
        children: _pages,
        controller: _pageController,
      ),
    );
  }
}
