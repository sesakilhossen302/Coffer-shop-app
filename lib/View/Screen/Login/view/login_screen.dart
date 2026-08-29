import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/AppColors/app_colors.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../../Widgegt/SocialLoginButton/social_login_buttons.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),

                      // Header SVG Icon: WELCOME!-Icons.svg
                      Center(
                        child: SvgPicture.asset(
                          AppIcons.welcomeIcon,
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // "WELCOME!" Headline in #1E90FF Blue with Jost Font
                      Text(
                        StaticString.welcome,
                        style: GoogleFonts.jost(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1E90FF),
                          letterSpacing: 1.0,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Subtitle Text ("Enter your number..." / "Enter your email...")
                      Obx(
                        () => Text(
                          controller.isEmailMode.value
                              ? StaticString.enterEmailToContinue
                              : StaticString.enterNumberToContinue,
                          style: GoogleFonts.jost(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1E90FF),
                          ),
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // White Input Card Container
                      Container(
                        width: double.infinity,
                        height: 54.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Obx(
                          () => TextField(
                            controller: controller.inputController,
                            textAlign: TextAlign.center,
                            keyboardType: controller.isEmailMode.value
                                ? TextInputType.emailAddress
                                : TextInputType.phone,
                            style: GoogleFonts.jost(
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: controller.isEmailMode.value
                                  ? StaticString.emailPlaceholder
                                  : StaticString.phonePlaceholder,
                              hintStyle: GoogleFonts.jost(
                                fontSize: 15.sp,
                                color: const Color(0xFFA0A0A0),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // "Continue" Action Button in Dark Blue (#195ABE)
                      SizedBox(
                        width: double.infinity,
                        height: 54.h,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.submitLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF195ABE),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Text(
                            StaticString.continueText,
                            style: GoogleFonts.jost(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // Divider "or continue with"
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(color: Color(0xFFDCDCDC), thickness: 1),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              StaticString.orContinueWith,
                              style: GoogleFonts.jost(
                                fontSize: 13.sp,
                                color: const Color(0xFF888888),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(color: Color(0xFFDCDCDC), thickness: 1),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Social Login Circular Buttons (Facebook, Google, Apple)
                      SocialLoginButtons(
                        onFacebookTap: () {},
                        onGoogleTap: () {},
                        onAppleTap: () {},
                      ),

                      SizedBox(height: 24.h),

                      // Toggle Mode Button ("Use email" / "Use Phone Number")
                      Obx(
                        () => OutlinedButton(
                          onPressed: controller.toggleLoginMode,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFFCCCCCC), width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          ),
                          child: Text(
                            controller.isEmailMode.value
                                ? StaticString.usePhoneNumber
                                : StaticString.useEmail,
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              color: const Color(0xFF666666),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 36.h),

                      // Bottom Link: "Don't have an account? Sign Up"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${StaticString.dontHaveAccount} ',
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              color: const Color(0xFF888888),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Sign Up screen
                            },
                            child: Text(
                              StaticString.signUp,
                              style: GoogleFonts.jost(
                                fontSize: 14.sp,
                                color: const Color(0xFF1E90FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
