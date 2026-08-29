import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/AppImg/app_img.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../Branches/model/branch_model.dart';
import '../../Home/model/product_model.dart';
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
      backgroundColor: const Color(0xFFF9FAFC),
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

          SizedBox(height: 16.h),

          // Main Body Content (Empty State or Populated List)
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
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: controller.favoriteShops.length,
                  itemBuilder: (context, index) {
                    return _buildShopFavoriteCard(
                      controller.favoriteShops[index],
                      controller,
                    );
                  },
                );
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
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: controller.favoriteItems.length,
                  itemBuilder: (context, index) {
                    return _buildItemFavoriteCard(
                      controller.favoriteItems[index],
                      controller,
                    );
                  },
                );
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

  // ---------- SHOP FAVORITE CARD WIDGET ----------
  Widget _buildShopFavoriteCard(
      BranchModel shop, FavoriteController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoute.shopDetailsScreen, arguments: shop),
        borderRadius: BorderRadius.circular(18.r),
        child: Padding(
          padding: EdgeInsets.all(14.r),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo Avatar
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00704A),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ClipOval(
                        child: Image.network(
                          shop.logoUrl,
                          width: 48.r,
                          height: 48.r,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.store_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Name, Address, Status Badge
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.name,
                          style: GoogleFonts.jost(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF222222),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          shop.address,
                          style: GoogleFonts.jost(
                            fontSize: 12.sp,
                            color: const Color(0xFF888888),
                          ),
                        ),
                        SizedBox(height: 6.h),

                        // Open / Closed Status Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: shop.isOpen
                                ? const Color(0xFFE8F7ED)
                                : const Color(0xFFFDE8E8),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                shop.isOpen
                                    ? StaticString.openText
                                    : StaticString.closedText,
                                style: GoogleFonts.jost(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: shop.isOpen
                                      ? const Color(0xFF34C759)
                                      : const Color(0xFFE53935),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Container(
                                width: 5.r,
                                height: 5.r,
                                decoration: BoxDecoration(
                                  color: shop.isOpen
                                      ? const Color(0xFF34C759)
                                      : const Color(0xFFE53935),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Red Heart Icon
                  GestureDetector(
                    onTap: () => controller.toggleFavoriteShop(shop),
                    child: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: SvgPicture.asset(
                        AppIcons.favoriteIconSvg,
                        width: 22.w,
                        height: 22.h,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFE53935),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              // Order Now Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () =>
                      Get.toNamed(AppRoute.shopDetailsScreen, arguments: shop),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: double.infinity,
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF195ABE),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppIcons.shopIcon,
                          width: 18.w,
                          height: 18.h,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          StaticString.orderNowBtn,
                          style: GoogleFonts.jost(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

  // ---------- ITEM FAVORITE CARD WIDGET ----------
  Widget _buildItemFavoriteCard(
      ProductModel item, FavoriteController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Thumbnail Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              item.imageUrl,
              width: 76.r,
              height: 76.r,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 76.r,
                height: 76.r,
                color: const Color(0xFFF5F6F8),
                child: const Icon(
                  Icons.fastfood_rounded,
                  color: Color(0xFF195ABE),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Title, Description, Price Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.jost(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF222222),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.jost(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF888888),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '\$${item.price.toStringAsFixed(0)}',
                  style: GoogleFonts.jost(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Right Heart & Order Now Button Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Red Heart Icon
              GestureDetector(
                onTap: () => controller.removeFavoriteItem(item),
                child: Padding(
                  padding: EdgeInsets.all(2.r),
                  child: SvgPicture.asset(
                    AppIcons.favoriteIconSvg,
                    width: 20.w,
                    height: 20.h,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFE53935),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Order Now Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.toNamed(
                    AppRoute.orderSummaryScreen,
                    arguments: {
                      'title': item.title,
                      'customization': item.description,
                      'price': item.price,
                      'imageUrl': item.imageUrl,
                    },
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    width: 104.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF195ABE),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppIcons.shopIcon,
                          width: 14.w,
                          height: 14.h,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          StaticString.orderNowBtn,
                          style: GoogleFonts.jost(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.jost(
                  fontSize: 13.sp,
                  color: const Color(0xFF777777),
                ),
              ),
              SizedBox(height: 24.h),
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
