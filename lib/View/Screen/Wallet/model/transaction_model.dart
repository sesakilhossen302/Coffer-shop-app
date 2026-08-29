enum TransactionType { giftCard, order, addedMoney, sentCard }

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final TransactionType type;
  final bool isPositive;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    this.isPositive = false,
  });
}
