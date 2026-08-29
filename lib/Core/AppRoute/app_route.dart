import 'package:get/get.dart';
import '../../View/Screen/Home/view/home_screen.dart';
import '../../View/Screen/ItemDetails/view/item_details_screen.dart';
import '../../View/Screen/LoadingScreen/loading_screen.dart';
import '../../View/Screen/Login/view/login_screen.dart';
import '../../View/Screen/MakePayment/view/make_payment_screen.dart';
import '../../View/Screen/MyCart/view/my_cart_screen.dart';
import '../../View/Screen/Notification/view/notification_screen.dart';
import '../../View/Screen/OrderStatus/view/order_received_screen.dart';
import '../../View/Screen/OrderSummary/view/order_summary_screen.dart';
import '../../View/Screen/OtpVerification/view/otp_screen.dart';
import '../../View/Screen/RewardDetails/view/reward_details_screen.dart';
import '../../View/Screen/SignUp/view/sign_up_screen.dart';
import '../../View/Screen/SplashScreen/start_now_screen.dart';

class AppRoute {
  static const String loadingScreen = '/loading';
  static const String startNowScreen = '/start-now';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/sign-up';
  static const String otpScreen = '/otp-verification';
  static const String homeScreen = '/home';
  static const String notificationScreen = '/notification';
  static const String myCartScreen = '/my-cart';
  static const String itemDetailsScreen = '/item-details';
  static const String orderSummaryScreen = '/order-summary';
  static const String makePaymentScreen = '/make-payment';
  static const String orderReceivedScreen = '/order-received';
  static const String rewardDetailsScreen = '/reward-details';

  static List<GetPage> routes = [
    GetPage(
      name: loadingScreen,
      page: () => const LoadingScreen(),
    ),
    GetPage(
      name: startNowScreen,
      page: () => const StartNowScreen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: otpScreen,
      page: () => const OtpScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: myCartScreen,
      page: () => const MyCartScreen(),
    ),
    GetPage(
      name: itemDetailsScreen,
      page: () => const ItemDetailsScreen(),
    ),
    GetPage(
      name: orderSummaryScreen,
      page: () => const OrderSummaryScreen(),
    ),
    GetPage(
      name: makePaymentScreen,
      page: () => const MakePaymentScreen(),
    ),
    GetPage(
      name: orderReceivedScreen,
      page: () => const OrderReceivedScreen(),
    ),
    GetPage(
      name: rewardDetailsScreen,
      page: () => const RewardDetailsScreen(),
    ),
  ];
}
