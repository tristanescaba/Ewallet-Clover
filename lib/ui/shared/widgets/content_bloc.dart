import 'package:flutter/material.dart';

class ContentBloc extends StatelessWidget {
  final String title;
  final Widget child;

  const ContentBloc({
    this.title,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[100],
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Text(
            '$title',
            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: child,
        )
      ],
    );
  }
}
