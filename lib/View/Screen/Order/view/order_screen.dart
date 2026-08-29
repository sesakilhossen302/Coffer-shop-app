import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppColors/app_colors.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../../../helper/network_img/custom_netwrok_image.dart';
import '../../Home/model/product_model.dart';
import '../controller/order_controller.dart';
import '../model/category_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.isRegistered<OrderController>()
        ? Get.find<OrderController>()
        : Get.put(OrderController());

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Blue Header with Categories Selection Bar
          _buildTopHeaderWithCategories(controller),

          SizedBox(height: 20.h),

          // Category Products Grid Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.currentProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  final product = controller.currentProducts[index];
                  return _buildProductCard(product);
                },
              ),
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ---------- TOP BLUE HEADER & CATEGORIES BAR ----------
  Widget _buildTopHeaderWithCategories(OrderController controller) {
    final double statusBarHeight = MediaQuery.of(Get.context!).padding.top;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1E90FF),
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: statusBarHeight + 14.h,
        bottom: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Text & Header Action Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StaticString.whatAreYouCraving,
                    style: GoogleFonts.jost(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    StaticString.findYourNextFavorite,
                    style: GoogleFonts.jost(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Notification Icon Button with Red Badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.notificationScreen),
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          child: SvgPicture.asset(
                            AppIcons.notificationIcon,
                            width: 26.w,
                            height: 26.h,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 16.w,
                          height: 16.h,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF3B30),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '1',
                              style: GoogleFonts.jost(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),

                  // Cart Icon Button
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.myCartScreen),
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      child: SvgPicture.asset(
                        AppIcons.shopIcon,
                        width: 26.w,
                        height: 26.h,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Search Bar Input Container
          Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F7),
              borderRadius: BorderRadius.circular(14.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Color(0xFFA6B0C0),
                  size: 22,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: controller.onSearchChanged,
                    style: GoogleFonts.jost(
                      fontSize: 14.sp,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Look for coffee',
                      hintStyle: GoogleFonts.jost(
                        fontSize: 14.sp,
                        color: const Color(0xFFA6B0C0),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Obx(
                  () => controller.searchQuery.value.isNotEmpty
                      ? GestureDetector(
                          onTap: controller.clearSearch,
                          child: const Icon(
                            Icons.close_rounded,
                            color: Color(0xFF888888),
                            size: 20,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Categories Bar Header Title
          Text(
            StaticString.categories,
            style: GoogleFonts.jost(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 12.h),

          // Horizontal Category Option Cards
          Obx(
            () => Row(
              children: List.generate(
                controller.categories.length,
                (index) {
                  final category = controller.categories[index];
                  final bool isSelected = controller.selectedCategoryIndex.value == index;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: _buildCategoryCard(
                        category: category,
                        isSelected: isSelected,
                        onTap: () => controller.selectCategory(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- CATEGORY CARD WIDGET ----------
  Widget _buildCategoryCard({
    required CategoryModel category,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 64.h,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : const Color(0xFF1575D9),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Icon(
                category.icon,
                size: 28.sp,
                color: isSelected ? const Color(0xFF1E90FF) : Colors.white,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            category.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.jost(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- PRODUCT CARD WIDGET ----------
  Widget _buildProductCard(ProductModel product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            child: Center(
              child: CustomNetworkImage(
                imageUrl: product.imageUrl,
                width: double.infinity,
                height: double.infinity,
                borderRadius: 14.r,
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // Title
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.jost(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E90FF),
            ),
          ),

          SizedBox(height: 2.h),

          // Description
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.jost(
              fontSize: 11.sp,
              color: const Color(0xFF888888),
              height: 1.2,
            ),
          ),

          SizedBox(height: 10.h),

          // Price & Add Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: GoogleFonts.jost(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF195ABE),
                ),
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF195ABE),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
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
