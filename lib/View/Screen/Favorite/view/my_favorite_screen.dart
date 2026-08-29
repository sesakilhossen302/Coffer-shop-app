import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/AppImg/app_img.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/favorite_controller.dart';

class MyFavoriteScreen extends StatelessWidget {
  const MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.isRegistered<FavoriteController>()
        ? Get.find<FavoriteController>()
        : Get.put(FavoriteController());

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
                    StaticString.myFavoriteTitle,
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

          SizedBox(height: 20.h),

          // 2-Tab Segmented Switcher (Shop / Item)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFE5E9F0),
                  width: 1,
                ),
              ),
              padding: EdgeInsets.all(3.r),
              child: Obx(
                () => Row(
                  children: [
                    _buildTabButton(
                      controller: controller,
                      index: 0,
                      title: StaticString.shopTab,
                      iconWidget: Icon(
                        Icons.storefront_rounded,
                        size: 18.r,
                        color: controller.selectedTab.value == 0
                            ? Colors.white
                            : const Color(0xFF777777),
                      ),
                    ),
                    _buildTabButton(
                      controller: controller,
                      index: 1,
                      title: StaticString.itemTab,
                      iconWidget: SvgPicture.asset(
                        AppIcons.shopIcon,
                        width: 16.w,
                        height: 16.h,
                        colorFilter: ColorFilter.mode(
                          controller.selectedTab.value == 1
                              ? Colors.white
                              : const Color(0xFF777777),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main Body Content (Empty State or List)
          Expanded(
            child: Obx(() {
              if (controller.selectedTab.value == 0) {
                // Shop Tab
                if (controller.favoriteShops.isEmpty) {
                  return _buildEmptyState(
                    title: StaticString.noFavoriteShopYet,
                    subtitle: StaticString.addFavoriteShopsDesc,
                    buttonText: StaticString.exploreShops,
                    onTapBtn: () =>
                        Get.toNamed(AppRoute.branchSearchLocationScreen),
                  );
                }
                return const SizedBox();
              } else {
                // Item Tab
                if (controller.favoriteItems.isEmpty) {
                  return _buildEmptyState(
                    title: StaticString.noFavoriteItemYet,
                    subtitle: StaticString.addFavoriteItemDesc,
                    buttonText: StaticString.exploreOrder,
                    onTapBtn: () => Get.offAllNamed(AppRoute.homeScreen),
                  );
                }
                return const SizedBox();
              }
            }),
          ),
        ],
      ),
    );
  }

  // ---------- TAB BUTTON WIDGET ----------
  Widget _buildTabButton({
    required FavoriteController controller,
    required int index,
    required String title,
    required Widget iconWidget,
  }) {
    final bool isSelected = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedTab.value = index,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E90FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconWidget,
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 13.5.sp,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : const Color(0xFF777777),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- EMPTY STATE WIDGET ----------
  Widget _buildEmptyState({
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onTapBtn,
  }) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // User-Provided Image Asset: No favorite shop yet img .png
              Image.asset(
                AppImg.noFavoriteShopImg,
                height: 160.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.inbox_rounded,
                  size: 100.r,
                  color: const Color(0xFFBCE3F7),
                ),
              ),

              SizedBox(height: 24.h),

              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.jost(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF222222),
                ),
              ),

              SizedBox(height: 6.h),

              // Subtitle
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.jost(
                  fontSize: 13.sp,
                  color: const Color(0xFF777777),
                ),
              ),

              SizedBox(height: 24.h),

              // Outlined Action Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTapBtn,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: 160.w,
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFF195ABE),
                        width: 1.2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        buttonText,
                        style: GoogleFonts.jost(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF195ABE),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
