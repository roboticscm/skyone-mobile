import 'dart:async';
import 'dart:convert';

import 'package:skyone_mobile/modules/system/home/locale_resource/model.dart';
import 'package:skyone_mobile/util/global_functions.dart';
import 'package:skyone_mobile/util/http.dart';
import 'package:skyone_mobile/util/locale_resource.dart';
import 'package:skyone_mobile/util/string_util.dart';
import 'package:tuple/tuple.dart';

class LocaleResourceRepo {
  static Future<Tuple2<List<LocaleResource>, dynamic>> sysGetLocaleResourceListByCompanyIdAndLocale(String lang) async {
    try {
      final response = await Http.getWithoutToken(
          'sys/locale-resource/${StringUtil.toSnackCase("sysGetLocaleResourceListByCompanyIdAndLocale")}',
          params: {'companyId': 0, 'locale': lang});

      if (response.statusCode == 200) {
        final Iterable list = json.decode(response.body) as Iterable;
        final l = list.map((model) => LocaleResource.fromJson(model as Map<String, dynamic>)).toList();
        final map = <String, String>{};

        l.forEach((e) {
          map['${e.category}.${e.typeGroup}.${e.key}'] = e.value;
        });
        LR.localeResources = map;

        return Tuple2(l, null);
      } else {
        LR.localeResources = null;
        return Tuple2(null, Exception('Status code: ${response.statusCode}'));
      }
    } catch (e) {
      log(e);
      LR.localeResources = null;
      return Tuple2(null, e);
    }
  }
}
