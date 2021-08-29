import 'package:ewallet_clover/ui/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class MyLoadingDialog {
  final BuildContext context;

  const MyLoadingDialog(
    this.context,
  );

  void show({String message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(kScreenPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(60.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 12.0),
                Text(message == null ? '   Loading...' : '  $message'),
              ],
            ),
          ),
        );
      },
    );
  }

  void hide() {
    Navigator.pop(context);
  }
}
