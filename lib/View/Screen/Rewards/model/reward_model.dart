class RewardModel {
  final String id;
  final String title;
  final int requiredPoints;
  final String imageUrl;
  final bool hasRedeemBadge;
  final bool isRedeemed;
  final bool isEarned;

  RewardModel({
    required this.id,
    required this.title,
    required this.requiredPoints,
    required this.imageUrl,
    this.hasRedeemBadge = false,
    this.isRedeemed = false,
    this.isEarned = false,
  });
}
