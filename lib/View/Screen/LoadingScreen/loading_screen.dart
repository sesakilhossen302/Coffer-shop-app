import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Core/AppRoute/app_route.dart';
import '../../../Utils/AppColors/app_colors.dart';
import '../../../Utils/AppIcons/app_icons.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Auto navigate from Loading/Splash screen to Start Now screen after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      Get.offNamed(AppRoute.startNowScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Center(
        child: SvgPicture.asset(
          AppIcons.splashIcon,
          width: 140.w,
          height: 140.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
