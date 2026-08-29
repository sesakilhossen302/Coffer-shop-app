import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Core/AppRoute/app_route.dart';
import '../../../../../Utils/StaticString/static_string.dart';

class EditProfileSuccessDialog extends StatelessWidget {
  const EditProfileSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Blue Checkmark Circle Icon
            Container(
              width: 64.r,
              height: 64.r,
              decoration: const BoxDecoration(
                color: Color(0xFF195ABE),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 38.r,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Title: Edit Profile Successful
            Text(
              StaticString.editProfileSuccessful,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222222),
              ),
            ),

            SizedBox(height: 8.h),

            // Subtitle: Your profile has been updated successfully.
            Text(
              StaticString.profileUpdatedSuccessfully,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 13.sp,
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
                  Get.back(); // Close Dialog
                  Get.offAllNamed(AppRoute.homeScreen); // Return to Profile / Home
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
