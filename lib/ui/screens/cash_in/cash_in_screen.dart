import 'package:ewallet_clover/ui/screens/cash_in/pages/cash_in_confirmation_page.dart';
import 'package:ewallet_clover/ui/screens/cash_in/pages/cash_in_input_page.dart';
import 'package:ewallet_clover/ui/screens/cash_in/pages/cash_in_mpin_page.dart';
import 'package:ewallet_clover/ui/screens/cash_in/pages/cash_in_receipt_page.dart';
import 'package:ewallet_clover/ui/shared/widgets/page_step_view.dart';
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
    List<String> _pageTitles = [
      'Step 1: Select a target',
      'Step 2: Input Necessary data',
      'Step 3: Confirmation',
      'Step 4: MPIN for verification',
      'Step 5: Transfer receipt',
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
      body: PageStepView(
        pages: _pages,
        pageTitles: _pageTitles,
        pageController: _pageController,
      ),
    );
  }
}
