import 'package:ewallet_clover/core/functions/http_handler.dart';
import 'package:ewallet_clover/core/functions/loading_dialog.dart';
import 'package:ewallet_clover/core/providers/transaction_provider.dart';
import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/core/services/api_service.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_dialog.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FTInputData extends StatefulWidget {
  final PageController pageController;

  const FTInputData({
    this.pageController,
  });

  @override
  _FTInputDataState createState() => _FTInputDataState();
}

class _FTInputDataState extends State<FTInputData> {
  final APIService _apiService = new APIService();
  final _formKey = GlobalKey<FormState>();
  final _mobileFieldController = TextEditingController();
  final _amountFieldController = TextEditingController();

  @override
  void dispose() {
    _mobileFieldController.dispose();
    _amountFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final transaction = Provider.of<TransactionProvider>(context);
    final loadingDialog = MyLoadingDialog(context);

    Future<bool> checkMobileNumber() async {
      ResponseModel response = await _apiService.validateMobileNumber(mobileNumber: '0${_mobileFieldController.text}');

      if (response.resultCode == 00) {
        transaction.targetName = '${response.result['data']['firstname']} ${response.result['data']['lastname']}';
        return true;
      } else {
        loadingDialog.hide();
        await showDialog(
          context: context,
          child: MyDialog(
            title: response.title,
            message: response.message,
            button1Title: 'Okay',
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
              child: Padding(
                padding: const EdgeInsets.all(kScreenPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextField(
                        title: 'Recipient\'s Mobile Number',
                        prefixText: '+63',
                        maxLength: 10,
                        counterVisible: false,
                        keyboardType: TextInputType.number,
                        controller: _mobileFieldController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please input mobile number.";
                          } else if (value.length != 10 || value.substring(0, 1) != "9") {
                            return "Mobile number is not valid.";
                          }
                        },
                      ),
                      MyTextField(
                        title: 'Amount',
                        controller: _amountFieldController,
                        amountField: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please input amount to transfer.";
                          } else if (double.parse(value) < 1) {
                            return "Please input at least Php 1.00";
                          } else if (double.parse(value) > user.availableBalance) {
                            return "Insufficient balance.";
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kScreenPadding),
            child: Container(
              height: 50.0,
              child: GradientButton(
                title: 'Next',
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (user.mobileNumber != '0${_mobileFieldController.text}') {
                      loadingDialog.show();
                      if (await checkMobileNumber()) {
                        transaction.targetMobileNumber = '0${_mobileFieldController.text}';
                        transaction.transferAmount = double.parse(_amountFieldController.text);
                        loadingDialog.hide();
                        widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                      }
                    } else {
                      await showDialog(
                        context: context,
                        child: MyDialog(
                          title: 'Invalid Target',
                          message: 'You cannot transfer to your own account.',
                          button1Title: 'Okay',
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
