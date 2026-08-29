import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class LoginController extends GetxController {
  TextEditingController _inputController = TextEditingController();
  TextEditingController get inputController {
    try {
      final _ = _inputController.text;
    } catch (_) {
      _inputController = TextEditingController();
    }
    return _inputController;
  }

  final RxBool isEmailMode = false.obs;

  void toggleLoginMode() {
    isEmailMode.value = !isEmailMode.value;
    inputController.clear();
  }

  void submitLogin() {
    Get.offAllNamed(AppRoute.homeScreen);
  }
}
