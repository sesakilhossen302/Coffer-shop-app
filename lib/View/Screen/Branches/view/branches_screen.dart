import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/branches_controller.dart';
import '../model/branch_model.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BranchesController controller = Get.isRegistered<BranchesController>()
        ? Get.find<BranchesController>()
        : Get.put(BranchesController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
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
              right: 20.w,
              top: statusBarHeight + 10.h,
              bottom: 20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Title, Subtitle & Action Icons (Notification & Cart)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StaticString.branchesTitle,
                          style: GoogleFonts.jost(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          StaticString.findNearestCoffecito,
                          style: GoogleFonts.jost(
                            fontSize: 12.sp,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Notification Bell Icon with Red Dot
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

                SizedBox(height: 16.h),

                // Search Location Field
                Container(
                  height: 46.h,
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
                          controller: controller.searchController,
                          onChanged: (val) => controller.searchQuery.value = val,
                          style: GoogleFonts.jost(
                            fontSize: 13.5.sp,
                            color: const Color(0xFF222222),
                          ),
                          decoration: InputDecoration(
                            hintText: StaticString.searchLocationPlaceholder,
                            hintStyle: GoogleFonts.jost(
                              fontSize: 13.sp,
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
              ],
            ),
          ),

          // Main Scrollable List of Branch Cards
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  Obx(() {
                    final list = controller.filteredBranches;
                    if (list.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Center(
                          child: Text(
                            'No branches found for this location.',
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              color: const Color(0xFF888888),
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return _buildBranchCard(list[index], controller);
                      },
                    );
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

  // ---------- BRANCH CARD ITEM WIDGET ----------
  Widget _buildBranchCard(BranchModel branch, BranchesController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
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
          // Map Graphic Preview Banner Container
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: 160.h,
              width: double.infinity,
              color: const Color(0xFFE9EEF4),
              child: Stack(
                children: [
                  // Vector Map Base Representation
                  CustomPaint(
                    size: Size(double.infinity, 160.h),
                    painter: _MapGraphicPainter(),
                  ),

                  // Pin Marker 1 (Orange Circle Pin)
                  Positioned(
                    top: 24.h,
                    left: 40.w,
                    child: _buildMapPin(color: const Color(0xFFFF6F00), label: 'The Coffee'),
                  ),

                  // Pin Marker 2 (Blue Circle Pin - Current Branch)
                  Positioned(
                    top: 60.h,
                    left: 140.w,
                    child: _buildMapPin(color: const Color(0xFF1E90FF), isMain: true),
                  ),

                  // Pin Marker 3 (Orange Circle Pin - Eladios)
                  Positioned(
                    bottom: 24.h,
                    right: 30.w,
                    child: _buildMapPin(color: const Color(0xFFFF6F00), label: 'Eladios'),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Branch Name & Social Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                branch.name,
                style: GoogleFonts.jost(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF195ABE),
                ),
              ),

              // Social Icons Row (WhatsApp, Instagram, Facebook)
              Row(
                children: [
                  // WhatsApp Icon
                  _buildSocialIcon(
                    svgPath: AppIcons.whatsappSocialIconSvg,
                  ),
                  SizedBox(width: 8.w),

                  // Instagram Icon
                  _buildSocialIcon(
                    svgPath: AppIcons.instagramSocialIconSvg,
                  ),
                  SizedBox(width: 8.w),

                  // Facebook Icon
                  _buildSocialIcon(
                    svgPath: AppIcons.facebookSocialIconSvg,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 4.h),

          // Address & Phone Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                branch.address,
                style: GoogleFonts.jost(
                  fontSize: 12.sp,
                  color: const Color(0xFF777777),
                ),
              ),
              Text(
                branch.phone,
                style: GoogleFonts.jost(
                  fontSize: 12.sp,
                  color: const Color(0xFF777777),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // "How to get there" Outlined Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.openDirections(branch),
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: double.infinity,
                height: 44.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF195ABE),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 14.h),

          // FAQs Section
          Text(
            StaticString.faqsTitle,
            style: GoogleFonts.jost(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF222222),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            StaticString.canIPayInCash,
            style: GoogleFonts.jost(
              fontSize: 11.5.sp,
              color: const Color(0xFF888888),
            ),
          ),
          Text(
            StaticString.doRewardsExpire,
            style: GoogleFonts.jost(
              fontSize: 11.5.sp,
              color: const Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- SOCIAL ICON ITEM ----------
  Widget _buildSocialIcon({required String svgPath, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        svgPath,
        width: 24.w,
        height: 24.h,
        fit: BoxFit.contain,
      ),
    );
  }

  // ---------- MAP PIN WIDGET ----------
  Widget _buildMapPin({required Color color, String? label, bool isMain = false}) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        isMain ? Icons.location_on_rounded : Icons.store_rounded,
        color: Colors.white,
        size: isMain ? 18.r : 14.r,
      ),
    );
  }
}

// ---------- CUSTOM MAP GRAPHIC PAINTER ----------
class _MapGraphicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;

    final thinRoadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Horizontal roads
    canvas.drawLine(
        Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), roadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.7), roadPaint);

    // Diagonal roads
    canvas.drawLine(
        Offset(0, 0), Offset(size.width * 0.8, size.height), thinRoadPaint);
    canvas.drawLine(
        Offset(size.width * 0.2, 0), Offset(size.width, size.height * 0.8), thinRoadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
