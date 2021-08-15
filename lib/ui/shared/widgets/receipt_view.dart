import 'dart:ui';

import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:ticketview/ticketview.dart';

class ReceiptView extends StatefulWidget {
  final String transaction;
  final String status;
  final String refID;
  final String coreReference;
  final List<Widget> children;
  final String date;

  const ReceiptView({
    Key key,
    this.transaction,
    this.status,
    this.refID,
    this.coreReference,
    this.date,
    this.children = const <Widget>[],
  }) : super(key: key);

  @override
  _ReceiptViewState createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> {
  _getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MMM dd, yyyy - hh:mm a');
    return formatter.format(now).toString();
  }

  final GlobalKey _globalKey = new GlobalKey();
  String globalPath = '';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: TicketView(
                backgroundPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                backgroundColor: kPrimaryLightColor,
                contentPadding: EdgeInsets.symmetric(vertical: 30.0),
                triangleAxis: Axis.vertical,
                borderRadius: 5,
                trianglePos: .84,
                dividerColor: Colors.white,
                drawTriangle: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        child: Image.asset('assets/images/k2c_logo.png', fit: BoxFit.cover),
                      ),
                      SizedBox(height: 15.0),
                      Column(
                        children: [
                          Text(
                            '${widget.transaction}',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            '${widget.date != null ? widget.date : _getDate()}',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.status != null)
                              Text(
                                'Status',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12.0,
                                ),
                              ),
                            if (widget.status != null)
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                                decoration: BoxDecoration(
                                  color: widget.status == 'Successful'
                                      ? Colors.green[100]
                                      : widget.status == 'Pending'
                                          ? Colors.blue[100]
                                          : Colors.red[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${widget.status}',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: widget.status == 'Successful'
                                          ? Colors.green[800]
                                          : widget.status == 'Pending'
                                              ? Colors.blue[800]
                                              : Colors.red[800]),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(children: widget.children),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  onPressed: () async {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share, size: 20.0, color: kPrimaryColor),
                      Text(
                        ' Share',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_download, size: 20.0, color: kPrimaryColor),
                      Text(
                        ' Download',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1.2, this.color = Colors.black45});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashWidth = 5.0;
          final dashHeight = height;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
          );
        },
      ),
    );
  }
}
