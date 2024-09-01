class HomeCategoriesModel {
  int? id;
  String? title;
  String? image;

  HomeCategoriesModel({
    this.id,
    this.title,
    this.image,
  });

  static List<HomeCategoriesModel> listFromJson(List jsonList) {
    return jsonList.map((e) => HomeCategoriesModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
    };
  }

  factory HomeCategoriesModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoriesModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      image: json['image'] as String?,
    );
  }
}
