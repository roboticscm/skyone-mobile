import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skyone_mobile/modules/system/home/language.dart';
import 'package:skyone_mobile/modules/system/home/locale_resource/repo.dart';
import 'package:skyone_mobile/util/app.dart';
import 'package:skyone_mobile/util/global_functions.dart';
import 'package:skyone_mobile/util/global_param.dart';
import 'package:skyone_mobile/util/locale_resource.dart';
import 'package:skyone_mobile/widgets/close_button.dart';
import 'package:skyone_mobile/widgets/save_button.dart';

class Server {
  static const defaultServerUrlReleaseMode = 'https://skyhub.suntech.com.vn:8443';
  static const defaultServerUrlDebugMode = 'http://172.26.50.19:7581';

  static const defaultServerUrl = kReleaseMode ? defaultServerUrlReleaseMode : defaultServerUrlDebugMode;
  static const defaultConnectionTimeout = 5; //second

  static void showConfigDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ServerConfigPage();
      },
    );
  }
}

class ServerConfigPage extends StatelessWidget {
  final _serverURLController = TextEditingController();
  final _timeoutController = TextEditingController();

  ServerConfigPage() {
    _serverURLController.text = GlobalParam.serverUrl;
    _timeoutController.text = '${GlobalParam.connectionTimeout}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: InkWell(
          onLongPress: () {
            if (_serverURLController.text.trim() == Server.defaultServerUrlReleaseMode) {
              _serverURLController.text = Server.defaultServerUrlDebugMode;
            } else {
              _serverURLController.text = Server.defaultServerUrlReleaseMode;
            }
          },
          child: Text(LR.l10n('COMMON.LABEL.SERVER_CONFIG'))),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _serverURLController,
              decoration: InputDecoration(labelText: LR.l10n('COMMON.LABEL.SERVER_URL')),
            ),
            TextFormField(
              controller: _timeoutController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: LR.l10n('COMMON.LABEL.CONNECTION_TIMEOUT')),
            )
          ],
        ),
      ),
      actions: <Widget>[
        const SCloseButton(),
        SaveButton(
          onTap: () async {
            GlobalParam.serverUrl = _serverURLController.text.trim();
            GlobalParam.baseApiUrl = '${GlobalParam.serverUrl}/api/';

            GlobalParam.connectionTimeout = int.parse(_timeoutController.text.trim());

            await App.storage.setString("SERVER_URL", GlobalParam.serverUrl);
            await App.storage.setInt("CONNECTION_TIMEOUT", GlobalParam.connectionTimeout);
            final l = await getSavedLocale();
            await LocaleResourceRepo.sysGetLocaleResourceListByCompanyIdAndLocale('${l.languageCode}-${l.countryCode}');
            App.appInstance.setLocale(LanguageList.values[App.storage.getInt('LANGUAGE') ?? 0]);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
