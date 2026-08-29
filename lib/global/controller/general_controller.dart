import 'package:get/get.dart';

class GeneralController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt selectedBottomNavIndex = 0.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void changeBottomNavIndex(int index) {
    selectedBottomNavIndex.value = index;
  }
}
