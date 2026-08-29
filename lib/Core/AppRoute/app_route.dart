import 'package:get/get.dart';
import '../../View/Screen/LoadingScreen/loading_screen.dart';
import '../../View/Screen/SplashScreen/splash_screen.dart';

class AppRoute {
  static const String loadingScreen = '/loading';
  static const String splashScreen = '/splash';
  static const String homeScreen = '/home';

  static List<GetPage> routes = [
    GetPage(
      name: loadingScreen,
      page: () => const LoadingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
