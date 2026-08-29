import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Rewards/controller/rewards_controller.dart';
import '../../Rewards/model/reward_model.dart';

class RewardDetailsController extends GetxController {
  late Rx<RewardModel> reward;
  final RxInt userPoints = 50.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<RewardsController>()) {
      userPoints.value = Get.find<RewardsController>().userPoints.value;
    }

    final args = Get.arguments;
    if (args != null && args is RewardModel) {
      reward = args.obs;
    } else {
      reward = RewardModel(
        id: '1',
        title: 'Galleta gratis',
        requiredPoints: 750,
        imageUrl: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=500&q=80',
        hasRedeemBadge: false,
      ).obs;
    }
  }

  bool get hasEnoughPoints => userPoints.value >= reward.value.requiredPoints;

  int get pointsNeeded => (reward.value.requiredPoints - userPoints.value).clamp(0, 9999);

  double get progressRatio =>
      (userPoints.value / reward.value.requiredPoints).clamp(0.0, 1.0);

  void redeem() {
    if (hasEnoughPoints) {
      if (Get.isRegistered<RewardsController>()) {
        Get.find<RewardsController>().userPoints.value -= reward.value.requiredPoints;
      }
      userPoints.value -= reward.value.requiredPoints;

      Get.snackbar(
        'Reward Redeemed!',
        'You have successfully redeemed ${reward.value.title}. Show this to the cashier.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF195ABE),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}
