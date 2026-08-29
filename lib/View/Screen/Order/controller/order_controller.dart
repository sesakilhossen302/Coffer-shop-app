import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../Home/model/product_model.dart';
import '../model/category_model.dart';

class OrderController extends GetxController {
  TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController {
    try {
      final _ = _searchController.text;
    } catch (_) {
      _searchController = TextEditingController(text: searchQuery.value);
    }
    return _searchController;
  }

  final RxString searchQuery = ''.obs;
  final RxInt selectedCategoryIndex = 0.obs;

  final RxList<CategoryModel> categories = <CategoryModel>[
    CategoryModel(id: '1', name: 'Hot drinks', icon: AppIcons.hotDrinksIcon),
    CategoryModel(id: '2', name: 'Cold drinks', icon: AppIcons.coldDrinksIcon),
    CategoryModel(id: '3', name: 'Bakery', icon: AppIcons.bakeryIcon),
    CategoryModel(id: '4', name: 'Snacks', icon: AppIcons.snacksIcon),
  ].obs;

  final RxMap<int, List<ProductModel>> categoryProducts = <int, List<ProductModel>>{
    // 0: Hot drinks
    0: [
      ProductModel(
        id: 'h1',
        title: 'Americano',
        description: 'Intense espresso served over hot water.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500&q=80',
      ),
      ProductModel(
        id: 'h2',
        title: 'Espresso',
        description: 'Smooth espresso with milk and hot chocolate.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=500&q=80',
      ),
      ProductModel(
        id: 'h3',
        title: 'Matcha Latte',
        description: 'Creamy matcha with hot milk.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500&q=80',
      ),
      ProductModel(
        id: 'h4',
        title: 'Latte Chai',
        description: 'Smooth hot brew with citrus notes.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?w=500&q=80',
      ),
    ],

    // 1: Cold drinks
    1: [
      ProductModel(
        id: 'c1',
        title: 'Iced Americano',
        description: 'Intense espresso served over ice.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
      ),
      ProductModel(
        id: 'c2',
        title: 'Latte',
        description: 'Smooth espresso with milk and ice.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=500&q=80',
      ),
      ProductModel(
        id: 'c3',
        title: 'Iced Matcha Latte',
        description: 'Creamy matcha with cold milk.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500&q=80',
      ),
      ProductModel(
        id: 'c4',
        title: 'Gin Cold Brew',
        description: 'Smooth cold brew with citrus notes.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
      ),
    ],

    // 2: Bakery
    2: [
      ProductModel(
        id: 'b1',
        title: 'Croissant',
        description: 'Handmade puff pastry, light and buttery.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=500&q=80',
      ),
      ProductModel(
        id: 'b2',
        title: 'Cinnamon Roll',
        description: 'Warm, fluffy roll with cinnamon sugar glaze.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500&q=80',
      ),
      ProductModel(
        id: 'b3',
        title: 'Blueberry Muffin',
        description: 'Soft muffin packed with juicy blueberries.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=500&q=80',
      ),
      ProductModel(
        id: 'b4',
        title: 'Chocolate Brownie',
        description: 'Rich, fudgy brownie with a deep chocolate flavor.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500&q=80',
      ),
    ],

    // 3: Snacks
    3: [
      ProductModel(
        id: 's1',
        title: 'Cookies',
        description: 'Freshly baked soft cookies.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=500&q=80',
      ),
      ProductModel(
        id: 's2',
        title: 'Garlic Bread',
        description: 'Toasted bread with buttery garlic flavor.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500&q=80',
      ),
      ProductModel(
        id: 's3',
        title: 'Onion Rings',
        description: 'Golden, crispy rings with a sweet onion center.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1639024471283-03518883512d?w=500&q=80',
      ),
      ProductModel(
        id: 's4',
        title: 'Cheese Balls',
        description: 'Crunchy bites filled with creamy cheese.',
        price: 30.00,
        imageUrl: 'https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?w=500&q=80',
      ),
    ],
  }.obs;

  List<ProductModel> get currentProducts {
    final list = categoryProducts[selectedCategoryIndex.value] ?? [];
    if (searchQuery.value.trim().isEmpty) {
      return list;
    }
    return list
        .where((p) => p.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }
}
