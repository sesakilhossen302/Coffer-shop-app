import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController inputController = TextEditingController();
  final RxBool isEmailMode = false.obs;

  void toggleLoginMode() {
    isEmailMode.value = !isEmailMode.value;
    inputController.clear();
  }

  void submitLogin() {
    // Handle login submission logic
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }
}
