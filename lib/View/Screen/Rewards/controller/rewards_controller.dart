import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../model/gift_card_model.dart';
import '../model/reward_model.dart';

class RewardsController extends GetxController {
  final RxInt userPoints = 50.obs;
  final int maxPoints = 600;

  int get remainingPoints => (maxPoints - userPoints.value).clamp(0, 9999);
  double get progressPercentage => (userPoints.value / maxPoints).clamp(0.0, 1.0);

  final RxList<RewardModel> availableRewards = <RewardModel>[
    RewardModel(
      id: '1',
      title: 'COFFECITO',
      requiredPoints: 50,
      imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
      hasRedeemBadge: true,
    ),
    RewardModel(
      id: '2',
      title: 'Galleta gratis',
      requiredPoints: 750,
      imageUrl: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=500&q=80',
      hasRedeemBadge: false,
    ),
  ].obs;

  final RxList<GiftCardModel> giftCards = <GiftCardModel>[
    GiftCardModel(
      id: 'g1',
      title: 'COFFECITO',
      amountText: '400MXN',
      cardColor: const Color(0xFF1E90FF),
      svgPath: AppIcons.orderReceivedImg,
    ),
    GiftCardModel(
      id: 'g2',
      title: 'COFFECITO',
      amountText: '800MXN',
      cardColor: const Color(0xFF1557BA),
      svgPath: AppIcons.giftCard800MXNSvg,
    ),
  ].obs;

  void redeemReward(RewardModel reward) {
    if (userPoints.value >= reward.requiredPoints) {
      userPoints.value -= reward.requiredPoints;
      Get.snackbar(
        'Reward Redeemed!',
        'You successfully redeemed ${reward.title} for ${reward.requiredPoints} pts.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF195ABE),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } else {
      Get.snackbar(
        'Not Enough Points',
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
      'Gift Card Selected',
      'Selected ${card.amountText} Gift Card.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF195ABE),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }
}
