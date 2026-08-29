import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Utils/StaticString/static_string.dart';

class SupportSuccessDialog extends StatelessWidget {
  const SupportSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Green Checkmark Circle Icon
            Container(
              width: 60.r,
              height: 60.r,
              decoration: const BoxDecoration(
                color: Color(0xFF4CD964),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 38.r,
              ),
            ),

            SizedBox(height: 18.h),

            // Title: Support Message Sent
            Text(
              StaticString.supportMessageSent,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222222),
              ),
            ),

            SizedBox(height: 8.h),

            // Subtitle: Your message has been sent successfully. We will get back to you soon.
            Text(
              StaticString.messageSentSuccessMsg,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 13.sp,
                color: const Color(0xFF777777),
                height: 1.35,
              ),
            ),

            SizedBox(height: 24.h),

            // "Got it" Button
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.back(); // Close dialog
                  Get.back(); // Return to Profile screen
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 120.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF195ABE),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      StaticString.gotItBtn,
                      style: GoogleFonts.jost(
                        fontSize: 14.5.sp,
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
