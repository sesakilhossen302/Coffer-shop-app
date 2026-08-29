import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/AppColors/app_colors.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/AppImg/app_img.dart';
import '../../../../helper/network_img/custom_netwrok_image.dart';
import '../../../Widgegt/navBar/nav_bar.dart';
import '../controller/home_controller.dart';
import '../model/offer_model.dart';
import '../model/product_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Expanded Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Blue Header Section
                    _buildTopHeader(controller),

                    SizedBox(height: 20.h),

                    // Main Body Content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // "Sip more,Win more!" Loyalty Points Section
                          _buildPointsSection(controller),

                          SizedBox(height: 24.h),

                          // "Offers" Banner Section
                          _buildOffersSection(controller),

                          SizedBox(height: 24.h),

                          // "Order again" Products Section
                          _buildOrderAgainSection(controller),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Custom Bottom Navigation Bar
            Obx(
              () => CustomNavBar(
                currentIndex: controller.selectedNavIndex.value,
                onTap: controller.changeNavIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- TOP BLUE HEADER SECTION ----------
  Widget _buildTopHeader(HomeController controller) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1E90FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: MediaQuery.of(Get.context!).padding.top + 12.h,
        bottom: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting & Header Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, User!',
                    style: GoogleFonts.jost(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "What's going to be today's mood booster?",
                    style: GoogleFonts.jost(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Cart Icon
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      AppIcons.shopIcon,
                      width: 24.w,
                      height: 24.h,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  SizedBox(width: 16.w),

                  // Notification Icon with Badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          AppIcons.notificationIcon,
                          width: 24.w,
                          height: 24.h,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                      Positioned(
                        right: -4.w,
                        top: -4.h,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF3B30),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '1',
                            style: GoogleFonts.jost(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Search Bar Input Field
          Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F7),
              borderRadius: BorderRadius.circular(14.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Color(0xFFA0A0A0),
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
                    ),
                    decoration: InputDecoration(
                      hintText: 'Look for coffee',
                      hintStyle: GoogleFonts.jost(
                        fontSize: 14.sp,
                        color: const Color(0xFFA0A0A0),
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
        ],
      ),
    );
  }

  // ---------- LOYALTY POINTS SECTION ----------
  Widget _buildPointsSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sip more,Win more!',
          style: GoogleFonts.jost(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E90FF),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          'Earn points with every purchase',
          style: GoogleFonts.jost(
            fontSize: 12.sp,
            color: const Color(0xFF777777),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          height: 64.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              // Gold Coin Asset Image
              Image.asset(
                AppImg.coinImg,
                width: 38.w,
                height: 38.h,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 38.w,
                  height: 38.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC107),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.monetization_on, color: Colors.white),
                ),
              ),
              SizedBox(width: 12.w),
              Obx(
                () => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${controller.userPoints.value} ',
                        style: GoogleFonts.jost(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E90FF),
                        ),
                      ),
                      TextSpan(
                        text: 'points',
                        style: GoogleFonts.jost(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1E90FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Color(0xFF1E90FF),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- OFFERS BANNER CAROUSEL SECTION ----------
  Widget _buildOffersSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Offers',
          style: GoogleFonts.jost(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E90FF),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 125.h,
          child: Obx(
            () => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.offerList.length,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final offer = controller.offerList[index];
                return _buildOfferBannerCard(offer);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOfferBannerCard(OfferModel offer) {
    return Container(
      width: 280.w,
      decoration: BoxDecoration(
        color: offer.backgroundColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title,
                    style: GoogleFonts.jost(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF195ABE),
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '*Aplican términos y condiciones',
                    style: GoogleFonts.jost(
                      fontSize: 9.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomNetworkImage(
            imageUrl: offer.imageUrl,
            width: 110.w,
            height: double.infinity,
            borderRadius: 0,
          ),
        ],
      ),
    );
  }

  // ---------- ORDER AGAIN PRODUCTS GRID SECTION ----------
  Widget _buildOrderAgainSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order again',
          style: GoogleFonts.jost(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF195ABE),
          ),
        ),
        SizedBox(height: 14.h),
        Obx(
          () => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 14.h,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return _buildProductCard(product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.r),
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
                borderRadius: 12.r,
              ),
            ),
          ),
          SizedBox(height: 8.h),

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

          // Description
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.jost(
              fontSize: 10.sp,
              color: const Color(0xFF888888),
              height: 1.2,
            ),
          ),

          SizedBox(height: 8.h),

          // Price & Add Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: GoogleFonts.jost(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF195ABE),
                ),
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF195ABE),
                    borderRadius: BorderRadius.circular(8.r),
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
