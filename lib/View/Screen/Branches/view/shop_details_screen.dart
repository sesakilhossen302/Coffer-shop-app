import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../Home/model/product_model.dart';
import '../controller/branches_controller.dart';
import '../model/branch_model.dart';

class ShopDetailsScreen extends StatelessWidget {
  const ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BranchesController controller = Get.isRegistered<BranchesController>()
        ? Get.find<BranchesController>()
        : Get.put(BranchesController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final BranchModel shop = (Get.arguments is BranchModel)
        ? Get.arguments as BranchModel
        : controller.shopsAtLocation.first;

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
                    StaticString.shopDetailsTitle,
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

                  // Top Shop Information Card
                  _buildShopInfoCard(shop, controller),

                  SizedBox(height: 20.h),

                  // 2-Tab Segmented Switcher (Working Hours / Products)
                  Container(
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
                            controller,
                            0,
                            StaticString.workingHours,
                          ),
                          _buildTabButton(
                            controller,
                            1,
                            StaticString.products,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Dynamic Tab Content Display
                  Obx(() {
                    if (controller.selectedShopTab.value == 0) {
                      return _buildWorkingHoursTab(shop, controller);
                    }
                    return _buildProductsTab(controller);
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

  // ---------- TOP SHOP INFO CARD WIDGET ----------
  Widget _buildShopInfoCard(BranchModel shop, BranchesController controller) {
    return Container(
      width: double.infinity,
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
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo Avatar Circle
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
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.store_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Title, Phone, Address
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
                      shop.phone,
                      style: GoogleFonts.jost(
                        fontSize: 12.sp,
                        color: const Color(0xFF777777),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            shop.address,
                            style: GoogleFonts.jost(
                              fontSize: 12.sp,
                              color: const Color(0xFF777777),
                            ),
                          ),
                        ),
                        Text(
                          '2.6km',
                          style: GoogleFonts.jost(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF222222),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Heart Favorite Icon
              GestureDetector(
                onTap: () => controller.toggleFavorite(shop),
                child: Padding(
                  padding: EdgeInsets.all(4.r),
                  child: SvgPicture.asset(
                    AppIcons.favoriteIconSvg,
                    width: 22.w,
                    height: 22.h,
                    colorFilter: shop.isFavorite
                        ? const ColorFilter.mode(
                            Color(0xFFE53935), BlendMode.srcIn)
                        : null,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // About Shop Title & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StaticString.aboutShop,
                style: GoogleFonts.jost(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF222222),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
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

          SizedBox(height: 6.h),

          // Description
          Text(
            'Prepared with 1x single chicken patty, 1x sliced cheddar cheese, secret sauce, sliced onion, tomato & lettuce',
            style: GoogleFonts.jost(
              fontSize: 11.5.sp,
              color: const Color(0xFF777777),
              height: 1.35,
            ),
          ),

          SizedBox(height: 12.h),

          // Social Icons Row (WhatsApp, Instagram, Facebook)
          Row(
            children: [
              SvgPicture.asset(AppIcons.whatsappSocialIconSvg,
                  width: 24.w, height: 24.h),
              SizedBox(width: 8.w),
              SvgPicture.asset(AppIcons.instagramSocialIconSvg,
                  width: 24.w, height: 24.h),
              SizedBox(width: 8.w),
              SvgPicture.asset(AppIcons.facebookSocialIconSvg,
                  width: 24.w, height: 24.h),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- TAB BUTTON ITEM ----------
  Widget _buildTabButton(
      BranchesController controller, int index, String title) {
    final bool isSelected = controller.selectedShopTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedShopTab.value = index,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E90FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.jost(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : const Color(0xFF777777),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- TAB 1: WORKING HOURS CONTENT ----------
  Widget _buildWorkingHoursTab(BranchModel shop, BranchesController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title: Restaurant Working Hours
        Text(
          StaticString.restaurantWorkingHours,
          style: GoogleFonts.jost(
            fontSize: 14.5.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF222222),
          ),
        ),
        SizedBox(height: 12.h),

        // Working Hours Breakdown Rows
        _buildHoursRow(StaticString.monThuHours, StaticString.monThuTime),
        SizedBox(height: 8.h),
        _buildHoursRow(StaticString.friHours, StaticString.friTime),
        SizedBox(height: 8.h),
        _buildHoursRow(StaticString.satSunHours, StaticString.satSunTime),

        SizedBox(height: 20.h),
        const Divider(color: Color(0xFFE5E9F0), thickness: 1),
        SizedBox(height: 16.h),

        // FAQs Section
        Text(
          StaticString.faqsTitle,
          style: GoogleFonts.jost(
            fontSize: 13.5.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF222222),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          StaticString.canIPayInCash,
          style: GoogleFonts.jost(
            fontSize: 12.sp,
            color: const Color(0xFF777777),
          ),
        ),
        Text(
          StaticString.doRewardsExpire,
          style: GoogleFonts.jost(
            fontSize: 12.sp,
            color: const Color(0xFF777777),
          ),
        ),

        SizedBox(height: 28.h),

        // "How to get there" Outlined Button -> Navigates to MapOptionsScreen
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Get.toNamed(AppRoute.mapOptionsScreen),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: double.infinity,
              height: 48.h,
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
                  StaticString.howToGetThere,
                  style: GoogleFonts.jost(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF195ABE),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHoursRow(String label, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.jost(
            fontSize: 12.5.sp,
            color: const Color(0xFF777777),
          ),
        ),
        Text(
          time,
          style: GoogleFonts.jost(
            fontSize: 12.5.sp,
            color: const Color(0xFF222222),
          ),
        ),
      ],
    );
  }

  // ---------- TAB 2: PRODUCTS CONTENT ----------
  Widget _buildProductsTab(BranchesController controller) {
    final List<String> categories = ['Hot drinks', 'Cold drinks', 'Bakery', 'Snacks'];
    final List<String> categoryIcons = [
      AppIcons.hotDrinksIcon,
      AppIcons.coldDrinksIcon,
      AppIcons.bakeryIcon,
      AppIcons.snacksIcon,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title: Last Order
        Text(
          StaticString.lastOrder,
          style: GoogleFonts.jost(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF222222),
          ),
        ),
        SizedBox(height: 10.h),

        // Last Order Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F8),
            borderRadius: BorderRadius.circular(14.r),
          ),
          padding: EdgeInsets.all(12.r),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=150&q=80',
                  width: 60.r,
                  height: 60.r,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Iced Americano',
                      style: GoogleFonts.jost(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF195ABE),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Intense espresso served over ice.',
                      style: GoogleFonts.jost(
                        fontSize: 11.5.sp,
                        color: const Color(0xFF888888),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$30.00',
                      style: GoogleFonts.jost(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF195ABE),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CD964),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  StaticString.orderCompleted,
                  style: GoogleFonts.jost(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        // Title: Available Items
        Text(
          StaticString.availableItems,
          style: GoogleFonts.jost(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF222222),
          ),
        ),
        SizedBox(height: 12.h),

        // Category Selector Chips
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(categories.length, (index) {
              final bool isSelected =
                  controller.selectedCategoryIndex.value == index;
              return GestureDetector(
                onTap: () => controller.selectedCategoryIndex.value = index,
                child: Column(
                  children: [
                    Container(
                      width: 64.r,
                      height: 64.r,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1E90FF)
                            : const Color(0xFFF5F6F8),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          categoryIcons[index],
                          width: 28.w,
                          height: 28.h,
                          colorFilter: ColorFilter.mode(
                            isSelected
                                ? Colors.white
                                : const Color(0xFF777777),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      categories[index],
                      style: GoogleFonts.jost(
                        fontSize: 11.5.sp,
                        color: isSelected
                            ? const Color(0xFF1E90FF)
                            : const Color(0xFF777777),
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),

        SizedBox(height: 16.h),

        // Search Product Field
        Container(
          height: 44.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F8),
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                color: const Color(0xFF999999),
                size: 20.r,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextField(
                  controller: controller.productSearchController,
                  onChanged: (val) =>
                      controller.productSearchQuery.value = val,
                  style: GoogleFonts.jost(
                    fontSize: 13.sp,
                    color: const Color(0xFF222222),
                  ),
                  decoration: InputDecoration(
                    hintText: StaticString.searchCoffeeHint,
                    hintStyle: GoogleFonts.jost(
                      fontSize: 12.5.sp,
                      color: const Color(0xFF999999),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // 2-Column Product Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.shopProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final item = controller.shopProducts[index];
            return _buildProductGridCard(item);
          },
        ),
      ],
    );
  }

  Widget _buildProductGridCard(ProductModel item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                item.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            item.title,
            style: GoogleFonts.jost(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF195ABE),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.jost(
              fontSize: 10.5.sp,
              color: const Color(0xFF888888),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: GoogleFonts.jost(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF195ABE),
                ),
              ),
              Container(
                width: 26.r,
                height: 26.r,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E90FF),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
