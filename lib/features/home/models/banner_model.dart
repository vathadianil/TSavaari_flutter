class BannerModel {
  String id;
  bool active;
  String imageUrl;
  String targetScreen;
  int? targetPageIndex;

  BannerModel({
    required this.id,
    required this.active,
    required this.imageUrl,
    required this.targetScreen,
    this.targetPageIndex,
  });

  static BannerModel empty() =>
      BannerModel(id: '', active: false, imageUrl: '', targetScreen: '');

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
      'targetPageIndex': targetPageIndex,
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic>? data) {
    if (data != null) {
      //Map Json record to the model
      return BannerModel(
        id: data['id'],
        active: data['active'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        targetScreen: data['targetScreen'] ?? '',
        targetPageIndex: data['targetPageIndex'],
      );
    } else {
      return BannerModel.empty();
    }
  }
}
