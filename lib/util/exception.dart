import 'package:flutter/material.dart';

class ExceptionPage extends StatelessWidget {
  final String message;
  const ExceptionPage(this.message);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
