import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class OrderSummaryController extends GetxController {
  final TextEditingController discountCodeController = TextEditingController();

  final RxString itemTitle = 'Iced Americano'.obs;
  final RxString itemCustomization = 'Extra shot of espresso + almond milk'.obs;
  final RxDouble unitPrice = 30.00.obs;
  final RxInt quantity = 1.obs;
  final RxString itemImageUrl =
      'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80'.obs;

  final RxDouble taxes = 15.00.obs;
  final RxDouble discountAmount = 5.00.obs;
  final RxString selectedPaymentMethod = 'Cash'.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      itemTitle.value = args['title'] ?? 'Iced Americano';
      itemCustomization.value = args['customization'] ?? 'Extra shot of espresso + almond milk';
      unitPrice.value = args['price'] ?? 30.00;
      itemImageUrl.value = args['imageUrl'] ??
          'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80';
    }
  }

  double get subtotal => unitPrice.value * quantity.value;
  double get grandTotal => (subtotal + taxes.value - discountAmount.value).clamp(0.0, 9999.0);

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void applyDiscount() {
    if (discountCodeController.text.trim().isNotEmpty) {
      discountAmount.value = 10.00;
    }
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void placeOrder() {
    Get.defaultDialog(
      title: 'Order Placed!',
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      content: const Text(
        'Your order has been placed successfully. Thank you for choosing Coffecito!',
        textAlign: TextAlign.center,
      ),
      textConfirm: 'Back to Home',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF195ABE),
      onConfirm: () {
        Get.offAllNamed(AppRoute.homeScreen);
      },
    );
  }

  @override
  void onClose() {
    discountCodeController.dispose();
    super.onClose();
  }
}
