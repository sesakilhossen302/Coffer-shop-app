import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
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
                    StaticString.editProfileTitle,
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

          // Main Body Content Form
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 36.h),

                  // Avatar Image with Camera Badge Button
                  Center(
                    child: SizedBox(
                      width: 106.r,
                      height: 106.r,
                      child: Stack(
                        children: [
                          // Circular Avatar
                          Obx(
                            () => Container(
                              width: 100.r,
                              height: 100.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFE5EBF2),
                                border: Border.all(
                                  color: const Color(0xFFE5E9F0),
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  controller.currentUser.value.avatarUrl,
                                  width: 100.r,
                                  height: 100.r,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.person_rounded,
                                    size: 54,
                                    color: Color(0xFF1E90FF),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Camera Badge Button
                          Positioned(
                            right: 0,
                            bottom: 4.h,
                            child: GestureDetector(
                              onTap: () {
                                Get.snackbar(
                                  'Change Photo',
                                  'Opening gallery to select avatar picture...',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: const Color(0xFF195ABE),
                                  colorText: Colors.white,
                                );
                              },
                              child: Container(
                                width: 32.r,
                                height: 32.r,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFDDDDDD),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 17.r,
                                  color: const Color(0xFF444444),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 36.h),

                  // Input Field 1: Full Name
                  _buildInputField(
                    controller: controller.nameController,
                    hintText: StaticString.fullName,
                  ),

                  SizedBox(height: 16.h),

                  // Input Field 2: Email
                  _buildInputField(
                    controller: controller.emailController,
                    hintText: StaticString.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 16.h),

                  // Input Field 3: Date of Birth with Calendar Icon
                  _buildInputField(
                    controller: controller.dobController,
                    hintText: StaticString.dobPlaceholder,
                    readOnly: true,
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: const Color(0xFF777777),
                      size: 19.r,
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2024, 3, 18),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        controller.dobController.text =
                            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                      }
                    },
                  ),

                  SizedBox(height: 44.h),

                  // Primary Button: "Update now"
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.updateProfile(context),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF195ABE),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            StaticString.updateNow,
                            style: GoogleFonts.jost(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- INPUT FIELD HELPER WIDGET ----------
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    Widget? suffixIcon,
    VoidCallback? onTap,
  }) {
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              readOnly: readOnly,
              onTap: onTap,
              style: GoogleFonts.jost(
                fontSize: 13.5.sp,
                color: const Color(0xFF222222),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.jost(
                  fontSize: 13.sp,
                  color: const Color(0xFF999999),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (suffixIcon != null) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onTap,
              child: suffixIcon,
            ),
          ],
        ],
      ),
    );
  }
}
