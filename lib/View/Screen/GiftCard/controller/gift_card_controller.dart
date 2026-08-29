import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../Rewards/model/gift_card_model.dart';
import '../view/widgets/purchase_success_dialog.dart';

class GiftCardController extends GetxController {
  late Rx<GiftCardModel> giftCard;
  final RxInt selectedAmountIndex = 0.obs;
  final List<String> amounts = ['200MXN', '20MXN', '58MXN', '54MXN', 'Custom'];

  TextEditingController? _messageController;
  TextEditingController? _receiverNameController;
  TextEditingController? _receiverEmailController;
  TextEditingController? _cardNumberInputController;

  TextEditingController get messageController {
    try {
      _messageController ??= TextEditingController();
      _messageController!.text;
    } catch (_) {
      _messageController = TextEditingController();
    }
    return _messageController!;
  }

  TextEditingController get receiverNameController {
    try {
      _receiverNameController ??= TextEditingController();
      _receiverNameController!.text;
    } catch (_) {
      _receiverNameController = TextEditingController();
    }
    return _receiverNameController!;
  }

  TextEditingController get receiverEmailController {
    try {
      _receiverEmailController ??= TextEditingController();
      _receiverEmailController!.text;
    } catch (_) {
      _receiverEmailController = TextEditingController();
    }
    return _receiverEmailController!;
  }

  TextEditingController get cardNumberInputController {
    try {
      _cardNumberInputController ??= TextEditingController();
      _cardNumberInputController!.text;
    } catch (_) {
      _cardNumberInputController = TextEditingController();
    }
    return _cardNumberInputController!;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is GiftCardModel) {
      giftCard = args.obs;
    } else {
      giftCard = GiftCardModel(
        id: 'g1',
        title: 'COFFECITO',
        amountText: '400MXN',
        cardColor: const Color(0xFF195ABE),
        svgPath: 'assets/icons/ICON (14).svg',
      ).obs;
    }
  }

  String get selectedAmount => amounts[selectedAmountIndex.value];

  void selectAmount(int index) {
    selectedAmountIndex.value = index;
  }

  void payWithWallet(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PurchaseSuccessDialog(),
    );
  }

  void confirmAndAdd() {
    Get.toNamed(AppRoute.addedToWalletSuccessScreen);
  }
}
