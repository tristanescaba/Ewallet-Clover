import 'package:ewallet_clover/ui/shared/widgets/mpin_view.dart';
import 'package:flutter/material.dart';

class CashInMPINPage extends StatelessWidget {
  final PageController pageController;

  CashInMPINPage({
    this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return MPINView(
      onSuccess: () async {
        pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
      },
    );
  }
}