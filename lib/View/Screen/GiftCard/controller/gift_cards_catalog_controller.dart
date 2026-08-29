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
      dateText: '24 May, 2026',
      badgeType: 'Received',
    ),
    UserGiftCardModel(
      id: 'c2',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Purchased',
    ),
    UserGiftCardModel(
      id: 'c3',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Received',
    ),
  ].obs;

  final RxList<UserGiftCardModel> sentCards = <UserGiftCardModel>[
    UserGiftCardModel(
      id: 's1',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Sent',
    ),
    UserGiftCardModel(
      id: 's2',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Sent',
    ),
    UserGiftCardModel(
      id: 's3',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Sent',
    ),
    UserGiftCardModel(
      id: 's4',
      senderName: 'John Alice',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Sent',
    ),
  ].obs;

  final RxList<UserGiftCardModel> redeemedCards = <UserGiftCardModel>[
    UserGiftCardModel(
      id: 'r1',
      senderName: 'Max colla',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Redeemed',
    ),
    UserGiftCardModel(
      id: 'r2',
      senderName: 'Max colla',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Redeemed',
    ),
    UserGiftCardModel(
      id: 'r3',
      senderName: 'Max colla',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Redeemed',
    ),
    UserGiftCardModel(
      id: 'r4',
      senderName: 'Max colla',
      email: 'alice@example.com',
      amountText: '400 MXN',
      dateText: '24 May, 2026',
      badgeType: 'Redeemed',
    ),
  ].obs;

  void selectTab(int index) {
    selectedTab.value = index;
  }
}
