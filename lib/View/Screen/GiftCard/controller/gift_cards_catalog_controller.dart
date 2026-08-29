import 'package:get/get.dart';
import '../model/user_gift_card_model.dart';

class GiftCardsCatalogController extends GetxController {
  final RxInt selectedTab = 0.obs;

  final RxList<UserGiftCardModel> availableCards = <UserGiftCardModel>[
    UserGiftCardModel(
      id: 'c1',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      badgeType: 'Received',
    ),
    UserGiftCardModel(
      id: 'c2',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      badgeType: 'Purchased',
    ),
    UserGiftCardModel(
      id: 'c3',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      badgeType: 'Received',
    ),
  ].obs;

  final RxList<UserGiftCardModel> sentCards = <UserGiftCardModel>[
    UserGiftCardModel(
      id: 'c4',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      badgeType: 'Sent',
    ),
  ].obs;

  final RxList<UserGiftCardModel> redeemedCards = <UserGiftCardModel>[].obs;

  void selectTab(int index) {
    selectedTab.value = index;
  }
}
