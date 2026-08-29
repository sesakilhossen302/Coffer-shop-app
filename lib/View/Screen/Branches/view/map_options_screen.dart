import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';

class MapOptionsScreen extends StatelessWidget {
  const MapOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    StaticString.mapTitle,
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

          // Main Body Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 48.h),

                  // 3D Folded World Map SVG Illustration
                  SvgPicture.asset(
                    AppIcons.worldMapIconSvg,
                    width: 140.w,
                    height: 140.h,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 32.h),

                  // "Open this location in your preferred map app." Title
                  Text(
                    StaticString.openInPreferredMap,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222222),
                      height: 1.35,
                    ),
                  ),

                  SizedBox(height: 36.h),

                  // Button 1: "Open in Google Maps"
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.snackbar(
                          'Google Maps',
                          'Opening location in Google Maps...',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF195ABE),
                          colorText: Colors.white,
                        );
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFF195ABE),
                            width: 1.2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            StaticString.openInGoogleMaps,
                            style: GoogleFonts.jost(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF195ABE),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Button 2: "Open in Apple Maps"
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.snackbar(
                          'Apple Maps',
                          'Opening location in Apple Maps...',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF195ABE),
                          colorText: Colors.white,
                        );
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFF195ABE),
                            width: 1.2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            StaticString.openInAppleMaps,
                            style: GoogleFonts.jost(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF195ABE),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Button 3: "Cancel"
                  Center(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        StaticString.cancel,
                        style: GoogleFonts.jost(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
