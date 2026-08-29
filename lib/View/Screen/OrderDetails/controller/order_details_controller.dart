import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/order_detail_item_model.dart';

enum OrderDetailStatus { pending, completed }

class OrderDetailsController extends GetxController {
  final Rx<OrderDetailStatus> status = OrderDetailStatus.pending.obs;
  final RxString orderId = '#10234'.obs;
  final RxString date = 'May 13, 2026'.obs;
  final RxString location = 'Sonargaon Road · 2.6 km'.obs;
  final RxString totalPrice = '+\$105.00'.obs;
  final RxInt rewardPoints = 50.obs;

  final RxList<OrderDetailItemModel> orderItems = <OrderDetailItemModel>[
    OrderDetailItemModel(
      id: 'od1',
      title: 'Garlic Bread',
      price: '\$30',
      quantity: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
    ),
    OrderDetailItemModel(
      id: 'od2',
      title: 'Iced Americano',
      price: '\$30',
      quantity: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
    ),
    OrderDetailItemModel(
      id: 'od3',
      title: 'Espresso',
      price: '\$45',
      quantity: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=500&q=80',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      if (args['status'] == 'completed' || args['status'] == OrderDetailStatus.completed) {
        status.value = OrderDetailStatus.completed;
      } else {
        status.value = OrderDetailStatus.pending;
      }
      if (args['orderId'] != null) orderId.value = args['orderId'];
      if (args['date'] != null) date.value = args['date'];
      if (args['totalPrice'] != null) totalPrice.value = args['totalPrice'];
    }
  }

  void toggleFavorite(OrderDetailItemModel item) {
    item.isFavorite = !item.isFavorite;
    orderItems.refresh();
    Get.snackbar(
      item.isFavorite ? 'Added to Favorites' : 'Removed from Favorites',
      '${item.title} has been ${item.isFavorite ? 'added to' : 'removed from'} your favorites.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF195ABE),
      colorText: Colors.white,
    );
  }
}
