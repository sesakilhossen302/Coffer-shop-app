import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/gift_card_controller.dart';

class AddExistingGiftCardScreen extends StatelessWidget {
  const AddExistingGiftCardScreen({super.key});

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
                    StaticString.addGiftCardTitle,
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

          // Main Body Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.h),

                  // "Gift Card Number" Label
                  Text(
                    StaticString.giftCardNumberLabel,
                    style: GoogleFonts.jost(
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222222),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Gift Card Number Input Field
                  Container(
                    height: 52.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F8),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Center(
                      child: TextField(
                        controller: controller.cardNumberInputController,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.jost(
                          fontSize: 13.5.sp,
                          color: const Color(0xFF222222),
                        ),
                        decoration: InputDecoration(
                          hintText: StaticString.enterGiftCardNumber,
                          hintStyle: GoogleFonts.jost(
                            fontSize: 13.sp,
                            color: const Color(0xFF999999),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 36.h),

                  // Primary Button: "Add Existing Gift Card"
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.toNamed(
                        AppRoute.giftCardAddedScreen,
                        arguments: controller.giftCard.value,
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
                            StaticString.addExistingGiftCard,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
