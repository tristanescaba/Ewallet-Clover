import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 40.0),
          child: Center(
            child: Container(
              height: 6.0,
              width: 45.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            SvgPicture.asset(
              'assets/svg/undraw_No_data_re_kwbl.svg',
              height: 110.0,
            ),
            SizedBox(height: 30.0),
            Text(
              'You don\'t have any transactions yet',
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ],
    );
  }
}
