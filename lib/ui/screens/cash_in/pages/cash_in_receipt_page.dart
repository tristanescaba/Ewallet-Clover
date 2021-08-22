import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/information_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CashInReceiptPage extends StatelessWidget {
  final PageController pageController;

  const CashInReceiptPage({
    Key key,
    this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InformationTile(
          title: 'Name',
          value: 'Pledge Account',
        ),
        InformationTile(
          title: 'Account Number',
          value: '1234-1234-12345678',
        ),
        Divider(),
        InformationTile(
          title: 'To',
          value: 'konek2CARD',
        ),
        InformationTile(
          title: 'Mobile Number',
          value: '09123456789',
        ),
        InformationTile(
          title: 'Total Amount',
          value: '500.00',
        ),
        Spacer(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kScreenPadding),
            child: Container(
              height: 50.0,
              child: GradientButton(
                title: 'Back to Dashboard',
                onPressed: () {
                  pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
