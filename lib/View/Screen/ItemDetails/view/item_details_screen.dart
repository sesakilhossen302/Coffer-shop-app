import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../../../helper/network_img/custom_netwrok_image.dart';
import '../controller/item_details_controller.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemDetailsController controller = Get.isRegistered<ItemDetailsController>()
        ? Get.find<ItemDetailsController>()
        : Get.put(ItemDetailsController());

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
                    StaticString.itemDetails,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: controller.toggleFavorite,
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Icon(
                        controller.isFavorite.value
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: controller.isFavorite.value
                            ? const Color(0xFFFF3B30)
                            : Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
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
                  SizedBox(height: 14.h),

                  // Compact Hero Product Image
                  Obx(
                    () => CustomNetworkImage(
                      imageUrl: controller.productImageUrl.value,
                      width: double.infinity,
                      height: 165.h,
                      borderRadius: 16.r,
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Title & Description
                  Obx(
                    () => Text(
                      controller.productTitle.value,
                      style: GoogleFonts.jost(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E90FF),
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Obx(
                    () => Text(
                      controller.productDescription.value,
                      style: GoogleFonts.jost(
                        fontSize: 11.5.sp,
                        color: const Color(0xFF888888),
                        height: 1.3,
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),
                  const Divider(color: Color(0xFFF2F4F7), thickness: 1),
                  SizedBox(height: 14.h),

                  // Size Selection Section
                  Text(
                    StaticString.size,
                    style: GoogleFonts.jost(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E90FF),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => Row(
                      children: [
                        _buildSizeOption('S', controller),
                        SizedBox(width: 12.w),
                        _buildSizeOption('M', controller),
                        SizedBox(width: 12.w),
                        _buildSizeOption('L', controller),
                      ],
                    ),
                  ),

                  SizedBox(height: 14.h),
                  const Divider(color: Color(0xFFF2F4F7), thickness: 1),
                  SizedBox(height: 14.h),

                  // Extras (Optional) Section
                  Text(
                    StaticString.extrasOptional,
                    style: GoogleFonts.jost(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E90FF),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => Column(
                      children: [
                        _buildExtraItem(StaticString.extraEspresso, controller),
                        _buildExtraItem(StaticString.almondMilk, controller),
                        _buildExtraItem(StaticString.vanillaSyrup, controller),
                        _buildExtraItem(StaticString.candy, controller),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),
                  const Divider(color: Color(0xFFF2F4F7), thickness: 1),
                  SizedBox(height: 16.h),

                  // Bottom Total & Action Buttons Row
                  Row(
                    children: [
                      // Total Price Display
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL',
                            style: GoogleFonts.jost(
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF888888),
                            ),
                          ),
                          Obx(
                            () => Text(
                              '\$${controller.totalPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.jost(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF195ABE),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),

                      // Action Buttons (Add to Cart & Order Now)
                      Expanded(
                        child: Row(
                          children: [
                            // Add to Cart Outlined Button
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: controller.addToCart,
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Container(
                                    height: 44.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: const Color(0xFFD0D7E2),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        StaticString.addToCart,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.jost(
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF555555),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),

                            // Order Now Filled Blue Button
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: controller.orderNow,
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Container(
                                    height: 44.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF195ABE),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        StaticString.orderNow,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.jost(
                                          fontSize: 13.5.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

  // ---------- SIZE OPTION CARD WIDGET ----------
  Widget _buildSizeOption(String size, ItemDetailsController controller) {
    final bool isSelected = controller.selectedSize.value == size;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectSize(size),
        child: Container(
          height: 38.h,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF195ABE) : const Color(0xFFF4F5F7),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              size,
              style: GoogleFonts.jost(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF666666),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- EXTRA OPTION ROW WIDGET ----------
  Widget _buildExtraItem(String title, ItemDetailsController controller) {
    final bool isSelected = controller.selectedExtras.contains(title);

    return GestureDetector(
      onTap: () => controller.toggleExtra(title),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            // Custom Radio Check Indicator
            Container(
              width: 18.w,
              height: 18.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF195ABE) : const Color(0xFFCCCCCC),
                  width: isSelected ? 5.w : 1.5.w,
                ),
              ),
            ),
            SizedBox(width: 10.w),

            // Extra Title Text
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 12.5.sp,
                  color: isSelected ? const Color(0xFF222222) : const Color(0xFF777777),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),

            // Price Add-on Text (+ $15)
            Text(
              '+ \$15',
              style: GoogleFonts.jost(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF195ABE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
