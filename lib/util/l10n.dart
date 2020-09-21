import 'package:flutter/material.dart';
import 'package:skyone_mobile/main.dart';
import 'package:skyone_mobile/modules/system/home/locale_resource/repo.dart';
import 'package:skyone_mobile/util/global_var.dart';
import 'package:skyone_mobile/util/server.dart';

class L10nDelegate extends LocalizationsDelegate {
  const L10nDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['vi', 'en'].contains(locale.languageCode);
  }

  @override
  Future load(Locale locale) async {
    final res = await LocaleResourceRepo.sysGetLocaleResourceListByCompanyIdAndLocale(
        '${locale.languageCode}-${locale.countryCode}');
    if (res.item2 != null) {
      Future.delayed(const Duration(seconds: 1), () {
        Server.showConfigDialog(locator<NavigationService>().navigatorKey.currentContext);
      });
    } else {
      return res.item1;
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    return false;
  }
}
