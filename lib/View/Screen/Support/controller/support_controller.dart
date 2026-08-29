import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/widgets/support_success_dialog.dart';

class SupportController extends GetxController {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _feedbackController = TextEditingController();

  TextEditingController get subjectController {
    try {
      final _ = _subjectController.text;
    } catch (_) {
      _subjectController = TextEditingController();
    }
    return _subjectController;
  }

  TextEditingController get feedbackController {
    try {
      final _ = _feedbackController.text;
    } catch (_) {
      _feedbackController = TextEditingController();
    }
    return _feedbackController;
  }

  final RxInt charCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    feedbackController.addListener(() {
      charCount.value = feedbackController.text.length;
    });
  }

  void submitFeedback(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const SupportSuccessDialog(),
    );
  }
}
