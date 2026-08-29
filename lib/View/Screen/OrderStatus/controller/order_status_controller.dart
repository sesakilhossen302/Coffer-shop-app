import 'package:get/get.dart';

class OrderStatusController extends GetxController {
  final RxInt currentProgressStep = 1.obs; // 0: Placed, 1: Preparing, 2: Ready

  void setProgressStep(int step) {
    currentProgressStep.value = step;
  }
}
