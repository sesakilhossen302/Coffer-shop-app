import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/StaticString/static_string.dart';
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

          // Scrollable Main Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Selected Product Card
                  _buildSelectedItemCard(controller),

                  SizedBox(height: 24.h),

                  // Discount Code Input & Apply Button Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F8FA),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: TextField(
                            controller: controller.discountCodeController,
                            style: GoogleFonts.jost(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF222222),
                            ),
                            decoration: InputDecoration(
                              hintText: StaticString.enterDiscountCode,
                              hintStyle: GoogleFonts.jost(
                                fontSize: 13.sp,
                                color: const Color(0xFF999999),
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14.h),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: controller.applyDiscount,
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF195ABE),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                StaticString.apply,
                                style: GoogleFonts.jost(
                                  fontSize: 14.5.sp,
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

                  SizedBox(height: 28.h),

                  // Payment Summary Section
                  Text(
                    StaticString.paymentSummary,
                    style: GoogleFonts.jost(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF195ABE),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  Obx(
                    () => Column(
                      children: [
                        _buildSummaryRow(
                          StaticString.subtotal,
                          '\$${controller.subtotal.toStringAsFixed(2)}',
                        ),
                        SizedBox(height: 10.h),
                        _buildSummaryRow(
                          StaticString.taxes,
                          '\$${controller.taxes.value.toStringAsFixed(2)}',
                        ),
                        SizedBox(height: 10.h),
                        _buildSummaryRow(
                          StaticString.discounts,
                          '\$${controller.discountAmount.value.toStringAsFixed(2)}',
                        ),
                        SizedBox(height: 14.h),
                        const Divider(
                            color: Color(0xFFF0F2F5), thickness: 1.2),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StaticString.total,
                              style: GoogleFonts.jost(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF222222),
                              ),
                            ),
                            Text(
                              '\$${controller.grandTotal.toStringAsFixed(2)}',
                              style: GoogleFonts.jost(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF222222),
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
                    StaticString.paymentMethodTitle,
                    style: GoogleFonts.jost(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF195ABE),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  Obx(
                    () => Column(
                      children: [
                        _buildPaymentOption(
                          StaticString.cash,
                          controller.selectedPaymentMethod.value ==
                              StaticString.cash,
                          () => controller
                              .selectPaymentMethod(StaticString.cash),
                        ),
                        _buildPaymentOption(
                          StaticString.cardMasked,
                          controller.selectedPaymentMethod.value ==
                              StaticString.cardMasked,
                          () => controller
                              .selectPaymentMethod(StaticString.cardMasked),
                        ),
                        _buildPaymentOption(
                          StaticString.applePay,
                          controller.selectedPaymentMethod.value ==
                              StaticString.applePay,
                          () => controller
                              .selectPaymentMethod(StaticString.applePay),
                        ),
                        _buildPaymentOption(
                          StaticString.googlePay,
                          controller.selectedPaymentMethod.value ==
                              StaticString.googlePay,
                          () => controller
                              .selectPaymentMethod(StaticString.googlePay),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // "+ Add payment method" Link
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.add, size: 16.r, color: const Color(0xFF777777)),
                        SizedBox(width: 6.w),
                        Text(
                          StaticString.addPaymentMethod,
                          style: GoogleFonts.jost(
                            fontSize: 12.5.sp,
                            color: const Color(0xFF777777),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 36.h),

                  // "Place order" Action Button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.placeOrder,
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
                            StaticString.placeOrder,
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

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- PRODUCT CARD WIDGET WITH COUNTER ----------
  Widget _buildSelectedItemCard(OrderSummaryController controller) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              controller.itemImageUrl.value,
              width: 64.r,
              height: 64.r,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 64.r,
                height: 64.r,
                color: const Color(0xFFF5F6F8),
                child: const Icon(
                  Icons.fastfood_rounded,
                  color: Color(0xFF195ABE),
                ),
              ),
            ),
          ),

          SizedBox(width: 14.w),

          // Title & Description Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.itemTitle.value,
                  style: GoogleFonts.jost(
                    fontSize: 15.5.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF195ABE),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  controller.itemCustomization.value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.jost(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF888888),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Quantity Increment/Decrement Controls (- 1 +)
          Row(
            children: [
              GestureDetector(
                onTap: controller.decrementQuantity,
                child: Container(
                  width: 28.r,
                  height: 28.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFDDDDDD),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      size: 15.r,
                      color: const Color(0xFF666666),
                    ),
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
                    color: const Color(0xFF222222),
                  ),
                ),
              ),
              GestureDetector(
                onTap: controller.incrementQuantity,
                child: Container(
                  width: 28.r,
                  height: 28.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFDDDDDD),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 15.r,
                      color: const Color(0xFF195ABE),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- PAYMENT SUMMARY ROW HELPER ----------
  Widget _buildSummaryRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.jost(
            fontSize: 13.5.sp,
            color: const Color(0xFF777777),
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.jost(
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  // ---------- PAYMENT OPTION RADIO ROW HELPER ----------
  Widget _buildPaymentOption(
      String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF195ABE)
                      : const Color(0xFFCCCCCC),
                  width: isSelected ? 6 : 1.5,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: GoogleFonts.jost(
                fontSize: 13.5.sp,
                color: isSelected
                    ? const Color(0xFF222222)
                    : const Color(0xFF888888),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
