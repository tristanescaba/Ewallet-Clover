import 'dart:ui';

import 'package:ewallet_clover/core/providers/transaction_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/screens/transaction_details/transaction_details_screen.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HistoryPanel extends StatelessWidget {
  final ScrollController controller;

  const HistoryPanel(this.controller);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final transaction = Provider.of<TransactionProvider>(context);

    return ListView(
      controller: controller,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
          child: Center(
            child: Container(
              height: 6.0,
              width: 45.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        user.isHistoryLoading
            ? Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  CircularProgressIndicator(backgroundColor: Colors.white),
                  SizedBox(height: 12.0),
                  Text(
                    'Fetching Transactions',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              )
            : user.getHistoryStatus == 0
                ? SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            children: [
//                              Icon(Icons.history, color: kPrimaryColor),
                              Text(
                                'TRANSACTION HISTORY ',
                                style: TextStyle(color: kPrimaryColor, fontSize: 17.0),
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.history, color: kPrimaryColor),
                                onPressed: user.getTransactionHistory,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                            itemCount: user.historyItems.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      transaction.resetValues();
                                      transaction.transDateTime = user.historyItems[index].trnDateTime;
                                      transaction.transferAmount = double.parse(user.historyItems[index].amount);
                                      transaction.targetMobileNumber = user.historyItems[index].targetMobile;
                                      transaction.coreRefID = user.historyItems[index].refID;
                                      transaction.mobileRefID = user.historyItems[index].mobileRef;
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionDetailsScreen()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(18.0),
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(user.historyItems[index].trnDescription),
                                              Text(
                                                user.historyItems[index].trnDateTime,
                                                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          user.historyItems[index].sourceMobile == user.mobileNumber
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      Icons.remove,
                                                      size: 18.0,
                                                      color: Colors.redAccent,
                                                    ),
                                                    Text(' Php ${money.format(double.parse(user.historyItems[index].amount))}')
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Icon(
                                                      Icons.add,
                                                      size: 18.0,
                                                      color: Colors.green,
                                                    ),
                                                    Text(' Php ${money.format(double.parse(user.historyItems[index].amount))}')
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider()
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : user.getHistoryStatus == 1
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          SvgPicture.asset(
                            'assets/svg/undraw_No_data_re_kwbl.svg',
                            height: 110.0,
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            'You don\'t have any transactions yet',
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          SvgPicture.asset(
                            'assets/svg/undraw_No_data_re_kwbl.svg',
                            height: 110.0,
                          ),
                          SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Failed to load transactions, ',
                                style: TextStyle(color: Colors.black54),
                              ),
                              GestureDetector(
                                onTap: user.getTransactionHistory,
                                child: Text(
                                  'Tap here to reload.',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
      ],
    );
  }
}
