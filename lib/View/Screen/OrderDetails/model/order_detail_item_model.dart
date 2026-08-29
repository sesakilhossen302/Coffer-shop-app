class OrderDetailItemModel {
  final String id;
  final String title;
  final String price;
  final int quantity;
  final String imageUrl;
  bool isFavorite;

  OrderDetailItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
