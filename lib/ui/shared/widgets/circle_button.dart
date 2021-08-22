import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final String title;

  const CircleButton({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(25.0),
//                  primary: Colors.blue, // <-- Button color
//                  onPrimary: Colors.red, // <-- Splash color
      ),
    );
  }
}
