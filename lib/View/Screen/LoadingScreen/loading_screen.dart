import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/AppRoute/app_route.dart';
import '../../../Utils/AppColors/app_colors.dart';
import '../../Widgegt/CoffecitoMascot/coffecito_mascot.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Auto navigate from Loading screen to Splash/Onboarding screen after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      Get.offNamed(AppRoute.splashScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Center(
        child: CoffecitoMascot(
          width: 140,
          height: 140,
          isMini: true,
        ),
      ),
    );
  }
}
