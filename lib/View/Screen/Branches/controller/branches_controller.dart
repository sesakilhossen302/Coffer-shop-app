import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/branch_model.dart';

class BranchesController extends GetxController {
  TextEditingController? _searchController;
  final RxString searchQuery = ''.obs;

  TextEditingController get searchController {
    try {
      _searchController ??= TextEditingController();
      _searchController!.text;
    } catch (_) {
      _searchController = TextEditingController();
    }
    return _searchController!;
  }

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
    BranchModel(
      id: 'b3',
      name: 'Coffecito Altabrisa',
      address: 'Altabrisa Mall #104',
      phone: '+1664456285988',
      mapImageUrl:
          'https://maps.googleapis.com/maps/api/staticmap?center=21.0156,-89.5825&zoom=14&size=600x300&sensor=false',
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
