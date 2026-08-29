import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Utils/AppColors/app_colors.dart';
import '../../../Utils/AppIcons/app_icons.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback? onFacebookTap;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  const SocialLoginButtons({
    super.key,
    this.onFacebookTap,
    this.onGoogleTap,
    this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialCircleButton(
          iconPath: AppIcons.facebookIcon,
          onTap: onFacebookTap,
        ),
        SizedBox(width: 20.w),
        _buildSocialCircleButton(
          iconPath: AppIcons.googleIcon,
          onTap: onGoogleTap,
        ),
        SizedBox(width: 20.w),
        _buildSocialCircleButton(
          iconPath: AppIcons.appleIcon,
          onTap: onAppleTap,
        ),
      ],
    );
  }

  Widget _buildSocialCircleButton({
    required String iconPath,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 1.2,
          ),
        ),
        padding: EdgeInsets.all(12.r),
        child: SvgPicture.asset(
          iconPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
