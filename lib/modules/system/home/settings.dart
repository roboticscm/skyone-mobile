import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyone_mobile/modules/system/home/language.dart';
import 'package:skyone_mobile/modules/system/home/profiles.dart';
import 'package:skyone_mobile/modules/system/home/theme.dart';
import 'package:skyone_mobile/theme/theme_controller.dart';
import 'package:skyone_mobile/util/app.dart';
import 'package:skyone_mobile/util/locale_resource.dart';
import 'package:skyone_mobile/widgets/close_button.dart';
import 'package:skyone_mobile/widgets/save_button.dart';
import 'package:skyone_mobile/widgets/sdialog.dart';

class SettingsPage extends StatelessWidget {
  final LanguageUI _languageUI = LanguageUI();
  final ThemeUI _themeUI = ThemeUI();
  final ProfilesUI _profilesUI = ProfilesUI();

  @override
  Widget build(BuildContext context) {
    return SDialog(
      title: Text(LR.l10n('COMMON.BUTTON.SETTINGS')),
      content: LimitedBox(
        maxHeight: 200,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
              body: TabBarView(children: [
                _profilesUI,
                _languageUI,
                _themeUI,
              ]),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  bottom: TabBar(tabs: [
                    Tab(
                      icon: const Icon(Icons.supervised_user_circle),
                      text: LR.l10n('COMMON.LABEL.PROFILES'),
                    ),
                    Tab(
                      icon: const Icon(Icons.language),
                      text: LR.l10n('COMMON.LABEL.LANGUAGE'),
                    ),
                    Tab(
                      icon: const Icon(Icons.palette),
                      text: LR.l10n('COMMON.LABEL.THEME'),
                    ),
                  ]),
                ),
              )),
        ),
      ),
      actions: <Widget>[
        LimitedBox(child: SCloseButton(
          onTap: () {
            final ThemeController themeController = Get.find<ThemeController>();
            final prevThemeIndex = App.storage.getInt('THEME') ?? 0;
            themeController.changeTheme(prevThemeIndex);
            Navigator.of(context).pop();
          },
        )),
        LimitedBox(child: SaveButton(
          onTap: () async {
            await _languageUI.saveSettings();
            await _themeUI.saveSettings();
            final profilesRes = await _profilesUI.changePassword(context);
            if (profilesRes == true) {
              Navigator.pop(context);
            }
          },
        )),
      ],
    );
  }
}
