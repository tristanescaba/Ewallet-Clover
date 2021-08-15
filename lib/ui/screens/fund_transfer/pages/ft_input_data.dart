import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/gradient_button.dart';
import 'package:ewallet_clover/ui/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class FTInputData extends StatelessWidget {
  final PageController pageController;

  const FTInputData({this.pageController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kScreenPadding),
                child: Column(
                  children: [
                    MyTextField(
                      title: 'Recipient\'s Mobile Number',
                      prefixText: '+63',
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      counterVisible: false,
                    ),
                    MyTextField(
                      title: 'Amount',
                      amountField: true,
                    ),
                  ],
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
                  pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
