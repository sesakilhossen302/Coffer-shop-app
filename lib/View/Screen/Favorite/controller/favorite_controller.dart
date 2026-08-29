import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Branches/model/branch_model.dart';
import '../../Home/model/product_model.dart';

class FavoriteController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0: Shop, 1: Item

  final RxList<BranchModel> favoriteShops = <BranchModel>[
    BranchModel(
      id: 'fs1',
      name: 'Starbucks',
      address: '17 Motijheel C/A, Dhaka 1000',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl:
          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: true,
      isFavorite: true,
    ),
    BranchModel(
      id: 'fs2',
      name: 'Starbucks',
      address: '17 Motijheel C/A, Dhaka 1000',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl:
          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: false,
      isFavorite: true,
    ),
    BranchModel(
      id: 'fs3',
      name: 'Starbucks',
      address: '17 Motijheel C/A, Dhaka 1000',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl:
          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: false,
      isFavorite: true,
    ),
    BranchModel(
      id: 'fs4',
      name: 'Starbucks',
      address: '17 Motijheel C/A, Dhaka 1000',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl:
          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: false,
      isFavorite: true,
    ),
  ].obs;

  final RxList<ProductModel> favoriteItems = <ProductModel>[
    ProductModel(
      id: 'fi1',
      title: 'Garlic Bread',
      description: 'Toasted bread with buttery garlic....',
      price: 30.0,
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
    ),
    ProductModel(
      id: 'fi2',
      title: 'Garlic Bread',
      description: 'Toasted bread with buttery garlic....',
      price: 30.0,
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
    ),
    ProductModel(
      id: 'fi3',
      title: 'Garlic Bread',
      description: 'Toasted bread with buttery garlic....',
      price: 30.0,
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
    ),
    ProductModel(
      id: 'fi4',
      title: 'Garlic Bread',
      description: 'Toasted bread with buttery garlic....',
      price: 30.0,
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
    ),
  ].obs;

  void toggleFavoriteShop(BranchModel shop) {
    if (favoriteShops.contains(shop)) {
      favoriteShops.remove(shop);
      Get.snackbar(
        'Removed from Favorites',
        '${shop.name} has been removed from your favorite shops.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF195ABE),
        colorText: Colors.white,
      );
    } else {
      favoriteShops.add(shop);
    }
  }

  void removeFavoriteItem(ProductModel item) {
    favoriteItems.remove(item);
    Get.snackbar(
      'Removed from Favorites',
      '${item.title} has been removed from your favorite items.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF195ABE),
      colorText: Colors.white,
    );
  }
}
