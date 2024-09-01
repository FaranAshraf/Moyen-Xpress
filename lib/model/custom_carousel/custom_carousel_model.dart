class BannersModel {
  List<CustomCarouselModel>? categories1;
  List<CustomCarouselModel>? categories2;
  List<CustomCarouselModel>? categories3;

  BannersModel({
    this.categories1,
    this.categories2,
    this.categories3,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'categories1': CustomCarouselModel.listToJson(categories1 ?? []),
      'categories2': CustomCarouselModel.listToJson(categories2 ?? []),
      'categories3': CustomCarouselModel.listToJson(categories3 ?? []),
    };
  }

  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      categories1: CustomCarouselModel.listFromJson(json['categories1'] ?? []),
      categories2: CustomCarouselModel.listFromJson(json['categories2'] ?? []),
      categories3: CustomCarouselModel.listFromJson(json['categories3'] ?? []),
    );
  }
}

class CustomCarouselModel {
  int? categoryId;
  String? name;
  String? image;

  CustomCarouselModel({this.categoryId, this.image, this.name});

  static List<Map<String, dynamic>> listToJson(
      List<CustomCarouselModel> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  static List<CustomCarouselModel> listFromJson(List jsonList) {
    return jsonList.map((e) => CustomCarouselModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'category_id': categoryId,
      'imageUrl': image,
    };
  }

  factory CustomCarouselModel.fromJson(Map<String, dynamic> json) {
    return CustomCarouselModel(
      categoryId: json['category_id'] as int?,
      image: json['image'] as String?,
    );
  }
}
