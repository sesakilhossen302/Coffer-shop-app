import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/AppIcons/app_icons.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFEEEEEE),
            width: 1.w,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, 'Home', AppIcons.homeNavIcon),
          _buildNavItem(1, 'Order', AppIcons.orderNavIcon),
          _buildNavItem(2, 'Rewards', AppIcons.rewardsNavIcon),
          _buildNavItem(3, 'Branches', AppIcons.branchesNavIcon),
          _buildNavItem(4, 'Profile', AppIcons.profileNavIcon),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String svgPath) {
    final bool isSelected = currentIndex == index;
    final Color itemColor = isSelected ? const Color(0xFF1E90FF) : const Color(0xFF888888);

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.jost(
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: itemColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
