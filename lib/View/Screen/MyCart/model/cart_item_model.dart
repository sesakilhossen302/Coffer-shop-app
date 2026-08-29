class CartItemModel {
  final String id;
  final String title;
  final String customization;
  final double unitPrice;
  int quantity;
  final String imageUrl;

  CartItemModel({
    required this.id,
    required this.title,
    required this.customization,
    required this.unitPrice,
    this.quantity = 1,
    required this.imageUrl,
  });

  double get totalPrice => unitPrice * quantity;
}
