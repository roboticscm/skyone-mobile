

import 'package:flutter/material.dart';


class SFlatButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  Widget icon;

  SFlatButton({this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          Text(text)
        ],
      ),
    );
  }

}