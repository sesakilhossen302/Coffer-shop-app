import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/gift_card_controller.dart';

class GiftCardAddedScreen extends StatelessWidget {
  const GiftCardAddedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GiftCardController controller = Get.isRegistered<GiftCardController>()
        ? Get.find<GiftCardController>()
        : Get.put(GiftCardController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final card = controller.giftCard.value;

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
                  SizedBox(height: 24.h),

                  // Green Checkmark Icon Badge
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

                  // "Gift Card Added Successfully!" Title
                  Text(
                    StaticString.giftCardAddedSuccessfully,
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

                  // Gift Card Hero Banner
                  Container(
                    width: double.infinity,
                    height: 165.h,
                    decoration: BoxDecoration(
                      color: card.cardColor,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: card.cardColor.withValues(alpha: 0.3),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        // COFFECITO Logo Top Center
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 20.h,
                          child: Center(
                            child: SvgPicture.asset(
                              AppIcons.coffecitoLogoSvg,
                              height: 28.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        // Running Cup Bottom Left
                        Positioned(
                          left: 20.w,
                          bottom: 16.h,
                          child: SvgPicture.asset(
                            card.svgPath,
                            height: 76.h,
                            fit: BoxFit.contain,
                          ),
                        ),

                        // Balance Label & Amount Bottom Right
                        Positioned(
                          bottom: 18.h,
                          right: 20.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                StaticString.balance,
                                style: GoogleFonts.jost(
                                  fontSize: 11.5.sp,
                                  color: Colors.white.withValues(alpha: 0.9),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    AppIcons.homePageCoinImg,
                                    width: 24.w,
                                    height: 24.h,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    card.amountText,
                                    style: GoogleFonts.jost(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Info Details Container Box
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F8FC),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      children: [
                        // Row 1: Card value
                        _buildInfoRow(
                          icon: Icons.credit_card_rounded,
                          title: StaticString.cardValue,
                          subtitle: null,
                          trailingText: '${card.amountText.replaceAll('MXN', '')} MXN',
                        ),
                        SizedBox(height: 16.h),

                        // Row 2: Card number
                        _buildCardNumberRow(),
                        SizedBox(height: 16.h),

                        // Row 3: Added on
                        _buildInfoRow(
                          icon: Icons.calendar_today_outlined,
                          title: StaticString.addedOn,
                          subtitle: StaticString.addedOnDate,
                          trailingText: null,
                        ),
                        SizedBox(height: 16.h),

                        // Row 4: Valid for
                        _buildInfoRow(
                          icon: Icons.calendar_month_outlined,
                          title: StaticString.validFor,
                          subtitle: StaticString.validForDesc,
                          trailingText: null,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Primary Button: "Add to Wallet"
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.toNamed(
                        AppRoute.reviewGiftCardScreen,
                        arguments: card,
                      ),
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
                            StaticString.addToWallet,
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

                  // Secondary Button: "View My Wallet"
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.snackbar(
                          'Wallet',
                          'Opening your Coffecito Wallet...',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF195ABE),
                          colorText: Colors.white,
                        );
                      },
                      child: Text(
                        StaticString.viewMyWallet,
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

  // ---------- INFO ITEM ROW WIDGET ----------
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String? subtitle,
    required String? trailingText,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF1E90FF),
          size: 20.r,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 12.5.sp,
                  color: const Color(0xFF888888),
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.jost(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF222222),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailingText != null)
          Text(
            trailingText,
            style: GoogleFonts.jost(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF195ABE),
            ),
          ),
      ],
    );
  }
}
