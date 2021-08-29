import 'package:ewallet_clover/core/providers/transaction_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/information_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final transaction = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'DigiWallet',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 40.0,
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
          ),
        ],
      ),
    );
  }
}
