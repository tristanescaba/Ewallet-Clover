import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool enable;
  final bool hasBorder;

  const GradientButton({
    @required this.title,
    this.onPressed,
    this.enable = true,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: EdgeInsets.all(0.0),
      elevation: enable ? 2.0 : 0.0,
      child: Ink(
        decoration: hasBorder
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                border: Border.all(color: enable ? kPrimaryColor : kPrimaryLightColor),
              )
            : BoxDecoration(
                gradient: enable ? kLinearGradient : kDisabledGradient,
                borderRadius: BorderRadius.circular(80.0),
              ),
        child: Container(
          decoration: BoxDecoration(
            color: hasBorder ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(80.0),
          ),
          constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17.0,
                color: hasBorder
                    ? enable
                        ? kPrimaryColor
                        : kPrimaryLightColor
                    : Colors.white),
          ),
        ),
      ),
      onPressed: enable ? onPressed : () {},
    );
  }
}
