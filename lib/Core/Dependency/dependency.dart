import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../global/controller/general_controller.dart';
import '../../helper/network_info/network_info.dart';
import '../../helper/shared_prefe/shared_preferences_helper.dart';
import '../../service/api_client.dart';
import '../../service/socket_service.dart';

class DependencyInjection {
  static Future<void> init() async {
    // Core External Dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences, fenix: true);
    Get.lazyPut(() => SharedPreferencesHelper(prefs: Get.find()), fenix: true);

    // Network & API Services
    Get.lazyPut(() => Connectivity(), fenix: true);
    Get.lazyPut(() => NetworkInfo(Get.find()), fenix: true);
    Get.lazyPut(() => ApiClient(sharedPreferencesHelper: Get.find()), fenix: true);
    Get.lazyPut(() => SocketService(), fenix: true);

    // Global Controllers
    Get.lazyPut(() => GeneralController(), fenix: true);
  }
}
