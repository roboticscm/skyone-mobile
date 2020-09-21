import 'package:get/get.dart';

class AppStatus {}

class SplashStatus extends AppStatus {}

class LoginStatus extends AppStatus {}

class LoggedInStatus extends AppStatus {}

class AppStatusContainer {
  AppStatus status = SplashStatus();
}

class TheAppController extends GetxController {
  final Rx<AppStatusContainer> appStatusContainer = AppStatusContainer().obs;
  final RxBool showAppBar = false.obs;

  void changeStatus(AppStatus newAppStatus) {
    appStatusContainer.update((value) {
      value.status = newAppStatus;
    });

    showAppBar.value = newAppStatus is LoggedInStatus;
  }
}
