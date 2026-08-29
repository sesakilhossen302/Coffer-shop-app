import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/make_payment_controller.dart';

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MakePaymentController controller = Get.isRegistered<MakePaymentController>()
        ? Get.find<MakePaymentController>()
        : Get.put(MakePaymentController());

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
                      if (Navigator.canPop(context)) {
                        Get.back();
                      } else {
                        Get.offAllNamed(AppRoute.homeScreen);
                      }
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
                    StaticString.paymentMethodTitle,
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

          // Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  // Section Headline "Debit / credit card"
                  Text(
                    StaticString.debitCreditCard,
                    style: GoogleFonts.jost(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E90FF),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Field 1: Card Number
                  Text(
                    StaticString.cardNumber,
                    style: GoogleFonts.jost(
                      fontSize: 12.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F5F7),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.cardNumberController,
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF195ABE),
                              letterSpacing: 0.5,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        // Mastercard Red/Yellow Overlay Circles Logo
                        SizedBox(
                          width: 30.w,
                          height: 20.h,
                          child: Stack(
                            children: [
                              Container(
                                width: 18.w,
                                height: 18.h,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEB001B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Positioned(
                                left: 10.w,
                                child: Container(
                                  width: 18.w,
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF79E1B).withValues(alpha: 0.9),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Field 2: Name of the holder
                  Text(
                    StaticString.nameOfHolder,
                    style: GoogleFonts.jost(
                      fontSize: 12.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F5F7),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Center(
                      child: TextField(
                        controller: controller.holderNameController,
                        style: GoogleFonts.jost(
                          fontSize: 14.sp,
                          color: const Color(0xFF1E90FF),
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Field 3: Expiration Date & CVV Row
                  Row(
                    children: [
                      // Expiration Date Dropdown Selectors
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StaticString.expirationDate,
                              style: GoogleFonts.jost(
                                fontSize: 12.sp,
                                color: const Color(0xFF888888),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              height: 52.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F7),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Row(
                                children: [
                                  Obx(
                                    () => DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: controller.selectedMonth.value,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF1E90FF),
                                          size: 18,
                                        ),
                                        style: GoogleFonts.jost(
                                          fontSize: 13.sp,
                                          color: const Color(0xFF1E90FF),
                                        ),
                                        items: controller.months
                                            .map((month) => DropdownMenuItem(
                                                  value: month,
                                                  child: Text(month),
                                                ))
                                            .toList(),
                                        onChanged: (val) {
                                          if (val != null) {
                                            controller.selectedMonth.value = val;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Obx(
                                    () => DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: controller.selectedYear.value,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF1E90FF),
                                          size: 18,
                                        ),
                                        style: GoogleFonts.jost(
                                          fontSize: 13.sp,
                                          color: const Color(0xFF1E90FF),
                                        ),
                                        items: controller.years
                                            .map((year) => DropdownMenuItem(
                                                  value: year,
                                                  child: Text(year),
                                                ))
                                            .toList(),
                                        onChanged: (val) {
                                          if (val != null) {
                                            controller.selectedYear.value = val;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 14.w),

                      // CVV Field
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StaticString.cvv,
                              style: GoogleFonts.jost(
                                fontSize: 12.sp,
                                color: const Color(0xFF888888),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              height: 52.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F7),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Center(
                                child: TextField(
                                  controller: controller.cvvController,
                                  obscureText: true,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.jost(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF195ABE),
                                    letterSpacing: 2.0,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 28.h),

                  // "Pay $40.00" Action Button
                  Obx(
                    () => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: controller.processPayment,
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          width: double.infinity,
                          height: 54.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF195ABE),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Center(
                            child: Text(
                              'Pay \$${controller.payableAmount.value.toStringAsFixed(2)}',
                              style: GoogleFonts.jost(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // "100% safe and secure payment" Subtitle Badge
                  Center(
                    child: Text(
                      StaticString.safeAndSecurePayment,
                      style: GoogleFonts.jost(
                        fontSize: 11.sp,
                        color: const Color(0xFF888888),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // "or pay with" Left Title + Right Divider Line (Matching Figma Design)
                  Row(
                    children: [
                      Text(
                        StaticString.orPayWith,
                        style: GoogleFonts.jost(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E90FF),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      const Expanded(
                        child: Divider(color: Color(0xFFE8ECEF), thickness: 1.5),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Apple Pay & Google Pay SVG Option Cards (Matching Figma Design)
                  Row(
                    children: [
                      _buildAlternativePaymentCard(AppIcons.applePayIcon),
                      SizedBox(width: 14.w),
                      _buildAlternativePaymentCard(AppIcons.googlePayIcon),
                    ],
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- ALTERNATIVE PAYMENT SVG CARD WIDGET ----------
  Widget _buildAlternativePaymentCard(String svgIconPath) {
    return Container(
      width: 86.w,
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFD0D7E2),
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Center(
        child: SvgPicture.asset(
          svgIconPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
