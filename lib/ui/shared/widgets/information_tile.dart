import 'package:flutter/material.dart';

class InformationTile extends StatelessWidget {
  final String title;
  final String title2;
  final String value;
  final String subValue;
  final String referenceID;
  final Color textColor;
  final bool bold;

  const InformationTile({
    Key key,
    this.title,
    this.title2,
    this.value,
    this.subValue,
    this.referenceID,
    this.textColor,
    this.bold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14.0,
                ),
              ),
              if (value != null)
                Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
            ],
          ),
          if (subValue != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title2,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  subValue,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15.0,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          //refs
          if (referenceID != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Core Reference ID',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  referenceID,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15.0,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),

          // if (referenceID != null)
          //   Column(
          //     children: [
          //       const MySeparator(),
          //       Padding(
          //         padding: const EdgeInsets.only(bottom: 7.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               'Core Reference ID',
          //               style: TextStyle(color: Colors.black38, fontSize: 12.0),
          //             ),
          //           ],
          //         ),
          //       ),
          //       BarcodeWidget(
          //         barcode: Barcode.code128(),
          //         data: referenceID,
          //         width: double.infinity,
          //         height: 35.0,
          //         style: TextStyle(fontSize: 12.0),
          //       ),
          //     ],
          //   )
        ],
      ),
    );
  }
}
