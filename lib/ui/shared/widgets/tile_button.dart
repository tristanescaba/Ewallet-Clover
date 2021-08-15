import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  final IconData trailingIcon;

  const TileButton({
    this.title,
    this.subtitle = '',
    this.onTap,
    this.trailingIcon = Icons.keyboard_arrow_right,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$title'),
                Icon(
                  trailingIcon,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
