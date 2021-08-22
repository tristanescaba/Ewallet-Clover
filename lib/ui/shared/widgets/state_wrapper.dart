import 'package:flutter/material.dart';

class StateWrapper extends StatefulWidget {
  final Function initState;
  final Function disposeState;
  final Widget child;

  StateWrapper({this.initState, this.disposeState, this.child});

  @override
  _StateWrapperState createState() => _StateWrapperState();
}

class _StateWrapperState extends State<StateWrapper> {
  @override
  void initState() {
    if (widget.initState != null) {
      widget.initState();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.disposeState != null) {
      widget.disposeState();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
