import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/rewards_controller.dart';
import '../model/gift_card_model.dart';
import '../model/reward_model.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
          // Top Blue Header Section with Points Card
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1E90FF),
            ),
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: statusBarHeight + 12.h,
              bottom: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Top Row (Greeting & Action Icons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StaticString.yourPoints,
                          style: GoogleFonts.jost(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          StaticString.keepCollecting,
                          style: GoogleFonts.jost(
                            fontSize: 11.5.sp,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),

                    // Notification & Cart Icons
                    Row(
                      children: [
                        // Notification Bell with Red Badge
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoute.notificationScreen),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4.r),
                                child: SvgPicture.asset(
                                  AppIcons.notificationIcon,
                                  width: 22.w,
                                  height: 22.h,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 2,
                                top: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '1',
                                    style: GoogleFonts.jost(
                                      color: Colors.white,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 14.w),

                        // Shopping Cart Icon
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoute.myCartScreen),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 24.r,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 18.h),

                // Floating White Card showing User Points
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
                      // Circular Gold Coin Ring Graphic
                      Container(
                        width: 46.w,
                        height: 46.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFFF9E6),
                          border: Border.all(
                            color: const Color(0xFFFFC107),
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '🪙',
                            style: TextStyle(fontSize: 22.sp),
                          ),
                        ),
                      ),

                      SizedBox(width: 16.w),

                      // "50 points" Display Text
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
              ],
            ),
          ),

          // Scrollable Rewards Body
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Your Progress Section
                  Text(
                    StaticString.yourProgress,
                    style: GoogleFonts.jost(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E90FF),
                    ),
                  ),
                  SizedBox(height: 4.h),

                  Obx(
                    () => Text(
                      '${controller.userPoints.value}/${controller.maxPoints}',
                      style: GoogleFonts.jost(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF195ABE),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Linear Gold Progress Bar
                  Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: LinearProgressIndicator(
                        value: controller.progressPercentage,
                        minHeight: 10.h,
                        backgroundColor: const Color(0xFFE5E5E5),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFB800)),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),

                  Obx(
                    () => Text(
                      'You need ${controller.remainingPoints} more points for a free coffee',
                      style: GoogleFonts.jost(
                        fontSize: 11.5.sp,
                        color: const Color(0xFF195ABE),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Available Rewards Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StaticString.availableRewards,
                        style: GoogleFonts.jost(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E90FF),
                        ),
                      ),
                      Text(
                        StaticString.viewAll,
                        style: GoogleFonts.jost(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E90FF),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Horizontal List of Available Rewards
                  SizedBox(
                    height: 175.h,
                    child: Obx(
                      () => ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.availableRewards.length,
                        separatorBuilder: (context, index) => SizedBox(width: 14.w),
                        itemBuilder: (context, index) {
                          final reward = controller.availableRewards[index];
                          return _buildRewardCard(reward, controller);
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // "How does it work?" Info Banner
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7FF),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: const Color(0xFF1E90FF),
                          size: 20.r,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StaticString.howDoesItWork,
                                style: GoogleFonts.jost(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF222222),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                StaticString.earnPointsDesc,
                                style: GoogleFonts.jost(
                                  fontSize: 11.5.sp,
                                  color: const Color(0xFF666666),
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Gift Card Header Section
                  Text(
                    StaticString.giftCard,
                    style: GoogleFonts.jost(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E90FF),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Action Buttons Row: "Purchase Gift Card" & "Add Existing Gift Card"
                  Row(
                    children: [
                      // Purchase Gift Card Filled Blue Button
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(14.r),
                            child: Container(
                              height: 46.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFF195ABE),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.credit_card_rounded,
                                    color: Colors.white,
                                    size: 18.r,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    StaticString.purchaseGiftCard,
                                    style: GoogleFonts.jost(
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),

                      // Add Existing Gift Card Outlined Button
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(14.r),
                            child: Container(
                              height: 46.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(
                                  color: const Color(0xFFD0D7E2),
                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_box_outlined,
                                    color: const Color(0xFF666666),
                                    size: 18.r,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    StaticString.addExistingGiftCard,
                                    style: GoogleFonts.jost(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  // Gift Card Subtitle & View All Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StaticString.giveCoffeeAndRewards,
                        style: GoogleFonts.jost(
                          fontSize: 11.5.sp,
                          color: const Color(0xFF888888),
                        ),
                      ),
                      Text(
                        StaticString.viewAll,
                        style: GoogleFonts.jost(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E90FF),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Gift Card 1 Banner (400MXN)
                  Obx(
                    () => Column(
                      children: controller.giftCards
                          .map((card) => Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: _buildGiftCardBanner(card, controller),
                              ))
                          .toList(),
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- AVAILABLE REWARD CARD WIDGET ----------
  Widget _buildRewardCard(RewardModel reward, RewardsController controller) {
    return GestureDetector(
      onTap: () => controller.redeemReward(reward),
      child: SizedBox(
        width: 145.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reward Banner Container
            Stack(
              children: [
                Container(
                  height: 135.h,
                  width: 145.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: NetworkImage(reward.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Dark overlay gradient for contrast
                Container(
                  height: 135.h,
                  width: 145.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.45),
                      ],
                    ),
                  ),
                ),

                // Optional "Redeem Now" Yellow Badge
                if (reward.hasRedeemBadge)
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB800),
                        borderRadius: BorderRadius.circular(8.r),
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
                  ),

                // Card Title Text
                Positioned(
                  left: 12.w,
                  bottom: 12.h,
                  right: 12.w,
                  child: Text(
                    reward.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.jost(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 6.h),

            // Points Pill Badge (🪙 50 pts)
            Row(
              children: [
                Text(
                  '🪙 ',
                  style: TextStyle(fontSize: 13.sp),
                ),
                Text(
                  '${reward.requiredPoints} pts',
                  style: GoogleFonts.jost(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF195ABE),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- GIFT CARD BANNER WIDGET ----------
  Widget _buildGiftCardBanner(GiftCardModel card, RewardsController controller) {
    return GestureDetector(
      onTap: () => controller.purchaseGiftCard(card),
      child: Container(
        width: double.infinity,
        height: 155.h,
        decoration: BoxDecoration(
          color: card.cardColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: card.cardColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Stack(
          children: [
            // Top Title "COFFECITO"
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'COFFECITO',
                style: GoogleFonts.jost(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),

            // Vector Graphic Illustration in Center
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 24.h, left: 10.w),
                child: SvgPicture.asset(
                  card.svgPath,
                  height: 90.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Bottom Right Gold Coin & Amount Pill (e.g. 🪙 400MXN / 800MXN)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '🪙 ',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      card.amountText,
                      style: GoogleFonts.jost(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
