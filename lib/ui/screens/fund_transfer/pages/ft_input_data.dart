import 'package:ewallet_clover/core/providers/user_provider.dart';
import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
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
                        amountField: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please input amount to transfer.";
                          } else if (double.parse(value) > double.parse(user.availableBalance)) {
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
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    widget.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
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
