import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;

  const ActionButton({
    this.title,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: 165.0,
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              CircleAvatar(child: Icon(icon)),
              SizedBox(width: 12.0),
              FittedBox(child: Text(title)),
            ],
          ),
        ),
      ),
    );
  }
}
