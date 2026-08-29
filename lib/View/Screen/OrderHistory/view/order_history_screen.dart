import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/order_history_controller.dart';
import '../model/order_history_model.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderHistoryController controller =
        Get.isRegistered<OrderHistoryController>()
            ? Get.find<OrderHistoryController>()
            : Get.put(OrderHistoryController());

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
                    StaticString.orderHistoryTitle,
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

          SizedBox(height: 20.h),

          // Pixel-Perfect 2-Tab Segmented Switcher (Upcoming / Completed)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: 46.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFE5E9F0),
                  width: 1.2,
                ),
              ),
              child: Obx(
                () => Row(
                  children: [
                    _buildTabButton(
                      controller: controller,
                      index: 0,
                      title: StaticString.upcomingTab,
                      isLeft: true,
                    ),
                    _buildTabButton(
                      controller: controller,
                      index: 1,
                      title: StaticString.completedTab,
                      isLeft: false,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Main Body Content (Upcoming or Completed Orders List)
          Expanded(
            child: Obx(() {
              final List<OrderHistoryModel> currentList =
                  controller.selectedTab.value == 0
                      ? controller.upcomingOrders
                      : controller.completedOrders;

              if (currentList.isEmpty) {
                return Center(
                  child: Text(
                    'No orders in history',
                    style: GoogleFonts.jost(
                      fontSize: 14.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  return _buildOrderHistoryCard(currentList[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // ---------- TAB BUTTON WIDGET ----------
  Widget _buildTabButton({
    required OrderHistoryController controller,
    required int index,
    required String title,
    required bool isLeft,
  }) {
    final bool isSelected = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedTab.value = index,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E90FF) : Colors.transparent,
            borderRadius: isLeft
                ? BorderRadius.horizontal(left: Radius.circular(10.r))
                : BorderRadius.horizontal(right: Radius.circular(10.r)),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.jost(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF999999),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- ORDER HISTORY CARD WIDGET ----------
  Widget _buildOrderHistoryCard(OrderHistoryModel item) {
    final bool isPending = item.status == OrderStatus.pending;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
      padding: EdgeInsets.all(12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Thumbnail with +2 Badge
          SizedBox(
            width: 72.r,
            height: 72.r,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    item.imageUrl,
                    width: 68.r,
                    height: 68.r,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 68.r,
                      height: 68.r,
                      color: const Color(0xFFF5F6F8),
                      child: const Icon(
                        Icons.fastfood_rounded,
                        color: Color(0xFF195ABE),
                      ),
                    ),
                  ),
                ),

                // Bottom Right "+2" Overlay Badge
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF555555),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Text(
                      item.extraBadgeCount,
                      style: GoogleFonts.jost(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Title, Order #, Price Column
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
                SizedBox(height: 3.h),
                Text(
                  'Order ${item.orderId} • ${item.itemCount} items',
                  style: GoogleFonts.jost(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF888888),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  item.price,
                  style: GoogleFonts.jost(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Status Badge & View Details Button Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Status Badge (Pending / Completed)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPending
                      ? const Color(0xFFFFF4E5)
                      : const Color(0xFFE8F7ED),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  isPending
                      ? StaticString.pendingStatus
                      : StaticString.completedStatus,
                  style: GoogleFonts.jost(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: isPending
                        ? const Color(0xFFFF9500)
                        : const Color(0xFF34C759),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // View Details Outlined Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.toNamed(AppRoute.orderReceivedScreen),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    width: 90.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: const Color(0xFF195ABE),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        StaticString.viewDetailsBtn,
                        style: GoogleFonts.jost(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF195ABE),
                        ),
                      ),
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
}
