import 'package:get/get.dart';
import '../../Branches/model/branch_model.dart';
import '../../Home/model/product_model.dart';

class FavoriteController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0: Shop, 1: Item

  final RxList<BranchModel> favoriteShops = <BranchModel>[].obs;
  final RxList<ProductModel> favoriteItems = <ProductModel>[].obs;
}
