import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool enable;

  const GradientButton({
    @required this.title,
    this.onPressed,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: EdgeInsets.all(0.0),
      elevation: enable ? 2.0 : 0.0,
      child: Ink(
        decoration: BoxDecoration(
          gradient: enable ? kLinearGradient : kDisabledGradient,
          borderRadius: BorderRadius.circular(80.0),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17.0, color: Colors.white),
          ),
        ),
      ),
      onPressed: enable ? onPressed : () {},
    );
  }
}
