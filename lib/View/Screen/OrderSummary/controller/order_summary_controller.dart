import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/StaticString/static_string.dart';

class OrderSummaryController extends GetxController {
  TextEditingController _discountCodeController = TextEditingController();
  TextEditingController get discountCodeController {
    try {
      final _ = _discountCodeController.text;
    } catch (_) {
      _discountCodeController = TextEditingController();
    }
    return _discountCodeController;
  }

  final RxString itemTitle = 'Garlic Bread'.obs;
  final RxString itemCustomization =
      'Toasted bread with buttery garlic flavor.'.obs;
  final RxDouble unitPrice = 30.00.obs;
  final RxInt quantity = 1.obs;
  final RxString itemImageUrl =
      'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80'.obs;

  final RxDouble taxes = 15.00.obs;
  final RxDouble discountAmount = 5.00.obs;
  final RxString selectedPaymentMethod = StaticString.cardMasked.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      itemTitle.value = args['title'] ?? 'Garlic Bread';
      itemCustomization.value =
          args['customization'] ?? 'Toasted bread with buttery garlic flavor.';
      unitPrice.value = (args['price'] as num?)?.toDouble() ?? 30.00;
      itemImageUrl.value = args['imageUrl'] ??
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80';
    }
  }

  double get subtotal => unitPrice.value * quantity.value;
  double get grandTotal =>
      (subtotal + taxes.value - discountAmount.value).clamp(0.0, 9999.0);

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
      Get.snackbar(
        'Discount Applied',
        'Your discount code has been applied!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF195ABE),
        colorText: Colors.white,
      );
    }
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void placeOrder() {
    Get.toNamed(
      AppRoute.makePaymentScreen,
      arguments: {
        'amount': grandTotal,
      },
    );
  }
}
