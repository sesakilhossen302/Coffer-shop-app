import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/AppColors/app_colors.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../../Widgegt/CoffecitoMascot/coffecito_mascot.dart';
import '../../Widgegt/SocialLoginButton/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _inputController = TextEditingController();
  bool _isEmailMode = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _toggleLoginMode() {
    setState(() {
      _isEmailMode = !_isEmailMode;
      _inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),

              // Header Coffecito Mascot Illustration in Blue
              const Center(
                child: CoffecitoMascot(
                  width: 130,
                  height: 130,
                  isMini: true,
                  isBlueColor: true,
                ),
              ),

              SizedBox(height: 16.h),

              // "WELCOME!" Headline in #1E90FF Blue
              Text(
                StaticString.welcome,
                style: GoogleFonts.sora(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1E90FF),
                  letterSpacing: 1.0,
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle Mode Text ("Enter your number..." / "Enter your email...")
              Text(
                _isEmailMode
                    ? StaticString.enterEmailToContinue
                    : StaticString.enterNumberToContinue,
                style: GoogleFonts.sora(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E90FF),
                ),
              ),

              SizedBox(height: 28.h),

              // White Input Card Container
              Container(
                width: double.infinity,
                height: 52.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _inputController,
                  textAlign: TextAlign.center,
                  keyboardType: _isEmailMode
                      ? TextInputType.emailAddress
                      : TextInputType.phone,
                  style: GoogleFonts.sora(
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: _isEmailMode
                        ? StaticString.emailPlaceholder
                        : StaticString.phonePlaceholder,
                    hintStyle: GoogleFonts.sora(
                      fontSize: 14.sp,
                      color: const Color(0xFFA0A0A0),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // "Continue" Main Button in Dark Blue (#195ABE)
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle login submission logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF195ABE),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    StaticString.continueText,
                    style: GoogleFonts.sora(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 28.h),

              // Divider "or continue with"
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: Color(0xFFDCDCDC), thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      StaticString.orContinueWith,
                      style: GoogleFonts.sora(
                        fontSize: 12.sp,
                        color: const Color(0xFF888888),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Color(0xFFDCDCDC), thickness: 1),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Social Login Circular Buttons (Facebook, Google, Apple)
              const SocialLoginButtons(),

              SizedBox(height: 24.h),

              // Toggle Mode Button ("Use email" / "Use Phone Number")
              OutlinedButton(
                onPressed: _toggleLoginMode,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFCCCCCC), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                ),
                child: Text(
                  _isEmailMode
                      ? StaticString.usePhoneNumber
                      : StaticString.useEmail,
                  style: GoogleFonts.sora(
                    fontSize: 13.sp,
                    color: const Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 36.h),

              // Bottom Link: "Don't have an account? Sign Up"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${StaticString.dontHaveAccount} ',
                    style: GoogleFonts.sora(
                      fontSize: 13.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Sign Up screen
                    },
                    child: Text(
                      StaticString.signUp,
                      style: GoogleFonts.sora(
                        fontSize: 13.sp,
                        color: const Color(0xFF1E90FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
