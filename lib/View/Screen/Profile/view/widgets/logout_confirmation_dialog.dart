import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../../../../../Utils/StaticString/static_string.dart';
import 'logout_success_dialog.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

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
            // Red Logout SVG Icon
            SvgPicture.asset(
              AppIcons.logoutIconSvg,
              width: 52.w,
              height: 52.h,
              colorFilter: const ColorFilter.mode(
                Color(0xFFD32F2F),
                BlendMode.srcIn,
              ),
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.logout_rounded,
                color: const Color(0xFFD32F2F),
                size: 52.r,
              ),
            ),

            SizedBox(height: 18.h),

            // Title: Log Out!
            Text(
              StaticString.logoutTitleExclamation,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222222),
              ),
            ),

            SizedBox(height: 6.h),

            // Subtitle: Do you want to log out of your profile?
            Text(
              StaticString.doYouWantToLogoutMsg,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 13.sp,
                color: const Color(0xFF777777),
              ),
            ),

            SizedBox(height: 24.h),

            // Action Buttons Row (Cancel / Log Out)
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFFCCCCCC),
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            StaticString.cancel,
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF666666),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                // Log Out Red Button
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.back(); // Close confirmation dialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const LogoutSuccessDialog(),
                        );
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD32F2F),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            StaticString.logOut,
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
