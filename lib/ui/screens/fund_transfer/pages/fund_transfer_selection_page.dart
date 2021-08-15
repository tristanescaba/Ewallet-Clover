import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/tile_button.dart';
import 'package:flutter/material.dart';

class FundTransferSelectionPage extends StatelessWidget {
  final PageController pageController;

  const FundTransferSelectionPage({
    this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kScreenPadding),
      child: Column(
        children: [
          SizedBox(height: 40.0),
          Text(
            'In which account you want to transfer? choose one below.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          TileButton(
            title: 'Transfer to other konek2CARD account',
            onTap: () {
              pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
          ),
          TileButton(
            title: 'Transfer to bank account',
            onTap: () {
              pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
