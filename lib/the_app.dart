import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyone_mobile/modules/system/home/index.dart';
import 'package:skyone_mobile/modules/system/home/settings.dart';
import 'package:skyone_mobile/modules/system/login/index.dart';
import 'package:skyone_mobile/modules/system/splash/index.dart';
import 'package:skyone_mobile/the_app_controller.dart';
import 'package:skyone_mobile/util/app.dart';
import 'package:skyone_mobile/util/global_var.dart';
import 'package:skyone_mobile/util/locale_resource.dart';

class TheApp extends StatelessWidget {
  final TheAppController _theAppController = Get.put(TheAppController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        drawer: _buildDrawer(context),
        appBar: _theAppController.showAppBar.value
            ? AppBar(
                title: const Text(App.appName),
              )
            : null,
        body: Center(child: Obx(() {
          final appStatus = _theAppController.appStatusContainer.value.status;
          if (appStatus is SplashStatus) {
            return SplashPage();
          } else if (appStatus is LoginStatus) {
            return LoginPage();
          } else {
            return HomePage();
          }
        })),
      );
    });
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
                icon: Image.asset(
                  'assets/logo.png',
                ),
                onPressed: () {}),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(LR.l10n('COMMON.LABEL.SETTINGS')),
            onTap: () {
              Navigator.pop(context);

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return SettingsPage();
                  });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(LR.l10n('PORTAL.BUTTON.LOGOUT')),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) async {
    App.storage.remove("REMEMBER_LOGIN");
    App.storage.remove("TOKEN");
    Navigator.pop(context);
    Get.find<TheAppController>().changeStatus(LoginStatus());

    await googleSignIn.signOut();
    await facebookSignIn.logOut();
    await zaloSignIn.logOut();
  }
}
