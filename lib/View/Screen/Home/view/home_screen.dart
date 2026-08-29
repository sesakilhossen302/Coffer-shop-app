import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppColors/app_colors.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/AppImg/app_img.dart';
import '../../../../helper/network_img/custom_netwrok_image.dart';
import '../../../Widgegt/navBar/nav_bar.dart';
import '../../Branches/view/branches_screen.dart';
import '../../Order/view/order_screen.dart';
import '../../Profile/view/profile_screen.dart';
import '../../Rewards/view/rewards_screen.dart';
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
      body: Column(
        children: [
          // Expanded Content depending on Bottom Nav Index
          Expanded(
            child: Obx(() {
              if (controller.selectedNavIndex.value == 1) {
                return const OrderScreen();
              }
              if (controller.selectedNavIndex.value == 2) {
                return const RewardsScreen();
              }
              if (controller.selectedNavIndex.value == 3) {
                return const BranchesScreen();
              }
              if (controller.selectedNavIndex.value == 4) {
                return const ProfileScreen();
              }
              return _buildHomeContent(controller);
            }),
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
    );
  }

  // ---------- HOME TAB CONTENT ----------
  Widget _buildHomeContent(HomeController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Blue Header Section
          _buildTopHeader(controller),

          SizedBox(height: 24.h),

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
    );
  }

  // ---------- TOP BLUE HEADER SECTION ----------
  Widget _buildTopHeader(HomeController controller) {
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
        bottom: 24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting & Header Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, User!',
                      style: GoogleFonts.jost(
                        fontSize: 22.sp,
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
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Row(
                children: [
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
                  SizedBox(width: 10.w),

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
                ],
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Search Bar Input Container
          Container(
            height: 52.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F7),
              borderRadius: BorderRadius.circular(16.r),
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
                      fontSize: 15.sp,
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
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF195ABE),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          'Earn points with every purchase',
          style: GoogleFonts.jost(
            fontSize: 13.sp,
            color: const Color(0xFF7D7D7D),
          ),
        ),
        SizedBox(height: 14.h),
        Container(
          width: double.infinity,
          height: 76.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F5F7),
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            children: [
              // Gold Coin Image with Yellow Progress Arc Ring
              SizedBox(
                width: 54.w,
                height: 54.h,
                child: CustomPaint(
                  painter: _CoinProgressArcPainter(),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(6.r),
                      child: Image.asset(
                        AppImg.coinImg,
                        width: 38.w,
                        height: 38.h,
                        fit: BoxFit.contain,
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
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Obx(
                () => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${controller.userPoints.value} ',
                        style: GoogleFonts.jost(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF195ABE),
                        ),
                      ),
                      TextSpan(
                        text: 'points',
                        style: GoogleFonts.jost(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF195ABE),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Color(0xFF195ABE),
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
          height: 130.h,
          child: Obx(
            () => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.offerList.length,
              separatorBuilder: (context, index) => SizedBox(width: 14.w),
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
      width: 290.w,
      decoration: BoxDecoration(
        color: offer.backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(18.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title,
                    style: GoogleFonts.jost(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF195ABE),
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 6.h),
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
            width: 115.w,
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
            fontSize: 20.sp,
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
              childAspectRatio: 0.70,
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
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoute.itemDetailsScreen, arguments: product),
      child: Container(
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
      ),
    );
  }
}

// ---------- CUSTOM PAINTER FOR GOLD COIN PROGRESS ARC RING ----------
class _CoinProgressArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 4.5.w;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - strokeWidth) / 2;

    // Background track ring (#E2E8F0)
    final bgPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // Golden yellow progress arc ring (#FFB800)
    final arcPaint = Paint()
      ..color = const Color(0xFFFFB800)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 4,
      1.1 * pi,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
