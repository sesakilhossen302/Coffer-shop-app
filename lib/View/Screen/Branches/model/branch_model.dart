class BranchModel {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String mapImageUrl;
  final String logoUrl;
  final String canPayInCash;
  final String rewardsExpire;
  final String whatsappUrl;
  final String instagramUrl;
  final String facebookUrl;
  final bool isOpen;
  bool isFavorite;

  BranchModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.mapImageUrl,
    this.logoUrl = 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=150&q=80',
    this.canPayInCash = 'Yes',
    this.rewardsExpire = 'No',
    this.whatsappUrl = '',
    this.instagramUrl = '',
    this.facebookUrl = '',
    this.isOpen = true,
    this.isFavorite = false,
  });
}
