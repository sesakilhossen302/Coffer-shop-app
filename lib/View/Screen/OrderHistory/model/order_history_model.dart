enum OrderStatus { pending, completed }

class OrderHistoryModel {
  final String orderId;
  final String title;
  final int itemCount;
  final String price;
  final String imageUrl;
  final String extraBadgeCount;
  final OrderStatus status;

  OrderHistoryModel({
    required this.orderId,
    required this.title,
    required this.itemCount,
    required this.price,
    required this.imageUrl,
    required this.extraBadgeCount,
    required this.status,
  });
}
