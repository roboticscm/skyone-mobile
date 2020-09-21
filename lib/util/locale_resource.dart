import 'package:flutter/foundation.dart';
import 'package:skyone_mobile/util/string_util.dart';

class LR {
  static Map<String, String> localeResources;

  static String l10n(String key) {
    String alternativeKey;

    final split = key.split(".");
    if (kReleaseMode) {
      alternativeKey = StringUtil.toWordCase(split[split.length - 1]);
    } else {
      alternativeKey = '#${StringUtil.toWordCase(split[split.length - 1])}';
    }
    if (localeResources == null) {
      return alternativeKey;
    }
    return localeResources[key] ?? alternativeKey;
  }
}
