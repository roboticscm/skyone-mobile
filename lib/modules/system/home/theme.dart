
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyone_mobile/theme/app_themes.dart';
import 'package:skyone_mobile/theme/theme_controller.dart';
import 'package:skyone_mobile/util/app.dart';

class ThemeUI extends StatelessWidget {
  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: AppTheme.values.length,
        itemBuilder: (BuildContext context, int index) {
          final theme = appThemeData[AppTheme.values[index]];
          return Obx(() => Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.primaryColor,
                    border: _themeController.themeIndex.value == index
                        ? Border.all(color: _getBorderColor(index), width: 4)
                        : null),
                child: ListTile(
                  onTap: () {
                    final ThemeController themeController = Get.find<ThemeController>();
                    themeController.changeTheme(index);
                  },
                  title: Text(AppTheme.values[index].toString().split(".")[1]),
                ),
              ));
        });
  }

  Future<void> saveSettings() async {
    await App.storage.setInt("THEME", _themeController.themeIndex.value as int);
  }

  Color _getBorderColor(int index) {
    if (appThemeData[AppTheme.values[index]].brightness == Brightness.light) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}
