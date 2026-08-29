import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../../Widgegt/navBar/nav_bar.dart';
import '../controller/branches_controller.dart';
import '../model/branch_model.dart';

class BranchSearchLocationScreen extends StatelessWidget {
  const BranchSearchLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BranchesController controller = Get.isRegistered<BranchesController>()
        ? Get.find<BranchesController>()
        : Get.put(BranchesController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      body: Column(
        children: [
          // Expanded Content (Map Header + Shops List)
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Map Container Header with Floating Search Input Bar
                  SizedBox(
                    height: 290.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        // Map Graphic Background
                        Container(
                          width: double.infinity,
                          height: 290.h,
                          color: const Color(0xFFE5EBF2),
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: Size(double.infinity, 290.h),
                                painter: _ExpandedMapPainter(),
                              ),

                              // Red Destination Pin Marker e.g. 291 Clermont Avenue
                              Positioned(
                                top: 120.h,
                                left: 160.w,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 3.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.15),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        '291 Clermont Avenue',
                                        style: GoogleFonts.jost(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFE53935),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: const Color(0xFFE53935),
                                      size: 28.r,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Floating Search Bar Container
                        Positioned(
                          top: statusBarHeight + 12.h,
                          left: 16.w,
                          right: 16.w,
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  color: const Color(0xFF195ABE),
                                  size: 22.r,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: TextField(
                                    controller: controller.searchController,
                                    onChanged: (val) =>
                                        controller.searchQuery.value = val,
                                    style: GoogleFonts.jost(
                                      fontSize: 13.5.sp,
                                      color: const Color(0xFF222222),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => Get.back(),
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.r),
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: const Color(0xFF195ABE),
                                        size: 20.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Section Title: "All shops at this location"
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      StaticString.allShopsAtLocation,
                      style: GoogleFonts.jost(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF195ABE),
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Shops List Items
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.shopsAtLocation.length,
                        itemBuilder: (context, index) {
                          return _buildShopCard(
                              controller.shopsAtLocation[index], controller);
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),

          // Custom Bottom Navigation Bar
          CustomNavBar(
            currentIndex: 3,
            onTap: (index) {
              if (index == 0) Get.offAllNamed(AppRoute.homeScreen);
            },
          ),
        ],
      ),
    );
  }

  // ---------- SHOP CARD ITEM WIDGET ----------
  Widget _buildShopCard(BranchModel shop, BranchesController controller) {
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
                  // Circular Shop Logo Avatar
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00704A), // Starbucks / Coffecito Green
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

                  // Shop Details (Name, Address, Open/Closed Badge)
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

                  // User-Provided Favorite Heart SVG Icon (assets/icons/Favorite.svg)
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

              // Primary "Order Now" Button with Cart Icon
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.offAllNamed(AppRoute.homeScreen),
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
}

// ---------- EXPANDED MAP GRAPHIC PAINTER ----------
class _ExpandedMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    final waterPaint = Paint()
      ..color = const Color(0xFFBCE3F7)
      ..style = PaintingStyle.fill;

    // Water river shape on top left
    final waterPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.45, 0)
      ..cubicTo(size.width * 0.4, size.height * 0.3, size.width * 0.2,
          size.height * 0.5, 0, size.height * 0.6)
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    // Roads
    canvas.drawLine(Offset(size.width * 0.2, 0),
        Offset(size.width * 0.8, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.4),
        Offset(size.width, size.height * 0.4), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.75),
        Offset(size.width, size.height * 0.75), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
