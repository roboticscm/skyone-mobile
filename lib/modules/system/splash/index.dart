import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyone_mobile/the_app_controller.dart';
import 'package:skyone_mobile/util/exception.dart';
import 'package:skyone_mobile/util/server.dart';
import 'package:skyone_mobile/widgets/scircular_progress_indicator.dart';

class SplashPage extends StatelessWidget {
  final SplashController _splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    _splashController.load();
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_splashController.status.value is TimeoutException) ServerConfigPage(),
            if (_splashController.status.value is Exception) ExceptionPage(_splashController.status.value.toString()),
            if (_splashController.status.value is! TimeoutException && _splashController.status.value is! Exception)
              Center(
                child: FittedBox(
                  child: Column(
                    children: <Widget>[
                      Text(
                        _splashController.status.value.toString() ?? 'Init app..',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SCircularProgressIndicator.buildSmallCenter()
                    ],
                  ),
                ),
              )
          ],
        ));
  }
}

class SplashController extends GetxController {
  Rx<dynamic> status = Rx<dynamic>();

  void load() async {
    status.value = 'Init app..';
//    await Future.delayed(Duration(seconds: 1));
    final TheAppController theAppController = Get.find();
    theAppController.changeStatus(LoginStatus());
  }
}
