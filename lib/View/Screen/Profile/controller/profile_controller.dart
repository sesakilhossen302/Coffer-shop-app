import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../model/user_model.dart';
import '../view/widgets/edit_profile_success_dialog.dart';

class ProfileController extends GetxController {
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _dobController;

  final Rx<UserModel> currentUser = UserModel(
    id: 'u1',
    name: 'John Alex',
    email: 'alex@example.com',
    phone: '+52 9999 10 20 30',
    avatarUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&q=80',
  ).obs;

  TextEditingController get nameController {
    try {
      _nameController ??= TextEditingController(text: currentUser.value.name);
    } catch (_) {
      _nameController = TextEditingController(text: currentUser.value.name);
    }
    return _nameController!;
  }

  TextEditingController get emailController {
    try {
      _emailController ??= TextEditingController(text: currentUser.value.email);
    } catch (_) {
      _emailController = TextEditingController(text: currentUser.value.email);
    }
    return _emailController!;
  }

  TextEditingController get dobController {
    try {
      _dobController ??= TextEditingController(text: '18/03/2024');
    } catch (_) {
      _dobController = TextEditingController(text: '18/03/2024');
    }
    return _dobController!;
  }

  void updateProfile(BuildContext context) {
    if (nameController.text.trim().isNotEmpty) {
      currentUser.update((user) {
        if (user != null) {
          currentUser.value = UserModel(
            id: user.id,
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            phone: user.phone,
            avatarUrl: user.avatarUrl,
          );
        }
      });
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const EditProfileSuccessDialog(),
    );
  }

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
