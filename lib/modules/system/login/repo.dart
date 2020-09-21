import 'dart:convert';

import 'package:skyone_mobile/modules/system/login/model.dart';
import 'package:skyone_mobile/util/global_functions.dart';
import 'package:skyone_mobile/util/http.dart';
import 'package:skyone_mobile/util/string_util.dart';
import 'package:tuple/tuple.dart';

class LoginRepo {
  static Future<Tuple2<LoginResponse, dynamic>> login({String username, String password}) async {
    try {
      final jsonBody = json.encode({'username': username, 'password': password});
      final response = await Http.postWithoutToken('sys/auth/${StringUtil.toSnackCase("login")}', jsonBody: jsonBody);

      log(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 400) {
        final loginResponse = LoginResponse.fromJson(json.decode(response.body) as Map<String, dynamic>);
        return Tuple2(loginResponse, null);
      } else {
        return Tuple2(null, Exception('Status code: ${response.statusCode}'));
      }
    } catch (e) {
      log(e);
      return Tuple2(null, e);
    }
  }

  static Future<Tuple2<LoginResponse, dynamic>> signInWithOauth2({String id}) async {
    try {
      final jsonBody = json.encode({'username': id});
      final response = await Http.postWithoutToken('sys/auth/${StringUtil.toSnackCase("signInWithOauth2")}', jsonBody: jsonBody);

      log(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 400) {
        final loginResponse = LoginResponse.fromJson(json.decode(response.body) as Map<String, dynamic>);
        return Tuple2(loginResponse, null);
      } else {
        return Tuple2(null, Exception('Status code: ${response.statusCode}'));
      }
    } catch (e) {
      log(e);
      return Tuple2(null, e);
    }
  }

  static Future<Tuple2<bool, dynamic>> isValidToken(String token) async {
    try {
      final response =
          await Http.getWithoutToken('sys/auth/${StringUtil.toSnackCase("checkToken")}', params: {'token': token});

      if (response.statusCode == 200 || response.statusCode == 400) {
        final validToken = response.body.toLowerCase() == 'true';
        return Tuple2(validToken, null);
      } else {
        return Tuple2(null, Exception('Status code: ${response.statusCode}'));
      }
    } catch (e) {
      log(e);
      return Tuple2(null, e);
    }
  }

  static Future<Tuple2<bool, dynamic>> changePw(String currentPassword, String newPassword) async {
    try {
      final jsonBody = json.encode({'currentPassword': currentPassword, 'newPassword': newPassword});
      final response = await Http.post('sys/auth/${StringUtil.toSnackCase("changePw")}', jsonBody: jsonBody);

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
