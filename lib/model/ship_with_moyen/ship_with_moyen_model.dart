class ShippingProducts {
   int? id;
   String? name;
   int? weight;
   int? length;
   int? width;
   int? height;
   String? createdAt;
   String? updatedAt;

  ShippingProducts({
    this.id,
    this.name,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.createdAt,
    this.updatedAt,
  });

  factory ShippingProducts.fromJson(Map<String, dynamic> json) {
  return ShippingProducts(
    id: json['id'] as int?,
    name: json['name'] as String?,
    weight: json['weight'] as int?,
    length: json['length'] as int?,
    width: json['width'] as int?,
    height: json['height'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'length': length,
      'width': width,
      'height': height,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}