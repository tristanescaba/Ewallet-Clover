import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/transaction_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/content_bloc.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/information_tile.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortuuid/shortuuid.dart';

class FTConfirmation extends StatefulWidget {
  final PageController pageController;

  const FTConfirmation({
    this.pageController,
  });

  @override
  _FTConfirmationState createState() => _FTConfirmationState();
}

class _FTConfirmationState extends State<FTConfirmation> {
  final APIService _apiService = new APIService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final loadingDialog = MyLoadingDialog(context);
    final transaction = Provider.of<TransactionProvider>(context);

    Future<bool> fundTransfer() async {
      transaction.mobileRefID = ShortUuid.shortv4();
      ResponseModel response = await _apiService.fundTransfer(
        amount: '${transaction.transferAmount}',
        source: user.mobileNumber,
        target: transaction.targetMobileNumber,
        refID: '${transaction.mobileRefID}',
      );

      if (response.resultCode == 00) {
        transaction.isTransferSuccess = true;
        transaction.transDateTime = response.result['data']['trnDateTime'];
        transaction.coreRefID = response.result['data']['refID'];
        user.getBalance();
        user.getTransactionHistory();
        return true;
      } else {
        transaction.isTransferSuccess = false;
        loadingDialog.hide();
        await showDialog(
          context: context,
          child: MyDialog(
            title: response.title,
            message: response.message,
            button1Title: 'Okay',
            button1Function: () {
              Navigator.pop(context);
              widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
            },
            hasError: response.hasError,
          ),
        );
        return false;
      }
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentBloc(
                    title: 'TRANSFER WITH',
                    child: Column(
                      children: [
                        InformationTile(
                          title: 'Mobile Number',
                          value: '${user.mobileNumber}',
                        ),
                        InformationTile(
                          title: 'Available Balance',
                          value: '${money.format(user.availableBalance)}',
                          showDivider: false,
                        ),
                      ],
                    ),
                  ),
                  ContentBloc(
                    title: 'YOU ARE ABOUT TO TRANSFER',
                    child: Column(
                      children: [
                        InformationTile(
                          title: 'To',
                          value: '${transaction.targetName}',
                        ),
                        InformationTile(
                          title: 'Mobile Number',
                          value: '${transaction.targetMobileNumber}',
                        ),
                        InformationTile(
                          title: 'Total Amount',
                          value: '${money.format(transaction.transferAmount)}',
                          showDivider: false,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kScreenPadding),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    child: GradientButton(
                      title: 'Back',
                      hasBorder: true,
                      onPressed: () {
                        widget.pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    height: 50.0,
                    child: GradientButton(
                      title: 'Transfer',
                      onPressed: () async {
                        loadingDialog.show();
                        if (await fundTransfer()) {
                          loadingDialog.hide();
                          widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
