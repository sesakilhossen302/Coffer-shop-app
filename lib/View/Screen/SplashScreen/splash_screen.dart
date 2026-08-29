import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../Core/AppRoute/app_route.dart';
import '../../../Utils/AppColors/app_colors.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../../Widgegt/CoffecitoMascot/coffecito_mascot.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Hero Running Coffecito Mascot Illustration
              Center(
                child: CoffecitoMascot(
                  width: 260.w,
                  height: 260.h,
                  isMini: false,
                ),
              ),

              SizedBox(height: 36.h),

              // Headline Text "READY TO BOOST YOUR DAY?"
              Text(
                StaticString.readyToBoost,
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.25,
                  letterSpacing: 0.5,
                ),
              ),

              const Spacer(flex: 3),

              // "Start Now" Bottom Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.loginScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.startNowButton,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    StaticString.startNow,
                    style: GoogleFonts.sora(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
