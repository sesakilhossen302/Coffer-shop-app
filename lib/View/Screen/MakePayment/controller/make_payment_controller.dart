import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../view/widgets/payment_success_dialog.dart';

class MakePaymentController extends GetxController {
  final TextEditingController cardNumberController =
      TextEditingController(text: '5554 2834 8857 5370');
  final TextEditingController holderNameController =
      TextEditingController(text: 'Nombre Apellido');
  final TextEditingController cvvController = TextEditingController(text: '•••');

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
    // Show Payment Success Dialog (Screen 3 matching design)
    Get.dialog(
      PaymentSuccessDialog(
        onOkPressed: () {
          Get.back(); // Close dialog
          Get.offNamed(AppRoute.orderReceivedScreen); // Navigate to Order Received screen (Screen 1)
        },
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    holderNameController.dispose();
    cvvController.dispose();
    super.onClose();
  }
}
