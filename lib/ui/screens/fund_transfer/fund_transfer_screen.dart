import 'package:ewallet_clover/ui/screens/fund_transfer/pages/ft_confirmation.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/pages/ft_input_data.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/pages/ft_mpin.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/pages/ft_receipt.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/pages/fund_transfer_selection_page.dart';
import 'package:ewallet_clover/ui/shared/widgets/page_step_view.dart';
import 'package:flutter/material.dart';

class FundTransferScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      FundTransferSelectionPage(pageController: _pageController),
      FTInputData(pageController: _pageController),
      FTConfirmation(pageController: _pageController),
      FTmpin(pageController: _pageController),
      FTReceipt(pageController: _pageController),
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
        title: Text('Fund Transfer'),
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
