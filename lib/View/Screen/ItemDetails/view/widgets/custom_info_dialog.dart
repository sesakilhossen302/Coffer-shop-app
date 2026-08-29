import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInfoDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onOkPressed;

  const CustomInfoDialog({
    super.key,
    required this.title,
    required this.message,
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
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Popup Title ("Added to cart" / "Added as Fav")
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222222),
              ),
            ),

            SizedBox(height: 8.h),

            // Popup Subtitle Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 12.sp,
                color: const Color(0xFF888888),
                height: 1.3,
              ),
            ),

            SizedBox(height: 20.h),

            // "Ok" Action Button
            SizedBox(
              width: 100.w,
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
