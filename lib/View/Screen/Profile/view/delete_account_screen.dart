import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import 'widgets/delete_account_otp_dialog.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _obscureText = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const DeleteAccountOtpDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Blue Header Section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1E90FF),
            ),
            padding: EdgeInsets.only(
              left: 12.w,
              right: 16.w,
              top: statusBarHeight + 10.h,
              bottom: 16.h,
            ),
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    StaticString.deleteAccountTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 36.w), // Spacer for centering
              ],
            ),
          ),

          // Scrollable Body Form Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 28.h),

                  // Hero SVG Illustration: Want to delete account !-img.svg
                  SvgPicture.asset(
                    AppIcons.wantToDeleteAccountSvg,
                    height: 160.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.delete_forever_rounded,
                      size: 100.r,
                      color: const Color(0xFFD32F2F),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Red Title: Want to delete account !
                  Text(
                    StaticString.wantToDeleteAccountTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD32F2F),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // Subtitle: Please confirm otp code to remove your account.
                  Text(
                    StaticString.confirmOtpCodeToSmall,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 13.sp,
                      color: const Color(0xFF777777),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Form Field Label: Enter Phone Number
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StaticString.enterPhoneNumberLabel,
                      style: GoogleFonts.jost(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Phone Number Input Field
                  Container(
                    height: 48.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            obscureText: _obscureText,
                            style: GoogleFonts.jost(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF222222),
                            ),
                            decoration: InputDecoration(
                              hintText: StaticString.enterYourPhoneNumberHint,
                              hintStyle: GoogleFonts.jost(
                                fontSize: 13.sp,
                                color: const Color(0xFF999999),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: false,
                              fillColor: Colors.transparent,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 19.r,
                            color: const Color(0xFF888888),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 44.h),

                  // Primary Button: "Continue"
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _onContinuePressed,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF195ABE),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            StaticString.continueText,
                            style: GoogleFonts.jost(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
