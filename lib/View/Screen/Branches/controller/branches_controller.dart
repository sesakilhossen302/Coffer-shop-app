import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/branch_model.dart';

class BranchesController extends GetxController {
  TextEditingController? _searchController;
  final RxString searchQuery = 'Montejo Promenade #220'.obs;

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

  final RxList<BranchModel> shopsAtLocation = <BranchModel>[
    BranchModel(
      id: 's1',
      name: 'Starbucks',
      address: 'Montejo Promenade #220',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: false,
      isFavorite: false,
    ),
    BranchModel(
      id: 's2',
      name: 'Starbucks',
      address: 'Montejo Promenade #220',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: true,
      isFavorite: false,
    ),
    BranchModel(
      id: 's3',
      name: 'Starbucks',
      address: 'Montejo Promenade #220',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
      isOpen: true,
      isFavorite: false,
    ),
    BranchModel(
      id: 's4',
      name: 'Starbucks',
      address: 'Montejo Promenade #220',
      phone: '+1664456285966',
      mapImageUrl: '',
      logoUrl: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=150&q=80',
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
