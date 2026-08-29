import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
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
        title: 'COFFECITO',
        requiredPoints: 50,
        imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
        hasRedeemBadge: true,
      ).obs;
    }
  }

  bool get hasEnoughPoints => userPoints.value >= reward.value.requiredPoints;

  int get pointsNeeded => (reward.value.requiredPoints - userPoints.value).clamp(0, 9999);

  double get progressRatio =>
      (userPoints.value / reward.value.requiredPoints).clamp(0.0, 1.0);

  void redeem() {
    if (hasEnoughPoints) {
      // Navigate to RewardRedeemedScreen (matching connected checkout flow)
      Get.toNamed(
        AppRoute.rewardRedeemedScreen,
        arguments: reward.value,
      );
    }
  }
}
