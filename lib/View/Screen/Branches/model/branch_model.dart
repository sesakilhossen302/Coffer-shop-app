class BranchModel {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String mapImageUrl;
  final String canPayInCash;
  final String rewardsExpire;
  final String whatsappUrl;
  final String instagramUrl;
  final String facebookUrl;

  BranchModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.mapImageUrl,
    this.canPayInCash = 'Yes',
    this.rewardsExpire = 'No',
    this.whatsappUrl = '',
    this.instagramUrl = '',
    this.facebookUrl = '',
  });
}
