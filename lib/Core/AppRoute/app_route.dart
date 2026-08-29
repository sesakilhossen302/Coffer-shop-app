import 'package:get/get.dart';
import '../../View/Screen/LoadingScreen/loading_screen.dart';
import '../../View/Screen/Login/view/login_screen.dart';
import '../../View/Screen/SplashScreen/start_now_screen.dart';

class AppRoute {
  static const String loadingScreen = '/loading';
  static const String startNowScreen = '/start-now';
  static const String loginScreen = '/login';
  static const String homeScreen = '/home';

  static List<GetPage> routes = [
    GetPage(
      name: loadingScreen,
      page: () => const LoadingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: startNowScreen,
      page: () => const StartNowScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
