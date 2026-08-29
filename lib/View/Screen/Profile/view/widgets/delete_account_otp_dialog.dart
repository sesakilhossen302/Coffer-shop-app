import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Utils/AppIcons/app_icons.dart';
import '../../../../../Utils/StaticString/static_string.dart';
import 'delete_account_success_dialog.dart';

class DeleteAccountOtpDialog extends StatelessWidget {
  const DeleteAccountOtpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> defaultPin = ['7', '4', '5', '5', '5', '8'];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Red OTP Phone Icon
            SvgPicture.asset(
              AppIcons.otpIconSvg,
              width: 52.w,
              height: 52.h,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.mark_email_read_rounded,
                color: const Color(0xFFD32F2F),
                size: 52.r,
              ),
            ),

            SizedBox(height: 16.h),

            // Title: Account Deletion Request!
            Text(
              StaticString.accountDeletionRequest,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222222),
              ),
            ),

            SizedBox(height: 6.h),

            // Subtitle: We've Sent a Code to exa...@email.com
            Text(
              StaticString.sentCodeToEmailSub,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 12.5.sp,
                color: const Color(0xFF777777),
              ),
            ),

            SizedBox(height: 20.h),

            // 6-Digit Pin Input Boxes (7 4 5 5 5 8)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => Container(
                  width: 38.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFF195ABE),
                      width: 1.2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      defaultPin[index],
                      style: GoogleFonts.jost(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF195ABE),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Resend Link Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "If you didn't receive a code, ",
                  style: GoogleFonts.jost(
                    fontSize: 12.sp,
                    color: const Color(0xFF888888),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                      'Resend Code',
                      'A new deletion OTP code has been sent.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xFF195ABE),
                      colorText: Colors.white,
                    );
                  },
                  child: Text(
                    StaticString.resendCode,
                    style: GoogleFonts.jost(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF195ABE),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Action Buttons Row (Cancel / Delete)
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

                // Delete Red Button
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.back(); // Close OTP dialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              const DeleteAccountSuccessDialog(),
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
                            StaticString.deleteBtn,
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
