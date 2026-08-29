import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../Home/model/product_model.dart';

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
    Get.snackbar(
      'Added to Cart',
      '${productTitle.value} ($customizationSummary) added to cart!',
      snackPosition: SnackPosition.BOTTOM,
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
