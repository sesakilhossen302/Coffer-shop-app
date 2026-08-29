import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/gift_cards_catalog_controller.dart';
import '../model/user_gift_card_model.dart';

class GiftCardsCatalogScreen extends StatelessWidget {
  const GiftCardsCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GiftCardsCatalogController controller =
        Get.isRegistered<GiftCardsCatalogController>()
            ? Get.find<GiftCardsCatalogController>()
            : Get.put(GiftCardsCatalogController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
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
                    StaticString.giftCardsTitle,
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

          // Main Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Summary Card (Total Available & Total Amount)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16.r),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StaticString.yourGiftCard,
                              style: GoogleFonts.jost(
                                fontSize: 12.sp,
                                color: const Color(0xFF777777),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              StaticString.totalGiftCardAvailable,
                              style: GoogleFonts.jost(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF222222),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              StaticString.totalAmountAvailable,
                              style: GoogleFonts.jost(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF195ABE),
                              ),
                            ),
                          ],
                        ),

                        // Gift Box Outline Icon Top Right
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Icon(
                            Icons.card_giftcard_rounded,
                            color: const Color(0xFF195ABE),
                            size: 24.r,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // 3-Tab Bar Switcher (Available, Sent, Redeemed)
                  Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F8),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.all(3.r),
                    child: Obx(
                      () => Row(
                        children: [
                          _buildTabItem(controller, 0, StaticString.available),
                          _buildTabItem(controller, 1, StaticString.sent),
                          _buildTabItem(controller, 2, StaticString.redeemed),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Gift Cards List Body
                  Obx(() {
                    final int activeTab = controller.selectedTab.value;
                    List<UserGiftCardModel> cardsList = [];
                    if (activeTab == 0) {
                      cardsList = controller.availableCards;
                    } else if (activeTab == 1) {
                      cardsList = controller.sentCards;
                    } else {
                      cardsList = controller.redeemedCards;
                    }

                    if (cardsList.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Center(
                          child: Text(
                            'No gift cards in this section.',
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              color: const Color(0xFF888888),
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cardsList.length,
                      itemBuilder: (context, index) {
                        return _buildGiftCardListItem(cardsList[index]);
                      },
                    );
                  }),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- TAB BUTTON ITEM WIDGET ----------
  Widget _buildTabItem(
      GiftCardsCatalogController controller, int index, String title) {
    final bool isSelected = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectTab(index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E90FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.jost(
                fontSize: 12.5.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : const Color(0xFF777777),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- GIFT CARD LIST ITEM WIDGET ----------
  Widget _buildGiftCardListItem(UserGiftCardModel card) {
    final bool isReceived = card.badgeType == 'Received';
    final bool isPurchased = card.badgeType == 'Purchased';
    final bool isSent = card.badgeType == 'Sent';
    final bool isRedeemed = card.badgeType == 'Redeemed';

    // Badge styling
    Color badgeBg = const Color(0xFFEBF3FF);
    Color badgeTextColor = const Color(0xFF195ABE);

    if (isPurchased) {
      badgeBg = const Color(0xFFFFF8E7);
      badgeTextColor = const Color(0xFFD98A00);
    } else if (isSent) {
      badgeBg = const Color(0xFFF2F4F7);
      badgeTextColor = const Color(0xFF777777);
    } else if (isRedeemed) {
      badgeBg = const Color(0xFFE8F7ED);
      badgeTextColor = const Color(0xFF34C759);
    }

    // Top title text
    String topTitle = card.senderName;
    if (isSent) {
      topTitle = 'To: ${card.email}';
    }

    // Subtitle text (Middle row)
    String subtitleText = card.email;
    if (isSent || isRedeemed) {
      subtitleText = card.dateText;
    }

    // Amount text color
    Color amountColor = const Color(0xFF222222);
    if (isRedeemed) {
      amountColor = const Color(0xFFE53935);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.r),
      child: Row(
        children: [
          // Left Blue Mini Gift Card Banner Thumbnail
          Container(
            width: 100.w,
            height: 68.h,
            decoration: BoxDecoration(
              color: card.cardColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                // Mini Logo Top Center
                Positioned(
                  left: 8.w,
                  top: 8.h,
                  child: SvgPicture.asset(
                    AppIcons.coffecitoLogoSvg,
                    height: 14.h,
                    fit: BoxFit.contain,
                  ),
                ),
                // Mini Running Cup Bottom Left
                Positioned(
                  left: 8.w,
                  bottom: 6.h,
                  child: SvgPicture.asset(
                    AppIcons.rewardIcon14Svg,
                    height: 32.h,
                    fit: BoxFit.contain,
                  ),
                ),
                // Mini Coin + Amount Bottom Right
                Positioned(
                  bottom: 6.h,
                  right: 6.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppIcons.homePageCoinImg,
                        width: 12.w,
                        height: 12.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        card.amountText.replaceAll(' ', ''),
                        style: GoogleFonts.jost(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Right Card Information & Action
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Sender / Recipient Title + Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        topTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jost(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF222222),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        card.badgeType,
                        style: GoogleFonts.jost(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: badgeTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                // Middle Row: Subtitle (Email / Date)
                Text(
                  subtitleText,
                  style: GoogleFonts.jost(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF888888),
                  ),
                ),

                SizedBox(height: 8.h),

                // Bottom Row: Amount & Optional "Redeem Now" Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card.amountText,
                      style: GoogleFonts.jost(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.bold,
                        color: amountColor,
                      ),
                    ),

                    // Show "Redeem Now" button ONLY for Available tab items
                    if (isReceived || isPurchased)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.snackbar(
                              'Redeem Gift Card',
                              'Redeeming ${card.amountText} gift card...',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: const Color(0xFF195ABE),
                              colorText: Colors.white,
                            );
                          },
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF195ABE),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              StaticString.redeemNow,
                              style: GoogleFonts.jost(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
