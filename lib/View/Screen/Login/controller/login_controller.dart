import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Core/AppRoute/app_route.dart';

class LoginController extends GetxController {
  final TextEditingController inputController = TextEditingController();
  final RxBool isEmailMode = false.obs;

  void toggleLoginMode() {
    isEmailMode.value = !isEmailMode.value;
    inputController.clear();
  }

  void submitLogin() {
    Get.toNamed(
      AppRoute.otpScreen,
      arguments: {
        'isEmail': isEmailMode.value,
        'target': inputController.text.isNotEmpty
            ? inputController.text
            : (isEmailMode.value ? 'helloworld@gmail.com' : '+52 9999 10 20 30'),
      },
    );
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }
}
