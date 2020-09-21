import 'package:flutter/foundation.dart';
import 'package:skyone_mobile/util/locale_resource.dart';
import 'package:skyone_mobile/util/string_util.dart';

extension Trans on String {
  String t() {
    String alternativeKey;

    final split = this.split(".");
    if (kReleaseMode) {
      alternativeKey = StringUtil.toWordCase(split[split.length - 1]);
    } else {
      alternativeKey = '#${StringUtil.toWordCase(split[split.length - 1])}';
    }
    if (LR.localeResources == null) {
      return alternativeKey;
    }

    return LR.localeResources[this] ?? alternativeKey;
  }
}
