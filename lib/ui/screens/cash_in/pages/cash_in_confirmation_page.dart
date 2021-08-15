import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/confirm_slider.dart';
import 'package:ewallet_clover/ui/shared/widgets/content_bloc.dart';
import 'package:ewallet_clover/ui/shared/widgets/information_tile.dart';
import 'package:flutter/material.dart';

class CashInConfirmationPage extends StatelessWidget {
  final PageController pageController;

  const CashInConfirmationPage({this.pageController});

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContentBloc(
                      title: 'SOURCE ACCOUNT',
                      child: Container(
                        decoration: kCardDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(kScreenPadding),
                          child: Column(
                            children: [
                              InformationTile(
                                title: 'Name',
                                value: 'Pledge Account',
                              ),
                              InformationTile(
                                title: 'Account Number',
                                value: '1234-1234-12345678',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ContentBloc(
                      title: 'YOU ARE ABOUT TO DO A CASH-IN',
                      child: Container(
                        decoration: kCardDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(kScreenPadding),
                          child: Column(
                            children: [
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
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(kScreenPadding),
              child: ConfirmSlider(
                onSlide: () {
                  pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                },
              )),
        ],
      ),
    );
  }
}
