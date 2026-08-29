import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/gift_card_model.dart';
import '../model/reward_model.dart';

class RewardsController extends GetxController {
  final RxInt userPoints = 50.obs;
  final int targetPoints = 600;

  final RxInt selectedRewardTab = 0.obs;

  final RxList<RewardModel> availableRewards = <RewardModel>[
    RewardModel(
      id: 'r1',
      title: 'COFFECITO',
      requiredPoints: 50,
      imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
      hasRedeemBadge: true,
      isEarned: true,
    ),
    RewardModel(
      id: 'r2',
      title: 'Galleta gratis',
      requiredPoints: 750,
      imageUrl: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=500&q=80',
      hasRedeemBadge: false,
    ),
    RewardModel(
      id: 'r3',
      title: 'Café gratis',
      requiredPoints: 600,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500&q=80',
      hasRedeemBadge: false,
      isEarned: true,
    ),
    RewardModel(
      id: 'r4',
      title: 'Café gratis',
      requiredPoints: 600,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500&q=80',
      hasRedeemBadge: false,
      isRedeemed: true,
    ),
  ].obs;

  final RxList<GiftCardModel> giftCards = <GiftCardModel>[
    GiftCardModel(
      id: 'g1',
      title: 'COFFECITO',
      amountText: '400MXN',
      cardColor: const Color(0xFF195ABE),
      svgPath: 'assets/icons/ICON (14).svg',
    ),
    GiftCardModel(
      id: 'g2',
      title: '800MXN',
      amountText: '800MXN',
      cardColor: const Color(0xFF1557BA),
      svgPath: 'assets/icons/800MXN-Icons.svg',
    ),
  ].obs;

  int get maxPoints => targetPoints;
  int get remainingPoints => (targetPoints - userPoints.value).clamp(0, targetPoints);
  double get progressPercentage => (userPoints.value / targetPoints).clamp(0.0, 1.0);

  void selectRewardTab(int index) {
    selectedRewardTab.value = index;
  }

  void redeemReward(RewardModel reward) {
    if (userPoints.value >= reward.requiredPoints) {
      userPoints.value -= reward.requiredPoints;
      Get.snackbar(
        'Reward Redeemed!',
        'You redeemed ${reward.title} for ${reward.requiredPoints} pts.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF195ABE),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } else {
      Get.snackbar(
        'Insufficient Points',
        'You need ${reward.requiredPoints - userPoints.value} more points to redeem this reward.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  void purchaseGiftCard(GiftCardModel card) {
    Get.snackbar(
      'Gift Card Purchased',
      'You purchased ${card.amountText} gift card.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF195ABE),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }
}
