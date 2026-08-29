import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/gift_card_controller.dart';

class PurchaseGiftCardScreen extends StatelessWidget {
  const PurchaseGiftCardScreen({super.key});

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
                    StaticString.purchaseGiftCardTitle,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Gift Card Amount Section
                  Text(
                    StaticString.giftCardAmountLabel,
                    style: GoogleFonts.jost(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222222),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Amount Chips Row
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          controller.amounts.length,
                          (index) {
                            final bool isSelected =
                                controller.selectedAmountIndex.value == index;
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: GestureDetector(
                                onTap: () => controller.selectAmount(index),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF195ABE)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF195ABE)
                                          : const Color(0xFFD5D5D5),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    controller.amounts[index],
                                    style: GoogleFonts.jost(
                                      fontSize: 12.5.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF555555),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Message Input Field (Optional)
                  Text(
                    StaticString.messageOptional,
                    style: GoogleFonts.jost(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222222),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F8),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          controller: controller.messageController,
                          maxLines: 3,
                          maxLength: 100,
                          style: GoogleFonts.jost(
                            fontSize: 13.sp,
                            color: const Color(0xFF222222),
                          ),
                          decoration: InputDecoration(
                            hintText: StaticString.messagePlaceholder,
                            hintStyle: GoogleFonts.jost(
                              fontSize: 12.5.sp,
                              color: const Color(0xFFAAAAAA),
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            counterText: '', // Custom counter placed below
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '0/100',
                          style: GoogleFonts.jost(
                            fontSize: 10.5.sp,
                            color: const Color(0xFFAAAAAA),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // To (Receiver Name) Input Field
                  Text(
                    StaticString.toReceiver,
                    style: GoogleFonts.jost(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222222),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F8),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    child: TextField(
                      controller: controller.receiverNameController,
                      style: GoogleFonts.jost(
                        fontSize: 13.sp,
                        color: const Color(0xFF222222),
                      ),
                      decoration: InputDecoration(
                        hintText: StaticString.toReceiverPlaceholder,
                        hintStyle: GoogleFonts.jost(
                          fontSize: 12.5.sp,
                          color: const Color(0xFFAAAAAA),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // Email Address Input Field
                  Text(
                    StaticString.emailAddressLabel,
                    style: GoogleFonts.jost(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222222),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F8),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    child: TextField(
                      controller: controller.receiverEmailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.jost(
                        fontSize: 13.sp,
                        color: const Color(0xFF222222),
                      ),
                      decoration: InputDecoration(
                        hintText: StaticString.emailAddressPlaceholder,
                        hintStyle: GoogleFonts.jost(
                          fontSize: 12.5.sp,
                          color: const Color(0xFFAAAAAA),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Payment Summary Container Box
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F8FC),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StaticString.paymentSummary,
                          style: GoogleFonts.jost(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF222222),
                          ),
                        ),
                        SizedBox(height: 14.h),

                        // Row 1: Gift card amount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StaticString.giftCardAmount,
                              style: GoogleFonts.jost(
                                fontSize: 12.5.sp,
                                color: const Color(0xFF888888),
                              ),
                            ),
                            Text(
                              '${card.amountText.replaceAll('MXN', '')} MXN',
                              style: GoogleFonts.jost(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF195ABE),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        // Row 2: Payment method
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StaticString.paymentMethod,
                              style: GoogleFonts.jost(
                                fontSize: 12.5.sp,
                                color: const Color(0xFF888888),
                              ),
                            ),
                            Text(
                              StaticString.inAppWallet,
                              style: GoogleFonts.jost(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF195ABE),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Primary Button: "Pay with Wallet"
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.payWithWallet(context),
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
                            StaticString.payWithWallet,
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
}
