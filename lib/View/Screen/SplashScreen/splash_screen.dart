import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/AppColors/app_colors.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../../Widgegt/custom_loader/custom_loader.dart';
import '../../Widgegt/custom_text/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Splash screen timer delay
    Future.delayed(const Duration(seconds: 3), () {
      // Route to next screen after splash
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          // Background Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1F1F1F),
                  AppColors.secondary,
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Coffee Icon Logo Container
                Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.coffee_rounded,
                    size: 72.sp,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 24.h),

                // App Title
                const CustomText(
                  text: StaticString.appTitle,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
                SizedBox(height: 8.h),

                // Tagline
                CustomText(
                  text: 'splash_tagline',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textSecondary,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48.h),

                // Custom Loading Indicator
                const CustomLoader(
                  color: AppColors.primary,
                  size: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
