import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Utils/StaticString/static_string.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final VoidCallback onOkPressed;

  const PaymentSuccessDialog({
    super.key,
    required this.onOkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circular Green Checkmark Badge
            Container(
              width: 58.w,
              height: 58.h,
              decoration: const BoxDecoration(
                color: Color(0xFF34C759),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // "Thanks for your order" Title
            Text(
              StaticString.thanksForYourOrder,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222222),
              ),
            ),

            SizedBox(height: 10.h),

            // Message Subtitle
            Text(
              StaticString.paymentCompletedMsg,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 12.sp,
                color: const Color(0xFF888888),
                height: 1.35,
              ),
            ),

            SizedBox(height: 24.h),

            // "Ok" Action Button
            SizedBox(
              width: 110.w,
              height: 44.h,
              child: ElevatedButton(
                onPressed: onOkPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF195ABE),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Ok',
                  style: GoogleFonts.jost(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
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
