class RewardModel {
  final String id;
  final String title;
  final int requiredPoints;
  final String imageUrl;
  final bool hasRedeemBadge;

  RewardModel({
    required this.id,
    required this.title,
    required this.requiredPoints,
    required this.imageUrl,
    this.hasRedeemBadge = false,
  });
}
