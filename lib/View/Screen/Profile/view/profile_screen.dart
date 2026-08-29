import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

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
              left: 20.w,
              right: 16.w,
              top: statusBarHeight + 12.h,
              bottom: 18.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title & Subtitle Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StaticString.profileTitle,
                      style: GoogleFonts.jost(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      StaticString.manageAccountAndPreferences,
                      style: GoogleFonts.jost(
                        fontSize: 12.sp,
                        color: const Color(0xFFE5F0FF),
                      ),
                    ),
                  ],
                ),

                // Right Action Icons (Notification & Cart)
                Row(
                  children: [
                    // Notification Icon with Red Badge
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.toNamed(AppRoute.notificationScreen),
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.all(6.r),
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                AppIcons.notificationIcon,
                                width: 22.w,
                                height: 22.h,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 10.r,
                                  height: 10.r,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFF3B30),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style: GoogleFonts.jost(
                                        fontSize: 7.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // Shopping Cart Icon
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.toNamed(AppRoute.myCartScreen),
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.all(6.r),
                          child: SvgPicture.asset(
                            AppIcons.shopIcon,
                            width: 22.w,
                            height: 22.h,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  // User Avatar Profile Picture
                  Obx(
                    () => Container(
                      width: 96.r,
                      height: 96.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE5EBF2),
                        border: Border.all(
                          color: const Color(0xFFE5E9F0),
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          controller.currentUser.value.avatarUrl,
                          width: 96.r,
                          height: 96.r,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.person_rounded,
                            size: 50,
                            color: Color(0xFF1E90FF),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // User Name, Email, Phone
                  Obx(
                    () => Text(
                      controller.currentUser.value.name,
                      style: GoogleFonts.jost(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Obx(
                    () => Text(
                      controller.currentUser.value.email,
                      style: GoogleFonts.jost(
                        fontSize: 13.sp,
                        color: const Color(0xFF777777),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Obx(
                    () => Text(
                      controller.currentUser.value.phone,
                      style: GoogleFonts.jost(
                        fontSize: 13.sp,
                        color: const Color(0xFF777777),
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Menu Items List Container
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          iconPath: AppIcons.editProfileIconSvg,
                          title: StaticString.editProfile,
                          onTap: () => Get.toNamed(AppRoute.editProfileScreen),
                        ),
                        _buildMenuItem(
                          iconPath: AppIcons.myWalletIconSvg,
                          title: StaticString.myWallet,
                          onTap: () => Get.toNamed(AppRoute.myWalletScreen),
                        ),
                        _buildMenuItem(
                          iconPath: AppIcons.favoriteIconSvg,
                          title: StaticString.favoriteMenu,
                          onTap: () => Get.toNamed(AppRoute.myFavoriteScreen),
                        ),
                        _buildMenuItem(
                          iconPath: AppIcons.orderHistoryIconSvg,
                          title: StaticString.orderHistory,
                          onTap: () => Get.toNamed(AppRoute.orderHistoryScreen),
                        ),
                        _buildMenuItem(
                          iconPath: AppIcons.supportIconSvg,
                          title: StaticString.support,
                          onTap: () {
                            Get.snackbar(
                              StaticString.support,
                              'Opening Support desk...',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: const Color(0xFF195ABE),
                              colorText: Colors.white,
                            );
                          },
                        ),
                        _buildMenuItem(
                          iconPath: AppIcons.termsIconSvg,
                          title: StaticString.termsAndConditions,
                          onTap: () =>
                              Get.toNamed(AppRoute.termsAndConditionsScreen),
                        ),
                        _buildMenuItem(
                          iconPath: AppIcons.privacyIconSvg,
                          title: StaticString.privacyPolicy,
                          onTap: () => Get.toNamed(AppRoute.privacyPolicyScreen),
                        ),
                        _buildMenuItem(
                          iconPath: AppIcons.logoutIconSvg,
                          title: StaticString.logOut,
                          textColor: const Color(0xFFFF3B30),
                          iconColor: const Color(0xFFFF3B30),
                          arrowColor: const Color(0xFFFF3B30),
                          onTap: () => controller.logout(),
                        ),
                        _buildMenuItem(
                          iconPath: AppIcons.deleteAccountIconSvg,
                          title: StaticString.deleteAccount,
                          textColor: const Color(0xFFFF3B30),
                          iconColor: const Color(0xFFFF3B30),
                          arrowColor: const Color(0xFF888888),
                          showDivider: false,
                          onTap: () => Get.toNamed(AppRoute.deleteAccountScreen),
                        ),
                      ],
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

  // ---------- MENU ITEM ROW BUILDER ----------
  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    Color textColor = const Color(0xFF222222),
    Color iconColor = const Color(0xFF333333),
    Color arrowColor = const Color(0xFF888888),
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 4.w),
              child: Row(
                children: [
                  // Left SVG Icon
                  SvgPicture.asset(
                    iconPath,
                    width: 22.w,
                    height: 22.h,
                    colorFilter: ColorFilter.mode(
                      iconColor,
                      BlendMode.srcIn,
                    ),
                  ),

                  SizedBox(width: 14.w),

                  // Menu Title Text
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.jost(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ),

                  // Right Arrow > Icon
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.r,
                    color: arrowColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            color: Color(0xFFF2F3F5),
            thickness: 1,
            height: 1,
          ),
      ],
    );
  }
}
