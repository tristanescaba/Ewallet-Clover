import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class ContentBloc extends StatelessWidget {
  final String title;
  final Widget child;
  final double height;
  final double childPadding;

  const ContentBloc({
    this.title,
    this.child,
    this.height,
    this.childPadding = kScreenPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 2.0),
            child: Text(
              ' $title',
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ),
          height != null
              ? Container(
                  height: height,
                  child: child,
                )
              : Container(
                  child: child,
                )
        ],
      ),
    );
  }
}
