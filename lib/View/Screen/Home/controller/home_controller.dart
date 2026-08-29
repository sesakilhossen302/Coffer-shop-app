import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/offer_model.dart';
import '../model/product_model.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxInt selectedNavIndex = 0.obs;
  final RxInt notificationCount = 1.obs;
  final RxInt userPoints = 50.obs;

  final RxList<ProductModel> productList = <ProductModel>[
    ProductModel(
      id: '1',
      title: 'Iced Americano',
      description: 'Intense espresso served over ice.',
      price: 30.00,
      imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
    ),
    ProductModel(
      id: '2',
      title: 'Croissant',
      description: 'Handmade puff pastry, light and buttery.',
      price: 30.00,
      imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=500&q=80',
    ),
    ProductModel(
      id: '3',
      title: 'Iced Matcha Latte',
      description: 'Creamy matcha with cold milk.',
      price: 30.00,
      imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500&q=80',
    ),
    ProductModel(
      id: '4',
      title: 'Cookies',
      description: 'Freshly baked soft cookies.',
      price: 30.00,
      imageUrl: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=500&q=80',
    ),
  ].obs;

  final RxList<OfferModel> offerList = <OfferModel>[
    OfferModel(
      id: '1',
      title: '2x1 en bebidas frías',
      subtitle: 'COFFECITO',
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=600&q=80',
      backgroundColor: const Color(0xFFE8EEF5),
    ),
    OfferModel(
      id: '2',
      title: '30% OFF on Bakery',
      subtitle: 'Special Deal',
      imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600&q=80',
      backgroundColor: const Color(0xFFFFF3E0),
    ),
  ].obs;

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
