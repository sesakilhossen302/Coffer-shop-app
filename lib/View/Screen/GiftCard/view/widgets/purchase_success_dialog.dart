import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Core/AppRoute/app_route.dart';
import '../../../../../Utils/StaticString/static_string.dart';

class PurchaseSuccessDialog extends StatelessWidget {
  const PurchaseSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Green Checkmark Icon Circle
            Container(
              width: 56.r,
              height: 56.r,
              decoration: const BoxDecoration(
                color: Color(0xFF34C759),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),

            SizedBox(height: 18.h),

            // Title: "Purchase Successfully!"
            Text(
              StaticString.purchaseSuccessfully,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222222),
              ),
            ),

            SizedBox(height: 8.h),

            // Subtitle Message
            Text(
              StaticString.purchaseSuccessMsg,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 12.sp,
                color: const Color(0xFF777777),
                height: 1.35,
              ),
            ),

            SizedBox(height: 24.h),

            // "Ok" Action Button
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.back(); // Dismiss dialog
                  Get.offAllNamed(AppRoute.homeScreen);
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 120.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF195ABE),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      StaticString.okText,
                      style: GoogleFonts.jost(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
