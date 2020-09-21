import 'package:flutter/material.dart';

enum AppTheme { greenLight, greenDart, blueLight, blueDart, redLight, redDart }

final appThemeData = {
  AppTheme.greenLight: ThemeData(brightness: Brightness.light, primaryColor: Colors.green),
  AppTheme.greenDart: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green[700]),
  AppTheme.blueLight: ThemeData(brightness: Brightness.light, primaryColor: Colors.blue),
  AppTheme.blueDart: ThemeData(brightness: Brightness.dark, primaryColor: Colors.blue[700]),
  AppTheme.redLight: ThemeData(brightness: Brightness.light, primaryColor: Colors.red),
  AppTheme.redDart: ThemeData(brightness: Brightness.dark, primaryColor: Colors.red[700]),
};
