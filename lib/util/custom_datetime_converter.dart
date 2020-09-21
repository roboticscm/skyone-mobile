import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();
  static const int _secondFractionLen = 6;
  @override
  DateTime fromJson(String jsonDate) {
    final splitDate = jsonDate.split(".");
    if (splitDate.length > 1) {
      return DateTime.parse( "${splitDate[0]}.${splitDate[1].substring(0, min(_secondFractionLen, splitDate[1].length))}");
    }

    return null;
  }

  @override
  String toJson(DateTime json) => json.toIso8601String();
}

class CustomTimeConverter implements JsonConverter<DateTime, String> {
  const CustomTimeConverter();
  @override
  DateTime fromJson(String jsonTime) {
    return DateTime.parse('1970-01-01T$jsonTime');
  }

  @override
  String toJson(DateTime json) => json.toIso8601String();
}
