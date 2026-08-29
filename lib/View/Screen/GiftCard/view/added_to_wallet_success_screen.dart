import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/StaticString/static_string.dart';

class AddedToWalletSuccessScreen extends StatelessWidget {
  const AddedToWalletSuccessScreen({super.key});

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
                    onTap: () => Get.offAllNamed(AppRoute.homeScreen),
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
                    StaticString.addedToWallet,
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

          // Main Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 28.h),

                  // Green Checkmark Circle Badge
                  Container(
                    width: 56.r,
                    height: 56.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFF34C759),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // "Added Successfully!" Title
                  Text(
                    StaticString.addedSuccessfullyExclamation,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222222),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // Subtitle Message
                  Text(
                    StaticString.addedToWalletSubMsg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 12.5.sp,
                      color: const Color(0xFF888888),
                      height: 1.35,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Summary Info Container Box
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F8FC),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      children: [
                        // Row 1: Gift card
                        _buildSummaryRow(
                          icon: Icons.credit_card_rounded,
                          title: StaticString.giftCard,
                          value: StaticString.caffecitoGiftCard,
                        ),
                        SizedBox(height: 14.h),

                        // Row 2: Card number
                        _buildCardNumberRow(),
                        SizedBox(height: 14.h),

                        // Row 3: Amount added
                        _buildSummaryRow(
                          icon: Icons.attach_money_rounded,
                          title: StaticString.amountAdded,
                          value: '400 MXN',
                        ),
                        SizedBox(height: 14.h),

                        // Row 4: Added on
                        _buildSummaryRow(
                          icon: Icons.calendar_today_outlined,
                          title: StaticString.addedOn,
                          value: StaticString.addedOnDate,
                        ),
                        SizedBox(height: 14.h),

                        const Divider(color: Color(0xFFE0E7F2), thickness: 1),
                        SizedBox(height: 14.h),

                        // Row 5: New Wallet Balance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StaticString.newWalletBalanceLabel,
                              style: GoogleFonts.jost(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF222222),
                              ),
                            ),
                            Text(
                              StaticString.newBalanceValue,
                              style: GoogleFonts.jost(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF195ABE),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Primary Button: "Go to My Wallet"
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.toNamed(AppRoute.myWalletScreen),
                      borderRadius: BorderRadius.circular(14.r),
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF195ABE),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Center(
                          child: Text(
                            StaticString.goToMyWallet,
                            style: GoogleFonts.jost(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Secondary Button: "Back to Home"
                  Center(
                    child: TextButton(
                      onPressed: () => Get.offAllNamed(AppRoute.homeScreen),
                      child: Text(
                        StaticString.backToHome,
                        style: GoogleFonts.jost(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- SUMMARY ITEM ROW WIDGET ----------
  Widget _buildSummaryRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF1E90FF),
          size: 20.r,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.jost(
              fontSize: 12.5.sp,
              color: const Color(0xFF888888),
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.jost(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF195ABE),
          ),
        ),
      ],
    );
  }

  // ---------- CARD NUMBER ROW WIDGET ----------
  Widget _buildCardNumberRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.credit_card_rounded,
          color: const Color(0xFF1E90FF),
          size: 20.r,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            StaticString.cardNumLabel,
            style: GoogleFonts.jost(
              fontSize: 12.5.sp,
              color: const Color(0xFF888888),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StaticString.maskedCardNumber,
              style: GoogleFonts.jost(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF195ABE),
              ),
            ),
            SizedBox(width: 6.w),
            Icon(
              Icons.copy_rounded,
              color: const Color(0xFF195ABE),
              size: 15.r,
            ),
          ],
        ),
      ],
    );
  }
}
