import 'package:get/get.dart';
import '../../View/Screen/Branches/view/branch_search_location_screen.dart';
import '../../View/Screen/Branches/view/branches_screen.dart';
import '../../View/Screen/Branches/view/map_options_screen.dart';
import '../../View/Screen/Branches/view/shop_details_screen.dart';
import '../../View/Screen/Favorite/view/my_favorite_screen.dart';
import '../../View/Screen/GiftCard/view/add_existing_gift_card_screen.dart';
import '../../View/Screen/GiftCard/view/added_to_wallet_success_screen.dart';
import '../../View/Screen/GiftCard/view/gift_card_added_screen.dart';
import '../../View/Screen/GiftCard/view/gift_card_details_screen.dart';
import '../../View/Screen/GiftCard/view/gift_cards_catalog_screen.dart';
import '../../View/Screen/GiftCard/view/purchase_gift_card_screen.dart';
import '../../View/Screen/GiftCard/view/review_gift_card_screen.dart';
import '../../View/Screen/Home/view/home_screen.dart';
import '../../View/Screen/ItemDetails/view/item_details_screen.dart';
import '../../View/Screen/LoadingScreen/loading_screen.dart';
import '../../View/Screen/Login/view/login_screen.dart';
import '../../View/Screen/MakePayment/view/make_payment_screen.dart';
import '../../View/Screen/MyCart/view/my_cart_screen.dart';
import '../../View/Screen/Notification/view/notification_screen.dart';
import '../../View/Screen/OrderDetails/view/order_details_screen.dart';
import '../../View/Screen/OrderHistory/view/order_history_screen.dart';
import '../../View/Screen/OrderStatus/view/order_received_screen.dart';
import '../../View/Screen/OrderSummary/view/order_summary_screen.dart';
import '../../View/Screen/OtpVerification/view/otp_screen.dart';
import '../../View/Screen/Profile/view/delete_account_screen.dart';
import '../../View/Screen/Profile/view/edit_profile_screen.dart';
import '../../View/Screen/Profile/view/profile_screen.dart';
import '../../View/Screen/RewardDetails/view/reward_details_screen.dart';
import '../../View/Screen/RewardDetails/view/reward_redeemed_screen.dart';
import '../../View/Screen/Rewards/view/available_rewards_screen.dart';
import '../../View/Screen/Settings/view/privacy_policy_screen.dart';
import '../../View/Screen/Settings/view/terms_and_conditions_screen.dart';
import '../../View/Screen/SignUp/view/sign_up_screen.dart';
import '../../View/Screen/SplashScreen/start_now_screen.dart';
import '../../View/Screen/Wallet/view/my_wallet_screen.dart';

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
  static const String rewardRedeemedScreen = '/reward-redeemed';
  static const String availableRewardsScreen = '/available-rewards';
  static const String giftCardDetailsScreen = '/gift-card-details';
  static const String purchaseGiftCardScreen = '/purchase-gift-card';
  static const String addExistingGiftCardScreen = '/add-existing-gift-card';
  static const String giftCardAddedScreen = '/gift-card-added';
  static const String reviewGiftCardScreen = '/review-gift-card';
  static const String addedToWalletSuccessScreen = '/added-to-wallet-success';
  static const String giftCardsCatalogScreen = '/gift-cards-catalog';
  static const String branchesScreen = '/branches';
  static const String branchSearchLocationScreen = '/branch-search-location';
  static const String shopDetailsScreen = '/shop-details';
  static const String mapOptionsScreen = '/map-options';
  static const String profileScreen = '/profile';
  static const String editProfileScreen = '/edit-profile';
  static const String myWalletScreen = '/my-wallet';
  static const String myFavoriteScreen = '/my-favorite';
  static const String orderHistoryScreen = '/order-history';
  static const String orderDetailsScreen = '/order-details';
  static const String termsAndConditionsScreen = '/terms-and-conditions';
  static const String privacyPolicyScreen = '/privacy-policy';
  static const String deleteAccountScreen = '/delete-account';

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
    GetPage(
      name: rewardRedeemedScreen,
      page: () => const RewardRedeemedScreen(),
    ),
    GetPage(
      name: availableRewardsScreen,
      page: () => const AvailableRewardsScreen(),
    ),
    GetPage(
      name: giftCardDetailsScreen,
      page: () => const GiftCardDetailsScreen(),
    ),
    GetPage(
      name: purchaseGiftCardScreen,
      page: () => const PurchaseGiftCardScreen(),
    ),
    GetPage(
      name: addExistingGiftCardScreen,
      page: () => const AddExistingGiftCardScreen(),
    ),
    GetPage(
      name: giftCardAddedScreen,
      page: () => const GiftCardAddedScreen(),
    ),
    GetPage(
      name: reviewGiftCardScreen,
      page: () => const ReviewGiftCardScreen(),
    ),
    GetPage(
      name: addedToWalletSuccessScreen,
      page: () => const AddedToWalletSuccessScreen(),
    ),
    GetPage(
      name: giftCardsCatalogScreen,
      page: () => const GiftCardsCatalogScreen(),
    ),
    GetPage(
      name: branchesScreen,
      page: () => const BranchesScreen(),
    ),
    GetPage(
      name: branchSearchLocationScreen,
      page: () => const BranchSearchLocationScreen(),
    ),
    GetPage(
      name: shopDetailsScreen,
      page: () => const ShopDetailsScreen(),
    ),
    GetPage(
      name: mapOptionsScreen,
      page: () => const MapOptionsScreen(),
    ),
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: editProfileScreen,
      page: () => const EditProfileScreen(),
    ),
    GetPage(
      name: myWalletScreen,
      page: () => const MyWalletScreen(),
    ),
    GetPage(
      name: myFavoriteScreen,
      page: () => const MyFavoriteScreen(),
    ),
    GetPage(
      name: orderHistoryScreen,
      page: () => const OrderHistoryScreen(),
    ),
    GetPage(
      name: orderDetailsScreen,
      page: () => const OrderDetailsScreen(),
    ),
    GetPage(
      name: termsAndConditionsScreen,
      page: () => const TermsAndConditionsScreen(),
    ),
    GetPage(
      name: privacyPolicyScreen,
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: deleteAccountScreen,
      page: () => const DeleteAccountScreen(),
    ),
  ];
}
