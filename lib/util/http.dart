import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:skyone_mobile/util/global_param.dart';

class Http {
  static Future<Response> getWithoutToken(String subUrl, {Map<String, dynamic> params}) async {
    return http.get(_paramParser(subUrl, params: params), headers: {
      'Content-Type': 'application/json',
    }).timeout(Duration(seconds: GlobalParam.connectionTimeout));
  }

  static Future<Response> postWithoutToken(String subUrl, {String jsonBody}) async {
    print(_paramParser(subUrl));
    return http
        .post(_paramParser(subUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonBody)
        .timeout(Duration(seconds: GlobalParam.connectionTimeout));
  }

  static Future<Response> post(String subUrl, {String jsonBody}) async {
    return http
        .post(_paramParser(subUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': '${GlobalParam.userId}||| ${GlobalParam.token}',
            },
            body: jsonBody)
        .timeout(Duration(seconds: GlobalParam.connectionTimeout));
  }

  static String _paramParser(String subUrl, {Map<String, dynamic> params}) {
    String paramStr = '';
    if (params != null && params.length > 0) {
      params.forEach((key, value) {
        paramStr += '$key=$value&';
      });
    }

    var fullUrl = '${GlobalParam.baseApiUrl}$subUrl?$paramStr';
    if (fullUrl.endsWith("&")) {
      fullUrl = fullUrl.substring(0, fullUrl.length - 1);
    }

    if (fullUrl.endsWith("?")) {
      fullUrl = fullUrl.substring(0, fullUrl.length - 1);
    }

    return fullUrl;
  }
}
