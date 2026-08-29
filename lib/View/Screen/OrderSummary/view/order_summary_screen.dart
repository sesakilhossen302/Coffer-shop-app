import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppColors/app_colors.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../../../helper/network_img/custom_netwrok_image.dart';
import '../controller/order_summary_controller.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderSummaryController controller = Get.isRegistered<OrderSummaryController>()
        ? Get.find<OrderSummaryController>()
        : Get.put(OrderSummaryController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Blue Header
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
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Get.back();
                      } else {
                        Get.offAllNamed(AppRoute.homeScreen);
                      }
                    },
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
                    StaticString.orderSummary,
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

          // Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  // Selected Item Summary Card
                  _buildSelectedItemCard(controller),

                  SizedBox(height: 20.h),

                  // Discount Code Apply Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F5F7),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: TextField(
                            controller: controller.discountCodeController,
                            style: GoogleFonts.jost(
                              fontSize: 14.sp,
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: StaticString.enterDiscountCode,
                              hintStyle: GoogleFonts.jost(
                                fontSize: 13.sp,
                                color: const Color(0xFFA0A0A0),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: controller.applyDiscount,
                          borderRadius: BorderRadius.circular(14.r),
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF195ABE),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Center(
                              child: Text(
                                StaticString.apply,
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
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Payment Summary Section
                  Text(
                    StaticString.paymentSummary,
                    style: GoogleFonts.jost(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E90FF),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(
                    () => Column(
                      children: [
                        _buildSummaryRow(
                          StaticString.subtotal,
                          '\$${controller.subtotal.toStringAsFixed(2)}',
                        ),
                        SizedBox(height: 8.h),
                        _buildSummaryRow(
                          StaticString.taxes,
                          '\$${controller.taxes.value.toStringAsFixed(2)}',
                        ),
                        SizedBox(height: 8.h),
                        _buildSummaryRow(
                          StaticString.discounts,
                          '\$${controller.discountAmount.value.toStringAsFixed(2)}',
                        ),
                        SizedBox(height: 12.h),
                        const Divider(color: Color(0xFFE5E5E5), thickness: 1),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StaticString.total,
                              style: GoogleFonts.jost(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF222222),
                              ),
                            ),
                            Text(
                              '\$${controller.grandTotal.toStringAsFixed(2)}',
                              style: GoogleFonts.jost(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF555555),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Payment Method Section
                  Text(
                    StaticString.paymentMethod,
                    style: GoogleFonts.jost(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E90FF),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(
                    () => Column(
                      children: [
                        _buildPaymentOption(
                          StaticString.cash,
                          controller.selectedPaymentMethod.value == StaticString.cash,
                          () => controller.selectPaymentMethod(StaticString.cash),
                        ),
                        _buildPaymentOption(
                          StaticString.cardMasked,
                          controller.selectedPaymentMethod.value == StaticString.cardMasked,
                          () => controller.selectPaymentMethod(StaticString.cardMasked),
                        ),
                        _buildPaymentOption(
                          StaticString.applePay,
                          controller.selectedPaymentMethod.value == StaticString.applePay,
                          () => controller.selectPaymentMethod(StaticString.applePay),
                          isDisabled: true,
                        ),
                        _buildPaymentOption(
                          StaticString.googlePay,
                          controller.selectedPaymentMethod.value == StaticString.googlePay,
                          () => controller.selectPaymentMethod(StaticString.googlePay),
                          isDisabled: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // "+ Add payment method" Link
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(Icons.add, size: 16, color: Color(0xFF888888)),
                        SizedBox(width: 6.w),
                        Text(
                          StaticString.addPaymentMethod,
                          style: GoogleFonts.jost(
                            fontSize: 13.sp,
                            color: const Color(0xFF888888),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // "Place order" Action Button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.placeOrder,
                      borderRadius: BorderRadius.circular(16.r),
                      child: Container(
                        width: double.infinity,
                        height: 54.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF195ABE),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child: Text(
                            StaticString.placeOrder,
                            style: GoogleFonts.jost(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- SELECTED ITEM SUMMARY CARD ----------
  Widget _buildSelectedItemCard(OrderSummaryController controller) {
    return Obx(
      () => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            CustomNetworkImage(
              imageUrl: controller.itemImageUrl.value,
              width: 64.w,
              height: 64.h,
              borderRadius: 14.r,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.itemTitle.value,
                    style: GoogleFonts.jost(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E90FF),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    controller.itemCustomization.value,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.jost(
                      fontSize: 11.sp,
                      color: const Color(0xFF888888),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Row(
              children: [
                GestureDetector(
                  onTap: controller.decrementQuantity,
                  child: Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFD0D7E2), width: 1),
                    ),
                    child: const Center(
                      child: Icon(Icons.remove, size: 14, color: Color(0xFF666666)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    '${controller.quantity.value}',
                    style: GoogleFonts.jost(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF195ABE),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: controller.incrementQuantity,
                  child: Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFD0D7E2), width: 1),
                    ),
                    child: const Center(
                      child: Icon(Icons.add, size: 14, color: Color(0xFF195ABE)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- PAYMENT SUMMARY ROW ----------
  Widget _buildSummaryRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.jost(
            fontSize: 13.sp,
            color: const Color(0xFF888888),
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.jost(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF444444),
          ),
        ),
      ],
    );
  }

  // ---------- PAYMENT METHOD RADIO OPTION ----------
  Widget _buildPaymentOption(
    String title,
    bool isSelected,
    VoidCallback onTap, {
    bool isDisabled = false,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF195ABE)
                      : (isDisabled ? const Color(0xFFCCCCCC) : const Color(0xFF999999)),
                  width: isSelected ? 4.w : 1.5.w,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: GoogleFonts.jost(
                fontSize: 14.sp,
                color: isDisabled
                    ? const Color(0xFFAAAAAA)
                    : (isSelected ? const Color(0xFF222222) : const Color(0xFF555555)),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
