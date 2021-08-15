import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class ConfirmSlider extends StatelessWidget {
  final Function onSlide;

  const ConfirmSlider({
    this.onSlide,
  });

  @override
  Widget build(BuildContext context) {
    return ConfirmationSlider(
      width: MediaQuery.of(context).size.width - (kScreenPadding * 2),
      foregroundColor: kPrimaryColor,
      iconColor: Colors.white,
      textStyle: TextStyle(fontSize: 18.0, color: Colors.black38),
      backgroundShape: BorderRadius.circular(18.0),
      foregroundShape: BorderRadius.circular(15.0),
      onConfirmation: onSlide,
    );
  }
}
