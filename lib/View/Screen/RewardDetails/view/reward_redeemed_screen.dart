import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../Rewards/controller/rewards_controller.dart';
import '../../Rewards/model/reward_model.dart';
import '../controller/reward_details_controller.dart';

class RewardRedeemedScreen extends StatelessWidget {
  const RewardRedeemedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardDetailsController controller = Get.isRegistered<RewardDetailsController>()
        ? Get.find<RewardDetailsController>()
        : Get.put(RewardDetailsController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final reward = controller.reward.value;

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
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Get.back();
                      } else {
                        Get.offAllNamed(AppRoute.homeScreen);
                      }
                    },
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
                    StaticString.rewardRedeemed,
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
                children: [
                  SizedBox(height: 24.h),

                  // Success Badge Graphic (Blue Circle with Cup + Green Checkmark Overlay)
                  Center(
                    child: SizedBox(
                      width: 90.r,
                      height: 90.r,
                      child: Stack(
                        children: [
                          Container(
                            width: 90.r,
                            height: 90.r,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1E90FF),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppIcons.rewardIcon14Svg,
                                width: 44.w,
                                height: 44.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 26.r,
                              height: 26.r,
                              decoration: BoxDecoration(
                                color: const Color(0xFF34C759),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // "Reward Redeemed!" Title
                  Text(
                    StaticString.rewardRedeemedExclamation,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222222),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // Subtitle Message
                  Text(
                    StaticString.showCashierMsg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 12.5.sp,
                      color: const Color(0xFF888888),
                      height: 1.35,
                    ),
                  ),

                  SizedBox(height: 24.h),

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
                        _buildRewardHeroBanner(reward),
                        SizedBox(height: 12.h),

                        // Points Badge
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
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // "Valid until" Information
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StaticString.validUntil,
                          style: GoogleFonts.jost(
                            fontSize: 11.5.sp,
                            color: const Color(0xFF888888),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          StaticString.validUntilDate,
                          style: GoogleFonts.jost(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF222222),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),
                  const Divider(color: Color(0xFFF0F0F0), thickness: 1),
                  SizedBox(height: 24.h),

                  // "Done" Action Button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (Get.isRegistered<RewardsController>()) {
                          Get.find<RewardsController>().userPoints.value =
                              (Get.find<RewardsController>().userPoints.value -
                                      reward.requiredPoints)
                                  .clamp(0, 9999);
                        }
                        Get.offAllNamed(AppRoute.homeScreen);
                      },
                      borderRadius: BorderRadius.circular(14.r),
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF195ABE),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Center(
                          child: Text(
                            StaticString.done,
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

                  SizedBox(height: 32.h),
                ],
              ),
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
}
