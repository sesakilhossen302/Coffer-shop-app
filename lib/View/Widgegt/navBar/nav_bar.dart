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
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFE5E5E5),
            width: 1.h,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 64.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, 'Home', AppIcons.homeNavIcon),
              _buildNavItem(1, 'Order', AppIcons.orderNavIcon),
              _buildNavItem(2, 'Rewards', AppIcons.rewardsNavIcon),
              _buildNavItem(3, 'Branches', AppIcons.branchesNavIcon),
              _buildNavItem(4, 'Profile', AppIcons.profileNavIcon),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String svgPath) {
    final bool isSelected = currentIndex == index;
    final Color itemColor =
        isSelected ? const Color(0xFF195ABE) : const Color(0xFF757575);

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 25.w,
              height: 25.h,
              colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
            ),
            SizedBox(height: 5.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: itemColor,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
