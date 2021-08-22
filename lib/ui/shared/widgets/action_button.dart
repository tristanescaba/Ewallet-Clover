import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool enable;
  final Function onPressed;

  const ActionButton({
    this.title,
    this.icon,
    this.enable = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable ? onPressed : null,
      child: Card(
        elevation: enable ? 4.0 : 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: 165.0,
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(icon),
                backgroundColor: enable ? kPrimaryColor : kPrimaryLightColor,
                foregroundColor: Colors.white,
              ),
              SizedBox(width: 12.0),
              FittedBox(
                child: Text(
                  title,
                  style: TextStyle(color: enable ? Colors.black87 : Colors.black38),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
