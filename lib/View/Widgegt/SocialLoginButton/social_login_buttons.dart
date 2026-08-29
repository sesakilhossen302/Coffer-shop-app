import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/AppColors/app_colors.dart';

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
          icon: const Icon(
            Icons.facebook,
            color: Color(0xFF1877F2),
            size: 24,
          ),
          onTap: onFacebookTap,
        ),
        SizedBox(width: 20.w),
        _buildSocialCircleButton(
          child: Text(
            'G',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFEA4335),
            ),
          ),
          onTap: onGoogleTap,
        ),
        SizedBox(width: 20.w),
        _buildSocialCircleButton(
          icon: const Icon(
            Icons.apple,
            color: Colors.black,
            size: 24,
          ),
          onTap: onAppleTap,
        ),
      ],
    );
  }

  Widget _buildSocialCircleButton({
    Widget? icon,
    Widget? child,
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
        child: Center(child: icon ?? child),
      ),
    );
  }
}
