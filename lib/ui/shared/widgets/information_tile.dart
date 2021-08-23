import 'package:flutter/material.dart';

class InformationTile extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;
  final bool bold;
  final bool showDivider;

  const InformationTile({
    Key key,
    this.title,
    this.value,
    this.textColor,
    this.bold = false,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 5.0),
              if (value != null)
                Text(
                  value,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
            ],
          ),
        ),
        if (showDivider) Divider(),
      ],
    );
  }
}
