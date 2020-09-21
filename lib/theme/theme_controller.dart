import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyone_mobile/theme/app_themes.dart';
import 'package:skyone_mobile/util/app.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> themeData = appThemeData[AppTheme.values[App.storage.getInt("THEME") ?? 0]].obs;
  RxInt themeIndex = (App.storage.getInt("THEME") ?? 0).obs;

  void changeTheme(int index) {
    themeIndex.value = index;
    themeData.value = appThemeData[AppTheme.values[index]];
  }
}
