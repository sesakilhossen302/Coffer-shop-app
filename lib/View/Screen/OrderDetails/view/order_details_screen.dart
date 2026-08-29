import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/AppImg/app_img.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/order_details_controller.dart';
import '../model/order_detail_item_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailsController controller =
        Get.isRegistered<OrderDetailsController>()
            ? Get.find<OrderDetailsController>()
            : Get.put(OrderDetailsController());

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
                    StaticString.orderDetailsTitle,
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
                  SizedBox(height: 20.h),

                  // Purchased Items List
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.orderItems.length,
                      itemBuilder: (context, index) {
                        return _buildOrderItemCard(
                          controller.orderItems[index],
                          controller,
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Section Title: Earned Reward
                  Text(
                    StaticString.earnedReward,
                    style: GoogleFonts.jost(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF195ABE),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Earned Reward Blue Banner Card
                  Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E90FF),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImg.coinImg,
                          width: 34.r,
                          height: 34.r,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.monetization_on_rounded,
                            color: Colors.amber,
                            size: 34.r,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${controller.rewardPoints.value} ',
                                style: GoogleFonts.jost(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: StaticString.pointsText,
                                style: GoogleFonts.jost(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          StaticString.totalReward,
                          style: GoogleFonts.jost(
                            fontSize: 12.5.sp,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Section Title: Order Information
                  Text(
                    StaticString.orderInformation,
                    style: GoogleFonts.jost(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222222),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Order Information Table Card
                  Obx(
                    () => Column(
                      children: [
                        // Row 1: Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StaticString.statusLabel,
                              style: GoogleFonts.jost(
                                fontSize: 13.sp,
                                color: const Color(0xFF777777),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 3.h),
                              decoration: BoxDecoration(
                                color: controller.status.value ==
                                        OrderDetailStatus.pending
                                    ? const Color(0xFFFFF4E5)
                                    : const Color(0xFFE8F7ED),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                controller.status.value ==
                                        OrderDetailStatus.pending
                                    ? StaticString.pendingStatus
                                    : StaticString.completedStatus,
                                style: GoogleFonts.jost(
                                  fontSize: 11.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: controller.status.value ==
                                          OrderDetailStatus.pending
                                      ? const Color(0xFFFF9500)
                                      : const Color(0xFF34C759),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        // Row 2: ID
                        _buildInfoRow(
                          StaticString.idLabel,
                          controller.orderId.value,
                        ),

                        SizedBox(height: 12.h),

                        // Row 3: Date
                        _buildInfoRow(
                          StaticString.dateLabel,
                          controller.date.value,
                        ),

                        SizedBox(height: 12.h),

                        // Row 4: Location
                        _buildInfoRow(
                          StaticString.locationLabel,
                          controller.location.value,
                        ),

                        SizedBox(height: 12.h),

                        // Row 5: Total Product Price
                        _buildInfoRow(
                          StaticString.totalProductPrice,
                          controller.totalPrice.value,
                        ),
                      ],
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

  // ---------- ORDER ITEM CARD WIDGET ----------
  Widget _buildOrderItemCard(
      OrderDetailItemModel item, OrderDetailsController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
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
          // Thumbnail Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              item.imageUrl,
              width: 54.r,
              height: 54.r,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 54.r,
                height: 54.r,
                color: const Color(0xFFF5F6F8),
                child: const Icon(
                  Icons.fastfood_rounded,
                  color: Color(0xFF195ABE),
                ),
              ),
            ),
          ),

          SizedBox(width: 14.w),

          // Title & Price/Qty Row Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.jost(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF222222),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      item.price,
                      style: GoogleFonts.jost(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // Qty: 1 Badge
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F3FF),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        '${StaticString.qtyPrefix}${item.quantity}',
                        style: GoogleFonts.jost(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E90FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Favorite Heart Outline Icon Button
          GestureDetector(
            onTap: () => controller.toggleFavorite(item),
            child: Padding(
              padding: EdgeInsets.all(6.r),
              child: Icon(
                item.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: item.isFavorite
                    ? const Color(0xFFE53935)
                    : const Color(0xFF999999),
                size: 22.r,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- INFORMATION ROW HELPER ----------
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.jost(
            fontSize: 13.sp,
            color: const Color(0xFF777777),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.jost(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF222222),
          ),
        ),
      ],
    );
  }
}
