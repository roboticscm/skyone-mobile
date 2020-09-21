import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyone_mobile/modules/system/login/repo.dart';
import 'package:skyone_mobile/util/locale_resource.dart';
import 'package:skyone_mobile/extension/string.dart';

class ProfilesUI extends StatelessWidget {
  final ProfilesController _profilesController = Get.put(ProfilesController());

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  ProfilesUI() {
    _currentPasswordController.addListener(() {
      _profilesController.setCurrentPassword(_currentPasswordController.text.trim());
    });

    _newPasswordController.addListener(() {
      _profilesController.setNewPassword(_newPasswordController.text.trim());
    });

    _confirmPasswordController.addListener(() {
      _profilesController.setConfirmPassword(
          _newPasswordController.text.trim(), _confirmPasswordController.text.trim());
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autocorrect: false,
                decoration: InputDecoration(
                  errorText: _profilesController.currentPasswordError.value,
                  labelText: 'PORTAL.LABEL.CURRENT_PASSWORD'.t(),
                ),
                controller: _currentPasswordController,
                obscureText: true,
              ),
              TextField(
                autocorrect: false,
                decoration: InputDecoration(
                  errorText: _profilesController.newPasswordError.value,
                  labelText: 'PORTAL.LABEL.NEW_PASSWORD'.t(),
                ),
                controller: _newPasswordController,
                obscureText: true,
              ),
              TextField(
                autocorrect: false,
                decoration: InputDecoration(
                  errorText: _profilesController.confirmPasswordError.value,
                  labelText: 'PORTAL.LABEL.CONFIRM_PASSWORD'.t(),
                ),
                controller: _confirmPasswordController,
                obscureText: true,
              )
            ],
          )),
    );
  }

  Future<bool> changePassword(BuildContext context) async {
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isNotEmpty || confirmPassword.isNotEmpty) {
      if (newPassword.isEmpty) {
        BotToast.showText(text: 'COMMON.MSG.NEW_PASSWORD_MUST_NOT_EMPTY'.t());
        return false;
      } else if (newPassword != confirmPassword) {
        BotToast.showText(text: 'COMMON.MSG.PASSWORD_CONFIRMATION_DOES_NOT_MATCH'.t());
        return false;
      } else {
        final res = await LoginRepo.changePw(currentPassword, newPassword);
        if (res.item1) {
          return true;
        } else {
          BotToast.showText(text: LR.l10n('${res.item2}'));
          return false;
        }
      }
    } else {
      return true;
    }
  }
}

class ProfilesController extends GetxController {
  final Rx<String> currentPasswordError = Rx<String>();
  final Rx<String> newPasswordError = Rx<String>();
  final Rx<String> confirmPasswordError = Rx<String>();

  void setCurrentPassword(String password) {
    currentPasswordError.value = password.isEmpty ? 'CURRENT_PASSWORD_MUST_NOT_EMPTY' : null;
  }

  void setNewPassword(String password) {
    newPasswordError.value = password.isEmpty ? 'NEW_PASSWORD_MUST_NOT_EMPTY' : null;
  }

  void setConfirmPassword(String newPassword, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'CONFIRM_PASSWORD_MUST_NOT_EMPTY';
    } else if (newPassword != confirmPassword) {
      confirmPasswordError.value = 'PASSWORD_CONFORMATION_DOES_NOT_MATCH';
    } else {
      confirmPasswordError.value = null;
    }
  }
}
