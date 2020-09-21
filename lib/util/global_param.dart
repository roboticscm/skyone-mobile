import 'package:skyone_mobile/util/app.dart';
import 'package:skyone_mobile/util/server.dart';

class GlobalParam {
  static int connectionTimeout;

  static String serverUrl;
  static String baseApiUrl;

  static String token;
  static int userId;

  static void load() {
    serverUrl = App.storage.getString('SERVER_URL') ?? Server.defaultServerUrl;
    baseApiUrl = '$serverUrl/api/';
    connectionTimeout = App.storage.getInt('CONNECTION_TIMEOUT') ?? Server.defaultConnectionTimeout;
  }
}
