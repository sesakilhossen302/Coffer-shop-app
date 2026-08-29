import 'package:get/get.dart';
import '../model/order_history_model.dart';

class OrderHistoryController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0: Upcoming, 1: Completed

  final RxList<OrderHistoryModel> upcomingOrders = <OrderHistoryModel>[
    OrderHistoryModel(
      orderId: '#1234',
      title: 'Garlic Bread, Am...',
      itemCount: 3,
      price: '\$120',
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
      extraBadgeCount: '+2',
      status: OrderStatus.pending,
    ),
    OrderHistoryModel(
      orderId: '#1234',
      title: 'Garlic Bread, Am...',
      itemCount: 3,
      price: '\$120',
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
      extraBadgeCount: '+2',
      status: OrderStatus.pending,
    ),
    OrderHistoryModel(
      orderId: '#1234',
      title: 'Garlic Bread, Am...',
      itemCount: 3,
      price: '\$120',
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
      extraBadgeCount: '+2',
      status: OrderStatus.pending,
    ),
    OrderHistoryModel(
      orderId: '#1234',
      title: 'Garlic Bread, Am...',
      itemCount: 3,
      price: '\$120',
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
      extraBadgeCount: '+2',
      status: OrderStatus.pending,
    ),
  ].obs;

  final RxList<OrderHistoryModel> completedOrders = <OrderHistoryModel>[
    OrderHistoryModel(
      orderId: '#1234',
      title: 'Garlic Bread, Am...',
      itemCount: 3,
      price: '\$120',
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
      extraBadgeCount: '+2',
      status: OrderStatus.completed,
    ),
    OrderHistoryModel(
      orderId: '#1234',
      title: 'Garlic Bread, Am...',
      itemCount: 3,
      price: '\$120',
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
      extraBadgeCount: '+2',
      status: OrderStatus.completed,
    ),
    OrderHistoryModel(
      orderId: '#1234',
      title: 'Garlic Bread, Am...',
      itemCount: 3,
      price: '\$120',
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
      extraBadgeCount: '+2',
      status: OrderStatus.completed,
    ),
    OrderHistoryModel(
      orderId: '#1234',
      title: 'Garlic Bread, Am...',
      itemCount: 3,
      price: '\$120',
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
      extraBadgeCount: '+2',
      status: OrderStatus.completed,
    ),
  ].obs;
}
