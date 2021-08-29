import 'package:ewallet_clover/core/providers/transaction_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/information_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FTReceipt extends StatelessWidget {
  final PageController pageController;

  const FTReceipt({
    Key key,
    this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final transaction = Provider.of<TransactionProvider>(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 3),
                      blurRadius: 15,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(kScreenPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                        gradient: kLinearGradient,
                      ),
                      child: Text(
                        'TRANSACTION RECEIPT',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kScreenPadding),
                      child: Column(
                        children: [
                          Text(
                            'DigiWallet',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = kShaderGradient,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Php '),
                                    Text(
                                      '${money.format(transaction.transferAmount)}    ',
                                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Divider(
                                  indent: 30.0,
                                  endIndent: 30.0,
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Transfer Amount',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          InformationTile(
                            title: 'Transaction Status',
                            value: transaction.isTransferSuccess ? 'Success' : 'Failed',
                            textColor: transaction.isTransferSuccess ? Colors.green : Colors.redAccent,
                          ),
                          InformationTile(
                            title: 'Transaction Date Time',
                            value: '${transaction.transDateTime}',
                          ),
                          InformationTile(
                            title: 'Source Mobile Number',
                            value: '${user.mobileNumber}',
                          ),
                          InformationTile(
                            title: 'Target Mobile Number',
                            value: '${transaction.targetMobileNumber}',
                          ),
                          InformationTile(
                            title: 'Target Name',
                            value: '${transaction.targetName}',
                          ),
                          InformationTile(
                            title: 'Mobile Reference ID',
                            value: '${transaction.mobileRefID}',
                          ),
                          InformationTile(
                            title: 'Core Reference ID',
                            value: '${transaction.coreRefID}',
                            showDivider: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kScreenPadding),
            child: Container(
              height: 50.0,
              child: GradientButton(
                title: 'Transfer again',
                onPressed: () {
                  transaction.resetValues();
                  pageController.jumpToPage(0);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
