import 'dart:convert';

import 'package:skyone_mobile/util/global_functions.dart';
import 'package:skyone_mobile/util/http.dart';
import 'package:skyone_mobile/util/string_util.dart';
import 'package:tuple/tuple.dart';

class AppRepo {
  static Future<Tuple2<bool, dynamic>> registerDevice(String fcmToken) async {
    try {
      final jsonBody = json.encode({'fcmToken': fcmToken});
      final response = await Http.post('sys/device/${StringUtil.toSnackCase("registerDevice")}', jsonBody: jsonBody);

      if (response.statusCode == 200 || response.statusCode == 400) {
        final result = json.decode(response.body)['result'];
        if (result == 'SUCCESS') {
          return const Tuple2(true, null);
        } else {
          return Tuple2(false, result);
        }
      } else {
        return Tuple2(null, Exception('Status code: ${response.statusCode}'));
      }
    } catch (e) {
      log(e);
      return Tuple2(null, e);
    }
  }
}
