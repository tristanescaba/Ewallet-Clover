import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String subMessage;
  final String button1Title;
  final String button2Title;
  final Function button1Function;
  final Function button2Function;
  final bool hasError;

  const MyDialog({
    Key key,
    this.icon,
    this.iconColor,
    this.title,
    @required this.message,
    this.subMessage,
    this.button1Title,
    this.button2Title,
    this.button1Function,
    this.button2Function,
    this.hasError,
  }) : super(key: key);

  // Add "barrierDismissible: false" below ShowDialog if you don't want to dismiss dialog on outside tap

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      title: Column(
        children: [
          if (icon != null)
            Column(
              children: [
                Icon(
                  icon,
                  color: iconColor == null ? kPrimaryColor : iconColor,
                  size: 30.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          Row(
            children: [
              if (title != null)
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      content: IntrinsicHeight(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Column(
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  if (subMessage != null)
                    Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          subMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10.5, color: Colors.grey),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(),
            Row(
              children: [
                button2Title == null || button2Title == ''
                    ? SizedBox()
                    : Expanded(
                        child: Center(
                          child: FlatButton(
                            child: Text(button2Title, style: TextStyle(color: Colors.black54)),
                            onPressed: button2Function == null ? () => Navigator.pop(context) : button2Function,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                      ),
                if ((button1Title != null) && (button2Title != null)) Text('|', style: TextStyle(fontSize: 40.0, color: Colors.grey[200], fontWeight: FontWeight.w200)),
                button1Title == null || button1Title == ''
                    ? SizedBox()
                    : Expanded(
                        child: Center(
                          child: FlatButton(
                            child: Text(button1Title, style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                            onPressed: button1Function == null ? () => Navigator.pop(context) : button1Function,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
