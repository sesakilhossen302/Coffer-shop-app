import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../view/widgets/payment_success_dialog.dart';

class MakePaymentController extends GetxController {
  TextEditingController _cardNumberController = TextEditingController(text: '5554 2834 8857 5370');
  TextEditingController get cardNumberController {
    try {
      final _ = _cardNumberController.text;
    } catch (_) {
      _cardNumberController = TextEditingController(text: '5554 2834 8857 5370');
    }
    return _cardNumberController;
  }

  TextEditingController _holderNameController = TextEditingController(text: 'Nombre Apellido');
  TextEditingController get holderNameController {
    try {
      final _ = _holderNameController.text;
    } catch (_) {
      _holderNameController = TextEditingController(text: 'Nombre Apellido');
    }
    return _holderNameController;
  }

  TextEditingController _cvvController = TextEditingController(text: '•••');
  TextEditingController get cvvController {
    try {
      final _ = _cvvController.text;
    } catch (_) {
      _cvvController = TextEditingController(text: '•••');
    }
    return _cvvController;
  }

  final RxString selectedMonth = 'January'.obs;
  final RxString selectedYear = '2026'.obs;
  final RxDouble payableAmount = 40.00.obs;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<String> years = ['2024', '2025', '2026', '2027', '2028', '2029', '2030'];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map && args.containsKey('amount')) {
      payableAmount.value = args['amount'] ?? 40.00;
    }
  }

  void processPayment() {
    Get.dialog(
      PaymentSuccessDialog(
        onOkPressed: () {
          Get.back();
          Get.offNamed(AppRoute.orderReceivedScreen);
        },
      ),
      barrierDismissible: false,
    );
  }
}
