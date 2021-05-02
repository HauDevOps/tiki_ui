import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  Box({this.title, this.action, this.child});

  final Widget title;
  final Widget action;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [title, action],
          ),
          child
        ],
      ),
    );
  }
}
