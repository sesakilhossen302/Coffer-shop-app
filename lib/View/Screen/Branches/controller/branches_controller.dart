import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Home/model/product_model.dart';
import '../model/branch_model.dart';

class BranchesController extends GetxController {
  TextEditingController? _searchController;
  TextEditingController? _productSearchController;

  final RxString searchQuery = 'Montejo Promenade #220'.obs;
  final RxString productSearchQuery = ''.obs;
  final RxInt selectedShopTab = 0.obs; // 0: Working Hours, 1: Products
  final RxInt selectedCategoryIndex = 0.obs;

  TextEditingController get searchController {
    try {
      _searchController ??= TextEditingController();
      if (_searchController!.text.isEmpty) {
        _searchController!.text = searchQuery.value;
      }
    } catch (_) {
      _searchController = TextEditingController(text: searchQuery.value);
    }
    return _searchController!;
  }

  TextEditingController get productSearchController {
    try {
      _productSearchController ??= TextEditingController();
      _productSearchController!.text;
    } catch (_) {
      _productSearchController = TextEditingController();
    }
    return _productSearchController!;
  }

  final RxList<ProductModel> shopProducts = <ProductModel>[
    ProductModel(
      id: 'sp1',
      title: 'Americano',
      description: 'Intense espresso served over hot water.',
      price: 30.00,
      imageUrl:
          'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500&q=80',
    ),
    ProductModel(
      id: 'sp2',
      title: 'Espresso',
      description: 'Smooth espresso with milk and hot chocolate.',
      price: 30.00,
      imageUrl:
          'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
    ),
    ProductModel(
      id: 'sp3',
      title: 'Matcha Latte',
      description: 'Creamy green tea matcha with steamed milk.',
      price: 35.00,
      imageUrl:
          'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500&q=80',
    ),
    ProductModel(
      id: 'sp4',
      title: 'Cappuccino',
      description: 'Rich espresso with steamed milk foam.',
      price: 32.00,
      imageUrl:
          'https://images.unsplash.com/photo-1534778101976-62847782c213?w=500&q=80',
    ),
  ].obs;

  final RxList<BranchModel> shopsAtLocation = <BranchModel>[
    BranchModel(
      id: 's1',
      name: 'Starbucks',
      address: '17 Motijheel C/A, Dhaka 1000',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl:
          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: false,
      isFavorite: false,
    ),
    BranchModel(
      id: 's2',
      name: 'Starbucks',
      address: '17 Motijheel C/A, Dhaka 1000',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl:
          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: true,
      isFavorite: false,
    ),
    BranchModel(
      id: 's3',
      name: 'Starbucks',
      address: '17 Motijheel C/A, Dhaka 1000',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl:
          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: true,
      isFavorite: false,
    ),
  ].obs;

  final RxList<BranchModel> branches = <BranchModel>[
    BranchModel(
      id: 'b1',
      name: 'Coffecito Montejo',
      address: 'Montejo Promenade #220',
      phone: '+1664456285966',
      mapImageUrl:
          'https://maps.googleapis.com/maps/api/staticmap?center=20.9856,-89.6225&zoom=14&size=600x300&sensor=false',
      canPayInCash: 'Yes',
      rewardsExpire: 'No',
    ),
    BranchModel(
      id: 'b2',
      name: 'Coffecito Montejo',
      address: 'Montejo Promenade #220',
      phone: '+1664456285966',
      mapImageUrl:
          'https://maps.googleapis.com/maps/api/staticmap?center=20.9856,-89.6225&zoom=14&size=600x300&sensor=false',
      canPayInCash: 'Yes',
      rewardsExpire: 'No',
    ),
  ].obs;

  List<BranchModel> get filteredBranches {
    if (searchQuery.value.trim().isEmpty) {
      return branches;
    }
    return branches.where((b) {
      final query = searchQuery.value.toLowerCase();
      return b.name.toLowerCase().contains(query) ||
          b.address.toLowerCase().contains(query);
    }).toList();
  }

  void toggleFavorite(BranchModel shop) {
    shop.isFavorite = !shop.isFavorite;
    shopsAtLocation.refresh();
    Get.snackbar(
      shop.isFavorite ? 'Added to Favorites' : 'Removed from Favorites',
      '${shop.name} has been ${shop.isFavorite ? 'added to' : 'removed from'} your favorites.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF195ABE),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  void openDirections(BranchModel branch) {
    Get.snackbar(
      'Opening Maps...',
      'Getting directions to ${branch.name}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF195ABE),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }
}
