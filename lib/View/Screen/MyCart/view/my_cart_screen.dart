import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/AppColors/app_colors.dart';
import '../../../../Utils/AppImg/app_img.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../../../helper/network_img/custom_netwrok_image.dart';
import '../controller/cart_controller.dart';
import '../model/cart_item_model.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
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
              left: 16.w,
              right: 16.w,
              top: statusBarHeight + 14.h,
              bottom: 20.h,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Text(
                    StaticString.myCart,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20.w), // Spacer for centering
              ],
            ),
          ),

          // Main Body Content
          Expanded(
            child: Obx(() {
              if (controller.cartItems.isEmpty) {
                return _buildEmptyCartState();
              }
              return _buildCartCheckoutView(controller);
            }),
          ),
        ],
      ),
    );
  }

  // ---------- ACTIVE CART CHECKOUT VIEW ----------
  Widget _buildCartCheckoutView(CartController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          // Cart Items List
          Obx(
            () => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.cartItems.length,
              separatorBuilder: (context, index) => SizedBox(height: 14.h),
              itemBuilder: (context, index) {
                final item = controller.cartItems[index];
                return _buildCartItemCard(item, index, controller);
              },
            ),
          ),

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
              SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: controller.applyDiscount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF195ABE),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                  ),
                  child: Text(
                    StaticString.apply,
                    style: GoogleFonts.jost(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
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
                        color: const Color(0xFF195ABE),
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
          SizedBox(
            width: double.infinity,
            height: 54.h,
            child: ElevatedButton(
              onPressed: controller.placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF195ABE),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                StaticString.placeOrder,
                style: GoogleFonts.jost(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ---------- CART ITEM CARD WIDGET ----------
  Widget _buildCartItemCard(
    CartItemModel item,
    int index,
    CartController controller,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(12.r),
      child: Row(
        children: [
          // Product Image
          CustomNetworkImage(
            imageUrl: item.imageUrl,
            width: 64.w,
            height: 64.h,
            borderRadius: 14.r,
          ),
          SizedBox(width: 14.w),

          // Title & Customization Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.jost(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E90FF),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.customization,
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

          // Quantity Selector & Price Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  // Decrement "-" Circular Button
                  GestureDetector(
                    onTap: () => controller.decrementQuantity(index),
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
                      '${item.quantity}',
                      style: GoogleFonts.jost(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF195ABE),
                      ),
                    ),
                  ),
                  // Increment "+" Circular Button
                  GestureDetector(
                    onTap: () => controller.incrementQuantity(index),
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
              SizedBox(height: 8.h),
              Text(
                '\$${item.totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.jost(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF195ABE),
                ),
              ),
            ],
          ),
        ],
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
                  width: isSelected ? 6.w : 1.5.w,
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

  // ---------- EMPTY CART STATE VIEW ----------
  Widget _buildEmptyCartState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Shopping Cart Illustration Image
          Image.asset(
            AppImg.myCartImg,
            width: 180.w,
            height: 180.h,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 140.w,
              height: 140.h,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F3FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: Color(0xFF1E90FF),
              ),
            ),
          ),

          SizedBox(height: 28.h),

          // "Your cart is empty" Title
          Text(
            StaticString.yourCartIsEmpty,
            textAlign: TextAlign.center,
            style: GoogleFonts.jost(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF222222),
            ),
          ),

          SizedBox(height: 8.h),

          // "Looks like you haven't added..." Subtitle
          Text(
            StaticString.looksLikeEmptyCart,
            textAlign: TextAlign.center,
            style: GoogleFonts.jost(
              fontSize: 13.sp,
              color: const Color(0xFF888888),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
