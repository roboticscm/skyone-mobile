import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyone_mobile/util/app.dart';
import 'package:skyone_mobile/util/locale_resource.dart';
import 'package:skyone_mobile/widgets/sradio.dart';

enum LanguageList { system, vietnamese, english }

class LanguageUI extends StatelessWidget {
  final LanguageConfigController _languageConfigController = Get.put(LanguageConfigController());

  Future<void> saveSettings() async {
    await App.storage.setInt('LANGUAGE', _languageConfigController.selectedLanguage.value.index);
    App.appInstance.setLocale(_languageConfigController.selectedLanguage.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SRadio(
                    value: LanguageList.system,
                    groupValue: _languageConfigController.selectedLanguage.value,
                    onChanged: (LanguageList value) {
                      _languageConfigController.selectedLanguage.value = value;
                    },
                  ),
                  Text(LR.l10n('COMMON.LABEL.SYSTEM')),
                ],
              ),
              Row(
                children: <Widget>[
                  SRadio(
                    value: LanguageList.vietnamese,
                    groupValue: _languageConfigController.selectedLanguage.value,
                    onChanged: (LanguageList value) {
                      _languageConfigController.selectedLanguage.value = value;
                    },
                  ),
                  Text(LR.l10n('COMMON.LABEL.VIETNAMESE')),
                ],
              ),
              Row(
                children: <Widget>[
                  SRadio(
                    value: LanguageList.english,
                    groupValue: _languageConfigController.selectedLanguage.value,
                    onChanged: (LanguageList value) {
                      _languageConfigController.selectedLanguage.value = value;
                    },
                  ),
                  Text(LR.l10n('COMMON.LABEL.ENGLISH')),
                ],
              ),
            ],
          ),
        ));
  }
}

class LanguageConfigController extends GetxController {
  final selectedLanguage = LanguageList.values[App.storage.getInt('LANGUAGE') ?? 0].obs;
}
