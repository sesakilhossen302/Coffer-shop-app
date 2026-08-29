import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/notification_controller.dart';
import '../model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

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
                    StaticString.notification,
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

          // Main Content Body
          Expanded(
            child: Obx(() {
              if (controller.notifications.isEmpty) {
                return _buildEmptyState();
              }
              return _buildNotificationList(controller);
            }),
          ),
        ],
      ),
    );
  }

  // ---------- NOTIFICATIONS LIST VIEW ----------
  Widget _buildNotificationList(NotificationController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          // "Mark all as read" Action Link
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: controller.markAllAsRead,
              child: Text(
                StaticString.markAllAsRead,
                style: GoogleFonts.jost(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E90FF),
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Notification Cards List
          Expanded(
            child: ListView.separated(
              itemCount: controller.notifications.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final notification = controller.notifications[index];
                return _buildNotificationCard(notification, () {
                  controller.toggleReadState(index);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel item, VoidCallback onTap) {
    final bool isUnread = !item.isRead;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isUnread ? const Color(0xFFF0F7FF) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isUnread ? const Color(0xFFC5D9F8) : const Color(0xFFEEEEEE),
            width: 1.2,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circular Bell Icon Container
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: isUnread
                        ? const Color(0xFFD6E8FF)
                        : const Color(0xFFE9ECEF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: isUnread
                        ? const Color(0xFF1E90FF)
                        : const Color(0xFF888888),
                    size: 20,
                  ),
                ),
                SizedBox(width: 12.w),

                // Content Details
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
                      SizedBox(height: 2.h),
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jost(
                          fontSize: 12.sp,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w),

                // Time ago
                Text(
                  item.timeAgo,
                  style: GoogleFonts.jost(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
              ],
            ),

            // Small Blue Unread Dot on Top Right Corner
            if (isUnread)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E90FF),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ---------- EMPTY NOTIFICATIONS STATE VIEW ----------
  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Empty Bell Graphic Illustration
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 140.w,
                height: 140.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F3FF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.notifications_off_outlined,
                    size: 64.sp,
                    color: const Color(0xFF1E90FF),
                  ),
                ),
              ),
              Positioned(
                right: 10.w,
                top: 10.h,
                child: Container(
                  width: 32.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF90C2FE),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      '0',
                      style: GoogleFonts.jost(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 28.h),

          // "No notifications yet" Title
          Text(
            StaticString.noNotificationsYet,
            textAlign: TextAlign.center,
            style: GoogleFonts.jost(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF222222),
            ),
          ),

          SizedBox(height: 8.h),

          // "You're all caught up..." Subtitle
          Text(
            StaticString.caughtUpCheckBack,
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
