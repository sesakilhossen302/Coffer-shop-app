import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/gift_card_controller.dart';

class ReviewGiftCardScreen extends StatelessWidget {
  const ReviewGiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GiftCardController controller = Get.isRegistered<GiftCardController>()
        ? Get.find<GiftCardController>()
        : Get.put(GiftCardController());

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
                    StaticString.giftCardAddedTitle,
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

                  // Wallet Outline Icon Badge
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3FF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF195ABE),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Color(0xFF195ABE),
                        size: 32,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // "Review & Confirm" Title
                  Text(
                    StaticString.reviewAndConfirm,
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
                    StaticString.giftCardAddedSubMsg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 12.5.sp,
                      color: const Color(0xFF888888),
                      height: 1.35,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Review Breakdown Container Box
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
                        _buildReviewRow(
                          icon: Icons.credit_card_rounded,
                          title: StaticString.giftCard,
                          value: StaticString.caffecitoGiftCard,
                        ),
                        SizedBox(height: 14.h),

                        // Row 2: Card number
                        _buildCardNumberRow(),
                        SizedBox(height: 14.h),

                        // Row 3: Amount to add
                        _buildReviewRow(
                          icon: Icons.attach_money_rounded,
                          title: StaticString.amountToAdd,
                          value: '400 MXN',
                        ),
                        SizedBox(height: 14.h),

                        const Divider(color: Color(0xFFE0E7F2), thickness: 1),
                        SizedBox(height: 14.h),

                        // Row 4: Current wallet balance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StaticString.currentWalletBalance,
                              style: GoogleFonts.jost(
                                fontSize: 12.5.sp,
                                color: const Color(0xFF666666),
                              ),
                            ),
                            Text(
                              StaticString.currentBalanceValue,
                              style: GoogleFonts.jost(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF222222),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        // Row 5: New wallet balance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StaticString.newWalletBalance,
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

                  SizedBox(height: 16.h),

                  // Notice Light Blue Info Banner
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3FF),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: const Color(0xFF195ABE),
                          size: 18.r,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            StaticString.onceAddedNotice,
                            style: GoogleFonts.jost(
                              fontSize: 11.5.sp,
                              color: const Color(0xFF195ABE),
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Primary Button: "Confirm & Add"
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.confirmAndAdd,
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
                            StaticString.confirmAndAdd,
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

                  // Secondary Button: "Cancel"
                  Center(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        StaticString.cancel,
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

  // ---------- REVIEW ITEM ROW WIDGET ----------
  Widget _buildReviewRow({
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
