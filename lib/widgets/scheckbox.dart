import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SCheckbox extends StatelessWidget {
  Function _onChanged;
  final CheckController _checkController = Get.put(CheckController());
  String _text;

  SCheckbox({Function onChanged, String text, bool checked = false}) {
    _onChanged = onChanged;
    setChecked(checked);
    _text = text;
  }

  void setChecked(bool checked) {
    _checkController.checked.value = checked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => Checkbox(
              value: _checkController.checked.value,
              onChanged: (checked) {
                if (_onChanged != null) {
                  _onChanged(checked);
                }
                setChecked(checked);
              },
            )),
        if (_text != null) Text(_text)
      ],
    );
  }
}

class CheckController extends GetxController {
  Rx<bool> checked = Rx<bool>();
}
