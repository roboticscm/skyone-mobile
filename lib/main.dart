import 'package:bot_toast/bot_toast.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyone_mobile/modules/system/home/language.dart';
import 'package:skyone_mobile/the_app.dart';
import 'package:skyone_mobile/theme/theme_controller.dart';
import 'package:skyone_mobile/util/app.dart';
import 'package:skyone_mobile/util/global_functions.dart';
import 'package:skyone_mobile/util/global_param.dart';
import 'package:skyone_mobile/util/global_var.dart';
import 'package:skyone_mobile/util/l10n.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  App.storage = await SharedPreferences.getInstance();
  GlobalParam.load();
  final savedLocale = await getSavedLocale();
  App.appInstance = Application(savedLocale);
  await App.appInstance.firebaseMessaging.requestNotificationPermissions();
  runApp(App.appInstance);
}

class Application extends StatelessWidget {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final ThemeController _themeController = Get.put(ThemeController());
  LocaleController _localeController;

  Application(Locale savedLocale) {
    _localeController = Get.put(LocaleController(savedLocale));

    firebaseMessaging.onTokenRefresh.listen((event) {
      App.fcmToken = event;
      log(App.fcmToken);
    });

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        log("onMessage: $message");
      },
      onBackgroundMessage: firebaseBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        _navigateView('${message['data']['view']}');
      },
      onResume: (Map<String, dynamic> message) async {
        _navigateView('${message['data']['view']}');
      },
    );
    firebaseMessaging.subscribeToTopic("skyone");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp(
          navigatorKey: locator<NavigationService>().navigatorKey,
          debugShowCheckedModeBanner: false,
          title: App.appName,
          locale: _localeController.locale.value,
          theme: _themeController.themeData.value,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          localizationsDelegates: const [
            L10nDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US')],
          home: TheApp()),
    );
  }

  void setLocale(LanguageList newLang) async {
    _localeController.setLocale(newLang);
  }

  void _navigateView(String view, {Map<String, dynamic> params}) {
    Widget widget;
    switch (view) {
      case 'testView':
        widget = Scaffold(
          appBar: AppBar(),
          body: const Text('text'),
        );
        break;
      default:
        widget = const Text('text');
    }

    // check if view need logged in
    if (App.storage.getString('TOKEN') != null) {
      Navigator.push(
          locator<NavigationService>().navigatorKey.currentContext, MaterialPageRoute(builder: (_) => widget));
    }
  }
}

class LocaleController extends GetxController {
  Rx<Locale> locale = Rx<Locale>();
  LocaleController(Locale initLocale) {
    locale.value = initLocale;
  }

  void setLocale(LanguageList newLang) async {
    final Locale system = await Devicelocale.currentAsLocale;
    Locale lang;
    switch (newLang) {
      case LanguageList.system:
        lang = system;
        break;
      case LanguageList.vietnamese:
        lang = const Locale('vi', 'VN');
        break;
      case LanguageList.english:
        lang = const Locale('en', 'US');
        break;
    }
    locale.value = lang;
  }
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> pushNamed(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> push(Widget widget) {
    return navigatorKey.currentState.push(MaterialPageRoute(builder: (_) => widget));
  }
}
