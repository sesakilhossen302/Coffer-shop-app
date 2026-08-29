import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/StaticString/static_string.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
                    StaticString.termsAndConditionsTitle,
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

          // Scrollable Document Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Last Updated
                  Text(
                    StaticString.termsAndConditionsTitle,
                    style: GoogleFonts.jost(
                      fontSize: 14.sp,
                      color: const Color(0xFF777777),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    StaticString.lastUpdatedDate,
                    style: GoogleFonts.jost(
                      fontSize: 12.sp,
                      color: const Color(0xFF999999),
                    ),
                  ),

                  SizedBox(height: 12.h),
                  const Divider(color: Color(0xFFEBEBEB), thickness: 1),
                  SizedBox(height: 14.h),

                  // Preamble
                  Text(
                    'By accessing or using COFFECITO, you agree to the following Terms & Conditions.',
                    style: GoogleFonts.jost(
                      fontSize: 13.sp,
                      color: const Color(0xFF333333),
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Section 1: Use of the App
                  _buildSectionTitle('1. Use of the App'),
                  _buildBulletPoint(
                      'You must be at least 18 years old or have parental permission.'),
                  _buildBulletPoint(
                      'You agree to provide accurate and complete information.'),
                  _buildBulletPoint(
                      'You are responsible for maintaining the confidentiality of your account.'),

                  SizedBox(height: 16.h),

                  // Section 2: Orders & Payments
                  _buildSectionTitle('2. Orders & Payments'),
                  _buildBulletPoint('All prices are displayed before checkout.'),
                  _buildBulletPoint('Orders cannot be modified once confirmed.'),
                  _buildBulletPoint(
                      'Payment must be completed before order processing.'),
                  _buildBulletPoint('Pickup times are estimates and may vary.'),

                  SizedBox(height: 16.h),

                  // Section 3: Cancellations & Refunds
                  _buildSectionTitle('3. Cancellations & Refunds'),
                  _buildBulletPoint(
                      'Orders may not be canceled once preparation has started.'),
                  _buildBulletPoint(
                      "Refunds, if applicable, will be processed according to COFFECITO's refund policy."),

                  SizedBox(height: 16.h),

                  // Section 4: Availability
                  _buildSectionTitle('4. Availability'),
                  _buildBulletPoint('Menu items are subject to availability.'),
                  _buildBulletPoint(
                      'If an item is unavailable, it may be disabled or removed from the menu.'),

                  SizedBox(height: 16.h),

                  // Section 5: User Conduct
                  _buildSectionTitle('5. User Conduct'),
                  Text(
                    'You agree not to:',
                    style: GoogleFonts.jost(
                      fontSize: 12.5.sp,
                      color: const Color(0xFF444444),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  _buildBulletPoint('Misuse the app'),
                  _buildBulletPoint('Attempt unauthorized access'),
                  _buildBulletPoint('Provide false or misleading information'),
                  _buildBulletPoint(
                      'Disrupt or interfere with app functionality'),

                  SizedBox(height: 16.h),

                  // Section 6: Intellectual Property
                  _buildSectionTitle('6. Intellectual Property'),
                  Text(
                    'All content, logos, designs, and trademarks used in COFFECITO are owned by COFFECITO and may not be used without permission.',
                    style: GoogleFonts.jost(
                      fontSize: 12.5.sp,
                      color: const Color(0xFF444444),
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Section 7: Limitation of Liability
                  _buildSectionTitle('7. Limitation of Liability'),
                  Text(
                    'COFFECITO is not responsible for:',
                    style: GoogleFonts.jost(
                      fontSize: 12.5.sp,
                      color: const Color(0xFF444444),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  _buildBulletPoint('Delays due to technical issues'),
                  _buildBulletPoint('Incorrect estimated pickup times'),
                  _buildBulletPoint(
                      'Service interruptions beyond our control'),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- HELPER WIDGETS ----------
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        title,
        style: GoogleFonts.jost(
          fontSize: 13.5.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF222222),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w, bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•  ',
            style: GoogleFonts.jost(
              fontSize: 12.5.sp,
              color: const Color(0xFF555555),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.jost(
                fontSize: 12.5.sp,
                color: const Color(0xFF555555),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
