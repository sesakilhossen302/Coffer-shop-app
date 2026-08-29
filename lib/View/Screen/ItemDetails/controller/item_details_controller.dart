import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../Home/model/product_model.dart';
import '../view/widgets/custom_info_dialog.dart';

class ItemDetailsController extends GetxController {
  final RxBool isFavorite = false.obs;
  final RxString selectedSize = 'S'.obs;
  final RxSet<String> selectedExtras = <String>{
    'Extra shot of espresso',
    'Almond milk',
  }.obs;

  final RxString productTitle = 'Iced Americano'.obs;
  final RxString productDescription =
      'Intense espresso served over ice, with a smooth, refreshing, and perfectly balanced taste.'.obs;
  final RxDouble basePrice = 30.00.obs;
  final RxString productImageUrl =
      'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80'.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is ProductModel) {
      productTitle.value = args.title;
      productDescription.value = args.description.isNotEmpty
          ? '${args.description}, with a smooth, refreshing, and perfectly balanced taste.'
          : 'Intense espresso served over ice, with a smooth, refreshing, and perfectly balanced taste.';
      basePrice.value = args.price;
      productImageUrl.value = args.imageUrl;
    }
  }

  double get totalPrice => basePrice.value;

  String get customizationSummary {
    if (selectedExtras.isEmpty) return 'Standard size (${selectedSize.value})';
    return selectedExtras.join(' + ');
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    if (isFavorite.value) {
      Get.dialog(
        CustomInfoDialog(
          title: StaticString.addedAsFav,
          message: StaticString.productAddedToFavMsg,
          onOkPressed: () => Get.back(),
        ),
      );
    }
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void toggleExtra(String extra) {
    if (selectedExtras.contains(extra)) {
      selectedExtras.remove(extra);
    } else {
      selectedExtras.add(extra);
    }
  }

  void addToCart() {
    Get.dialog(
      CustomInfoDialog(
        title: StaticString.addedToCart,
        message: StaticString.productAddedToCartMsg,
        onOkPressed: () => Get.back(),
      ),
    );
  }

  void orderNow() {
    Get.toNamed(
      AppRoute.orderSummaryScreen,
      arguments: {
        'title': productTitle.value,
        'customization': customizationSummary,
        'price': totalPrice,
        'imageUrl': productImageUrl.value,
      },
    );
  }
}
