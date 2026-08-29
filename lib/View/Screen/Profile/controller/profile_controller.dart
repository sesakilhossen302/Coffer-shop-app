import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../model/user_model.dart';

class ProfileController extends GetxController {
  final Rx<UserModel> currentUser = UserModel(
    id: 'u1',
    name: 'John Alex',
    email: 'alex@example.com',
    phone: '+52 9999 10 20 30',
    avatarUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&q=80',
  ).obs;

  void logout() {
    Get.defaultDialog(
      title: 'Log Out',
      middleText: 'Are you sure you want to log out of your account?',
      textConfirm: 'Log Out',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFFF3B30),
      cancelTextColor: const Color(0xFF777777),
      onConfirm: () {
        Get.back();
        Get.offAllNamed(AppRoute.loginScreen);
      },
    );
  }

  void deleteAccount() {
    Get.defaultDialog(
      title: 'Delete Account',
      middleText:
          'Are you sure you want to permanently delete your account? This action cannot be undone.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFFF3B30),
      cancelTextColor: const Color(0xFF777777),
      onConfirm: () {
        Get.back();
        Get.offAllNamed(AppRoute.startNowScreen);
      },
    );
  }
}
