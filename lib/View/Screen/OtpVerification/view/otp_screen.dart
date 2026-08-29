import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());

    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: GoogleFonts.jost(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1E90FF),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFC5D9F8), width: 1.5),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      textStyle: GoogleFonts.jost(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFFF3B30),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFFF3B30), width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF1E90FF), width: 2),
      ),
    );

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

                      SizedBox(height: 36.h),

                      // Title ("Enter the code" / "Check your email")
                      Obx(
                        () => Text(
                          controller.isEmailVerification.value
                              ? StaticString.checkYourEmail
                              : StaticString.enterTheCode,
                          style: GoogleFonts.jost(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1E90FF),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Subtitle
                      Obx(
                        () => RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              color: const Color(0xFF1E90FF),
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: controller.isEmailVerification.value
                                    ? '${StaticString.sentCodeToEmail} '
                                    : '${StaticString.sentSmsToPhone}\n',
                              ),
                              TextSpan(
                                text: controller.targetDestination.value,
                                style: GoogleFonts.jost(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1E90FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 36.h),

                      // Pinput 5 Pin Code Boxes
                      Obx(
                        () => Pinput(
                          length: 5,
                          controller: controller.pinController,
                          defaultPinTheme: controller.hasError.value
                              ? errorPinTheme
                              : defaultPinTheme,
                          focusedPinTheme: controller.hasError.value
                              ? errorPinTheme
                              : focusedPinTheme,
                          onChanged: (value) {
                            if (controller.hasError.value) {
                              controller.hasError.value = false;
                            }
                          },
                          onCompleted: (pin) {
                            controller.verifyPin(pin);
                          },
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Error Message if Code is Incorrect
                      Obx(
                        () => controller.hasError.value
                            ? Text(
                                StaticString.incorrectCodeTryAgain,
                                style: GoogleFonts.jost(
                                  fontSize: 13.sp,
                                  color: const Color(0xFFFF3B30),
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      SizedBox(height: 20.h),

                      // Resend Code Countdown Timer
                      Obx(
                        () => GestureDetector(
                          onTap: controller.timerSeconds.value == 0
                              ? controller.resendCode
                              : null,
                          child: Text(
                            controller.timerSeconds.value > 0
                                ? '${StaticString.resendCode} 00:${controller.timerSeconds.value.toString().padLeft(2, '0')}'
                                : '${StaticString.resendCode} Now',
                            style: GoogleFonts.jost(
                              fontSize: 13.sp,
                              color: controller.timerSeconds.value > 0
                                  ? const Color(0xFF777777)
                                  : const Color(0xFF1E90FF),
                              fontWeight: controller.timerSeconds.value == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),
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
