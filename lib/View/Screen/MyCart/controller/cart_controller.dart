import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/cart_item_model.dart';

class CartController extends GetxController {
  TextEditingController _discountCodeController = TextEditingController();
  TextEditingController get discountCodeController {
    try {
      final _ = _discountCodeController.text;
    } catch (_) {
      _discountCodeController = TextEditingController();
    }
    return _discountCodeController;
  }

  final RxList<CartItemModel> cartItems = <CartItemModel>[
    CartItemModel(
      id: '1',
      title: 'Iced Americano',
      customization: 'Extra shot of espresso + almond milk',
      unitPrice: 30.00,
      quantity: 1,
      imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
    ),
    CartItemModel(
      id: '2',
      title: 'Croissant',
      customization: 'Handmade puff pastry, light and buttery.',
      unitPrice: 25.00,
      quantity: 2,
      imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=500&q=80',
    ),
  ].obs;

  final RxDouble taxes = 15.00.obs;
  final RxDouble discountAmount = 5.00.obs;
  final RxString selectedPaymentMethod = 'Cash'.obs;

  double get subtotal => cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get grandTotal => (subtotal + taxes.value - discountAmount.value).clamp(0.0, 9999.0);

  void incrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
      cartItems.refresh();
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

  void clearCart() {
    cartItems.clear();
  }

  void placeOrder() {
    // Process checkout order
  }
}
