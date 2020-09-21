import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyone_mobile/main.dart';


class App {
  static const appName = 'SKYONE';
  static const roundedBorder = 10.0;
  static SharedPreferences storage;
  static int languageIndex = 0;
  static Application appInstance;
  static String fcmToken;
}
