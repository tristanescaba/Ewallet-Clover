import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:ewallet_clover/ui/shared/widgets/confirm_slider.dart';
import 'package:ewallet_clover/ui/shared/widgets/content_bloc.dart';
import 'package:ewallet_clover/ui/shared/widgets/information_tile.dart';
import 'package:flutter/material.dart';

class FTConfirmation extends StatelessWidget {
  final PageController pageController;

  const FTConfirmation({this.pageController});

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
                      title: 'PAY WITH',
                      child: Container(
                        decoration: kCardDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(kScreenPadding),
                          child: Column(
                            children: [
                              InformationTile(
                                title: 'Available Balance',
                                value: '5,000.78',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ContentBloc(
                      title: 'YOU ARE ABOUT TO TRANSFER',
                      child: Container(
                        decoration: kCardDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(kScreenPadding),
                          child: Column(
                            children: [
                              InformationTile(
                                title: 'To',
                                value: 'Pedro Garcia',
                              ),
                              InformationTile(
                                title: 'Mobile Number',
                                value: '09987654321',
                              ),
                              InformationTile(
                                title: 'Total Amount',
                                value: '100.00',
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
