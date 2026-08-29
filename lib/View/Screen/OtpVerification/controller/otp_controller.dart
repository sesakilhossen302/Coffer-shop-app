import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final TextEditingController pinController = TextEditingController();
  final RxBool isEmailVerification = false.obs;
  final RxString targetDestination = '+52 9999 10 20 30'.obs;
  final RxBool hasError = false.obs;
  final RxInt timerSeconds = 20.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      isEmailVerification.value = args['isEmail'] ?? false;
      targetDestination.value = args['target'] ?? (isEmailVerification.value ? 'helloworld@gmail.com' : '+52 9999 10 20 30');
    }
    startResendTimer();
  }

  void startResendTimer() {
    timerSeconds.value = 20;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void verifyPin(String pin) {
    if (pin.length == 5) {
      if (pin == '12345') {
        hasError.value = false;
        // Navigation on success
      } else {
        hasError.value = true;
      }
    }
  }

  void resendCode() {
    pinController.clear();
    hasError.value = false;
    startResendTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    pinController.dispose();
    super.onClose();
  }
}
