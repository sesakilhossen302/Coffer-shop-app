import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/order_status_controller.dart';

class OrderReceivedScreen extends StatelessWidget {
  const OrderReceivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderStatusController controller = Get.isRegistered<OrderStatusController>()
        ? Get.find<OrderStatusController>()
        : Get.put(OrderStatusController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Blue Header
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
                      Get.offAllNamed(AppRoute.homeScreen);
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
                    StaticString.orderReceived,
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

          // Main Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // Hero Blue Banner Card with Order Received-img.svg Illustration
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E90FF),
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    clipBehavior: Clip.antiAlias,
                    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.orderReceivedImg,
                        width: 280.w,
                        height: 380.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Custom Dashed Divider Line
                  _buildDashedLine(),

                  SizedBox(height: 16.h),

                  // Status Progress Blue Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF195ABE),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                    child: Column(
                      children: [
                        Text(
                          StaticString.preparingYourOrder,
                          style: GoogleFonts.jost(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 14.h),

                        // Progress Step Dots Indicator
                        Obx(
                          () => _buildStepProgressDots(controller.currentProgressStep.value),
                        ),

                        SizedBox(height: 12.h),

                        Text(
                          StaticString.preparingCoffeeAndExtras,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.jost(
                            fontSize: 12.sp,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- STEP PROGRESS DOTS WIDGET ----------
  Widget _buildStepProgressDots(int activeStep) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(isActive: activeStep >= 0),
        _buildLine(isActive: activeStep >= 1),
        _buildDot(isActive: activeStep >= 1),
        _buildLine(isActive: activeStep >= 2),
        _buildDot(isActive: activeStep >= 2),
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 10.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.4),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildLine({required bool isActive}) {
    return Container(
      width: 50.w,
      height: 2.h,
      color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.4),
    );
  }

  // ---------- DASHED LINE DIVIDER ----------
  Widget _buildDashedLine() {
    return Row(
      children: List.generate(
        30,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? const Color(0xFFD0D7E2) : Colors.transparent,
            height: 1.5.h,
          ),
        ),
      ),
    );
  }
}
