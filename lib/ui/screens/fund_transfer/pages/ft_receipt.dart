import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/information_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FTReceipt extends StatelessWidget {
  final PageController pageController;

  const FTReceipt({
    Key key,
    this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InformationTile(
          title: 'Source',
          value: '09123456789',
        ),
        Divider(),
        InformationTile(
          title: 'Target Name',
          value: 'Pedro Garcia',
        ),
        InformationTile(
          title: 'Target Mobile Number',
          value: '099987654321',
        ),
        InformationTile(
          title: 'Total Amount',
          value: '100.00',
        ),
        Spacer(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kScreenPadding),
            child: Column(
              children: [
//                DefaultButtonWidget(
//                  title: 'Transfer Again',
//                  onPressed: () {
//                    transfer.targetBank = null;
//                    transfer.targetAccountNumber = null;
//                    transfer.targetAccountHolder = null;
//                    transfer.transferAmount = null;
//                    pageController.jumpToPage(0);
//                  },
//                ),
//                SizedBox(height: 10.0),
//                DefaultButtonWidget(
//                  title: 'Back to Dashboard',
//                  hasBorder: true,
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
