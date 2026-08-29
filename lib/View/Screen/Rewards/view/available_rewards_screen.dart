import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/rewards_controller.dart';
import '../model/reward_model.dart';

class AvailableRewardsScreen extends StatelessWidget {
  const AvailableRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardsController controller = Get.isRegistered<RewardsController>()
        ? Get.find<RewardsController>()
        : Get.put(RewardsController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Blue Header Section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1E90FF),
            ),
            padding: EdgeInsets.only(
              left: 12.w,
              right: 16.w,
              top: statusBarHeight + 10.h,
              bottom: 16.h,
            ),
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    StaticString.availableRewardsTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 36.w), // Spacer for centering
              ],
            ),
          ),

          // Main Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Floating White Points Display Card
                  Container(
                    width: double.infinity,
                    height: 76.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        // Circular Progress Ring & 3D Gold Coin
                        Obx(
                          () => SizedBox(
                            width: 50.r,
                            height: 50.r,
                            child: CustomPaint(
                              painter: _MiniCircularRingPainter(
                                  progress: controller.progressPercentage),
                              child: Center(
                                child: Image.asset(
                                  AppIcons.homePageCoinImg,
                                  width: 30.w,
                                  height: 30.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 16.w),

                        // "50 points" Text
                        Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${controller.userPoints.value} ',
                                style: GoogleFonts.jost(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF195ABE),
                                ),
                              ),
                              Text(
                                StaticString.pointsText,
                                style: GoogleFonts.jost(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF195ABE),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // 3-Tab Bar Switcher (All, Earned, Redeemed)
                  Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F8),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.all(3.r),
                    child: Obx(
                      () => Row(
                        children: [
                          _buildTabItem(controller, 0, StaticString.all),
                          _buildTabItem(controller, 1, StaticString.earned),
                          _buildTabItem(controller, 2, StaticString.redeemedBadge),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // 2-Column Grid of Reward Cards
                  Obx(() {
                    final int activeTab = controller.selectedRewardTab.value;
                    List<RewardModel> filteredList = [];
                    if (activeTab == 0) {
                      filteredList = controller.availableRewards;
                    } else if (activeTab == 1) {
                      filteredList = controller.availableRewards
                          .where((r) => r.isEarned || r.hasRedeemBadge)
                          .toList();
                    } else {
                      filteredList = controller.availableRewards
                          .where((r) => r.isRedeemed)
                          .toList();
                    }

                    if (filteredList.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Center(
                          child: Text(
                            'No rewards found in this section.',
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              color: const Color(0xFF888888),
                            ),
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.78,
                      ),
                      itemBuilder: (context, index) {
                        return _buildRewardGridCard(filteredList[index], controller);
                      },
                    );
                  }),

                  SizedBox(height: 28.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- TAB BUTTON ITEM WIDGET ----------
  Widget _buildTabItem(RewardsController controller, int index, String title) {
    final bool isSelected = controller.selectedRewardTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectRewardTab(index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E90FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.jost(
                fontSize: 12.5.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : const Color(0xFF777777),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- REWARD GRID CARD WIDGET ----------
  Widget _buildRewardGridCard(RewardModel reward, RewardsController controller) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoute.rewardDetailsScreen, arguments: reward),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image Container
          Expanded(
            child: Stack(
              children: [
                // Background Image / Gradient
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: (reward.hasRedeemBadge || reward.id == 'r3' || reward.id == 'r4')
                        ? const Color(0xFF1E90FF)
                        : Colors.transparent,
                    image: DecorationImage(
                      image: NetworkImage(reward.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Overlay Gradient
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: reward.hasRedeemBadge
                        ? const Color(0xFF1E90FF).withValues(alpha: 0.38)
                        : Colors.transparent,
                    gradient: (reward.hasRedeemBadge)
                        ? null
                        : LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.1),
                              Colors.black.withValues(alpha: 0.45),
                            ],
                          ),
                  ),
                ),

                if (reward.hasRedeemBadge) ...[
                  // Centered COFFECITO Logo + Running Cup Vector
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 12.h),
                        SvgPicture.asset(
                          AppIcons.coffecitoLogoSvg,
                          height: 18.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 6.h),
                        SvgPicture.asset(
                          AppIcons.rewardIcon14Svg,
                          height: 48.h,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Centered Bold Blue / White Title Text
                  Positioned.fill(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          reward.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.jost(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF195ABE),
                            height: 1.05,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],

                // "Redeem Now" Yellow Badge OR "Redeemed" Green Badge
                if (reward.hasRedeemBadge)
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB800),
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                      child: Text(
                        StaticString.redeemNow,
                        style: GoogleFonts.jost(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF222222),
                        ),
                      ),
                    ),
                  )
                else if (reward.isRedeemed)
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF34C759),
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                      child: Text(
                        StaticString.redeemedBadge,
                        style: GoogleFonts.jost(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          // Points Badge (Home-Page-Coin-img.png + Points)
          Row(
            children: [
              Image.asset(
                AppIcons.homePageCoinImg,
                width: 18.w,
                height: 18.h,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 6.w),
              Text(
                '${reward.requiredPoints} pts',
                style: GoogleFonts.jost(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF195ABE),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------- MINI CIRCULAR RING PAINTER ----------
class _MiniCircularRingPainter extends CustomPainter {
  final double progress;

  _MiniCircularRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 4.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = const Color(0xFFE2E6EC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final progressPaint = Paint()
      ..color = const Color(0xFFFFB800)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.141592653589793 * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _MiniCircularRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
