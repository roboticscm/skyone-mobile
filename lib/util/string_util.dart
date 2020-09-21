import 'package:skyone_mobile/util/global_functions.dart';

class StringUtil {
  static String toSnackCase(String source, {String sep = '-'}) {
    if (source == null) {
      return '';
    }

    var ret = '';
    for (var i = 0; i < source.length; i++) {
      final ch = source[i];
      if (ch == ch.toUpperCase() && !isDigit(ch)) {
        ret += sep + ch.toLowerCase();
      } else {
        ret += ch;
      }
    }
    return ret;
  }

  static String toWordCase(String source) {
    if (source == null) {
      return "";
    }

    final split = source.split("_");
    var result = "";

    split.forEach((String word) {
      result += "${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ";
    });

    return result.trim();
  }
}
