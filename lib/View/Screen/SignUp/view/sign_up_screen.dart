import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppColors/app_colors.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 16.h),

                      // Top Navigation Header with Circular Back Button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 44.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFE0E4EC).withValues(alpha: 0.6),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: Color(0xFF555555),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Title: "Join the club!"
                      Text(
                        StaticString.joinTheClub,
                        style: GoogleFonts.jost(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1E90FF),
                          letterSpacing: 0.5,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Subtitle: "Create an account to continue"
                      Text(
                        StaticString.createAccountToContinue,
                        style: GoogleFonts.jost(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1E90FF),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Field 1: Full name
                      _buildWhiteInputField(
                        controller: controller.fullNameController,
                        hintText: StaticString.fullName,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(height: 16.h),

                      // Field 2: Email
                      _buildWhiteInputField(
                        controller: controller.emailController,
                        hintText: StaticString.email,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: 16.h),

                      // Field 3: Date of birth (18/03/2024 with calendar icon)
                      _buildWhiteInputField(
                        controller: controller.dobController,
                        hintText: StaticString.dobPlaceholder,
                        readOnly: true,
                        onTap: () => controller.selectDateOfBirth(context),
                        suffixIcon: const Icon(
                          Icons.calendar_today_outlined,
                          color: Color(0xFF888888),
                          size: 20,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Field 4: Country Flag + Phone Number Input
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
                        child: Row(
                          children: [
                            // Country Flag Selector Button
                            Obx(
                              () => InkWell(
                                onTap: () => controller.pickCountry(context),
                                borderRadius: BorderRadius.circular(16.r),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.selectedCountry.value.flagEmoji,
                                        style: TextStyle(fontSize: 22.sp),
                                      ),
                                      SizedBox(width: 6.w),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFF888888),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Vertical Divider Line
                            Container(
                              width: 1,
                              height: 28.h,
                              color: const Color(0xFFE5E5E5),
                            ),

                            // Phone Number Text Field
                            Expanded(
                              child: TextField(
                                controller: controller.phoneController,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.jost(
                                  fontSize: 15.sp,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: StaticString.phoneNumber,
                                  hintStyle: GoogleFonts.jost(
                                    fontSize: 15.sp,
                                    color: const Color(0xFFA0A0A0),
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 14.h,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // "Create account" Action Button (#195ABE)
                      SizedBox(
                        width: double.infinity,
                        height: 54.h,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.submitSignUp();
                            Get.toNamed(
                              AppRoute.otpScreen,
                              arguments: {
                                'isEmail': false,
                                'target': controller.phoneController.text.isNotEmpty
                                    ? '+${controller.selectedCountry.value.phoneCode} ${controller.phoneController.text}'
                                    : '+52 9999 10 20 30',
                              },
                            );
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
                            StaticString.createAccount,
                            style: GoogleFonts.jost(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // Agreement Footer Text
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.jost(
                            fontSize: 13.sp,
                            color: const Color(0xFF888888),
                          ),
                          children: [
                            const TextSpan(text: StaticString.termsAgreement),
                            TextSpan(
                              text: StaticString.termsAndConditions,
                              style: GoogleFonts.jost(
                                color: const Color(0xFF1E90FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Bottom Link: "Already have an account? Log in"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${StaticString.alreadyHaveAccount} ',
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              color: const Color(0xFF888888),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.offNamed(AppRoute.loginScreen),
                            child: Text(
                              StaticString.logIn,
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

  Widget _buildWhiteInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return Container(
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
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        style: GoogleFonts.jost(
          fontSize: 15.sp,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.jost(
            fontSize: 15.sp,
            color: const Color(0xFFA0A0A0),
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        ),
      ),
    );
  }
}
