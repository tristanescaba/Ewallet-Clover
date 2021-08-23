import 'package:ewallet_clover/ui/screens/fund_transfer/pages/ft_confirmation.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/pages/ft_input_data.dart';
import 'package:ewallet_clover/ui/screens/fund_transfer/pages/ft_receipt.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class FundTransferScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      FTInputData(pageController: _pageController),
      FTConfirmation(pageController: _pageController),
      FTReceipt(pageController: _pageController),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Fund Transfer'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
        ),
      ),
      body: PageView(
        children: _pages,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
