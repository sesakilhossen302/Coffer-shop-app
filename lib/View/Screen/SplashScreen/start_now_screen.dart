import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Core/AppRoute/app_route.dart';
import '../../../Utils/AppColors/app_colors.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/StaticString/static_string.dart';

class StartNowScreen extends StatelessWidget {
  const StartNowScreen({super.key});

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

              // Hero Illustration: Start Now-Icons.svg
              Center(
                child: SvgPicture.asset(
                  AppIcons.startNowIcon,
                  width: 260.w,
                  height: 260.h,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 36.h),

              // Headline Text "READY TO BOOST YOUR DAY?"
              Text(
                StaticString.readyToBoost,
                textAlign: TextAlign.center,
                style: GoogleFonts.jost(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.25,
                  letterSpacing: 0.5,
                ),
              ),

              const Spacer(flex: 3),

              // "Start Now" Action Button -> Navigates to Login Screen
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
                    style: GoogleFonts.jost(
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
