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
    Get.offAllNamed(AppRoute.homeScreen);
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }
}
