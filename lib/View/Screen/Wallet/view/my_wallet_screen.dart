import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../controller/wallet_controller.dart';
import '../model/transaction_model.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.isRegistered<WalletController>()
        ? Get.find<WalletController>()
        : Get.put(WalletController());

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
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
                    StaticString.myWalletTitle,
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

          // Main Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Wallet Balance Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(18.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StaticString.walletBalance,
                              style: GoogleFonts.jost(
                                fontSize: 13.sp,
                                color: const Color(0xFF777777),
                              ),
                            ),
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              color: const Color(0xFF1E90FF),
                              size: 22.r,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Obx(
                          () => Text(
                            controller.walletBalance.value,
                            style: GoogleFonts.jost(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF222222),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // "Add Money" Outlined Button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () =>
                          Get.toNamed(AppRoute.addExistingGiftCardScreen),
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
                            StaticString.addMoney,
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

                  SizedBox(height: 24.h),

                  // Section Title: Recent Transactions
                  Text(
                    StaticString.recentTransactions,
                    style: GoogleFonts.jost(
                      fontSize: 16.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF195ABE),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Recent Transactions List
                  Obx(
                    () => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.transactions.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Color(0xFFF0F2F5),
                        height: 1,
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        return _buildTransactionItem(
                            controller.transactions[index]);
                      },
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

  // ---------- TRANSACTION ITEM ROW BUILDER ----------
  Widget _buildTransactionItem(TransactionModel item) {
    Widget iconWidget;
    Color iconBgColor;

    switch (item.type) {
      case TransactionType.addedMoney:
        iconBgColor = const Color(0xFF4CD964);
        iconWidget = Icon(
          Icons.add_circle_outline_rounded,
          color: Colors.white,
          size: 22.r,
        );
        break;
      case TransactionType.sentCard:
        iconBgColor = const Color(0xFFD32F2F);
        iconWidget = Icon(
          Icons.north_east_rounded,
          color: Colors.white,
          size: 22.r,
        );
        break;
      case TransactionType.giftCard:
      case TransactionType.order:
        iconBgColor = const Color(0xFF195ABE);
        iconWidget = SvgPicture.asset(
          AppIcons.shopIcon,
          width: 20.w,
          height: 20.h,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          // Transaction Icon Container
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(child: iconWidget),
          ),

          SizedBox(width: 14.w),

          // Title & Subtitle Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.jost(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF222222),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.subtitle,
                  style: GoogleFonts.jost(
                    fontSize: 12.sp,
                    color: const Color(0xFF777777),
                  ),
                ),
              ],
            ),
          ),

          // Amount & Date Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.amount,
                style: GoogleFonts.jost(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: item.isPositive
                      ? const Color(0xFF34C759)
                      : const Color(0xFFE53935),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                item.date,
                style: GoogleFonts.jost(
                  fontSize: 11.sp,
                  color: const Color(0xFF888888),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
