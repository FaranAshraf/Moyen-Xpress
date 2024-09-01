class RegionSeller {
  int? id;
  String? name;
  String? image;


  RegionSeller({
    this.id,
    this.name,
    this.image,

  });

  factory RegionSeller.fromJson(Map<String, dynamic> json) {
    return RegionSeller(
      id: json['id'],
      name: json['name'],
      image: json['image'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
 
      'name': name,
      'image': image,
    };
    return data;
  }
}
