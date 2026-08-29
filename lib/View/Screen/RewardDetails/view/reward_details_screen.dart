import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../Rewards/model/reward_model.dart';
import '../controller/reward_details_controller.dart';

class RewardDetailsScreen extends StatelessWidget {
  const RewardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardDetailsController controller = Get.isRegistered<RewardDetailsController>()
        ? Get.find<RewardDetailsController>()
        : Get.put(RewardDetailsController());

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
                    StaticString.rewardDetails,
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
              child: Obx(() {
                final reward = controller.reward.value;
                final bool hasEnough = controller.hasEnoughPoints;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    // Hero Card Container (#F5F6F8 background)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F8),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      child: Column(
                        children: [
                          // Reward Image Card
                          _buildRewardHeroBanner(reward),

                          SizedBox(height: 12.h),

                          // Points Badge (Home-Page-Coin-img.png + Points)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppIcons.homePageCoinImg,
                                width: 22.w,
                                height: 22.h,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '${reward.requiredPoints} pts',
                                style: GoogleFonts.jost(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF195ABE),
                                ),
                              ),
                            ],
                          ),

                          // Optional Green "Redeemed" Badge (Matching Screen 2 Right Image)
                          if (reward.isRedeemed) ...[
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF34C759),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                StaticString.redeemedBadge,
                                style: GoogleFonts.jost(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // About this reward Section
                    Text(
                      StaticString.aboutThisReward,
                      style: GoogleFonts.jost(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      StaticString.aboutRewardDesc,
                      style: GoogleFonts.jost(
                        fontSize: 12.sp,
                        color: const Color(0xFF777777),
                        height: 1.35,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Progress Section (50/750 or 50/50 Green)
                    Text(
                      reward.isRedeemed
                          ? '${reward.requiredPoints}/${reward.requiredPoints}'
                          : '${controller.userPoints.value}/${reward.requiredPoints}',
                      style: GoogleFonts.jost(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w900,
                        color: (reward.isRedeemed || hasEnough)
                            ? const Color(0xFF34C759)
                            : const Color(0xFF195ABE),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: LinearProgressIndicator(
                        value: reward.isRedeemed ? 1.0 : controller.progressRatio,
                        minHeight: 10.h,
                        backgroundColor: const Color(0xFFE5E5E5),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          (reward.isRedeemed || hasEnough)
                              ? const Color(0xFF34C759)
                              : const Color(0xFFFFB800),
                        ),
                      ),
                    ),

                    if (!hasEnough && !reward.isRedeemed) ...[
                      SizedBox(height: 6.h),
                      Text(
                        'You need ${controller.pointsNeeded} more points for a free coffee',
                        style: GoogleFonts.jost(
                          fontSize: 11.5.sp,
                          color: const Color(0xFF195ABE),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],

                    if (!reward.isRedeemed) ...[
                      SizedBox(height: 24.h),

                      // Info Details Container
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F8FC),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          children: [
                            if (!hasEnough) ...[
                              // Item 1: Points required (Only shown when points needed)
                              _buildInfoRow(
                                icon: Icons.monetization_on_outlined,
                                title: StaticString.pointsRequired,
                                subtitle: null,
                                trailingText: '${reward.requiredPoints} pts',
                              ),
                              SizedBox(height: 16.h),
                            ],

                            // Item 2: How to redeem
                            _buildInfoRow(
                              icon: Icons.info_outline_rounded,
                              title: StaticString.howToRedeem,
                              subtitle: StaticString.howToRedeemDesc,
                              trailingText: null,
                            ),
                            SizedBox(height: 16.h),

                            // Item 3: Valid for
                            _buildInfoRow(
                              icon: Icons.calendar_today_outlined,
                              title: StaticString.validFor,
                              subtitle: StaticString.validForDesc,
                              trailingText: null,
                            ),
                            SizedBox(height: 16.h),

                            // Item 4: Available at
                            _buildInfoRow(
                              icon: Icons.location_on_outlined,
                              title: StaticString.availableAt,
                              subtitle: StaticString.availableAtDesc,
                              trailingText: null,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // Primary Action Button: "Redeem Now"
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: hasEnough ? controller.redeem : null,
                          borderRadius: BorderRadius.circular(14.r),
                          child: Container(
                            width: double.infinity,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: hasEnough
                                  ? const Color(0xFF195ABE)
                                  : const Color(0xFFA6C2F2), // Muted disabled blue
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Center(
                              child: Text(
                                StaticString.redeemNow,
                                style: GoogleFonts.jost(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 36.h),

                    // Secondary Action Button: "Go Back"
                    Center(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          StaticString.goBack,
                          style: GoogleFonts.jost(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF777777),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 28.h),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- REWARD HERO BANNER WIDGET ----------
  Widget _buildRewardHeroBanner(RewardModel reward) {
    if (reward.hasRedeemBadge) {
      return Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: const Color(0xFF1E90FF).withValues(alpha: 0.9),
          image: DecorationImage(
            image: NetworkImage(reward.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color(0xFF1E90FF).withValues(alpha: 0.38),
              BlendMode.srcATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.coffecitoLogoSvg,
                height: 32.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 12.h),
              SvgPicture.asset(
                AppIcons.rewardIcon14Svg,
                height: 80.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        image: DecorationImage(
          image: NetworkImage(reward.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            reward.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.jost(
              fontSize: 32.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF195ABE),
              height: 1.05,
            ),
          ),
        ),
      ),
    );
  }

  // ---------- INFO ITEM ROW WIDGET ----------
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String? subtitle,
    required String? trailingText,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF1E90FF),
          size: 20.r,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 12.5.sp,
                  color: const Color(0xFF888888),
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.jost(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF222222),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailingText != null)
          Text(
            trailingText,
            style: GoogleFonts.jost(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF195ABE),
            ),
          ),
      ],
    );
  }
}
