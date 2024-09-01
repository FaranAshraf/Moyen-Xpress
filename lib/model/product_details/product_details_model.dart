class ProductDetailsModel {
  int? id;
  String? title;
  double? rating;
  int? noOfRating;
  int? likeCount;
  int? deliveryDays;
  double? price;
  List<ProductImages>? productImages;
  SellerData? seller;
  DateTime? auctionEndDate;
  int selectedImageIndex;
  num? minQty;
  ProductDetailsModel({
    this.id,
    this.title,
    this.rating,
    this.noOfRating,
    this.likeCount,
    this.deliveryDays,
    this.price,
    this.productImages,
    this.seller,
    this.auctionEndDate,
    this.selectedImageIndex = 0,
    this.minQty
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'productImages': ProductImages.listToJson(productImages ?? []),
      'seller': seller,
      'title': title,
      'rating': rating,
      'noOfRating': noOfRating,
      'likeCount': likeCount,
      'deliveryDays': deliveryDays,
      'price': price,
      'auctionEndDate': auctionEndDate,
      'minQty':minQty
    };
  }

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
        id: json['id'] as int?,
        productImages: ProductImages.listFromJson(json['productImages']),
        seller: SellerData.fromJson(json['seller']),
        title: json['title'] as String?,
        rating: json['rating'] as double?,
        noOfRating: json['noOfRating'] as int?,
        likeCount: json['likeCount'] as int?,
        deliveryDays: json['deliveryDays'] as int?,
        price: json['price'] as double?,
        minQty: json['min_qty'] as num?,
        auctionEndDate: json[
            'auctionEndDate'] // FIXME: Use this when integrating api -> DateTime.tryParse(json['auctionEndDate']),
        );
  }

  ProductDetailsModel copyWith({
    int? id,
    String? title,
    double? rating,
    int? noOfRating,
    int? likeCount,
    int? deliveryDays,
    double? price,
    List<ProductImages>? productImages,
    SellerData? seller,
    int? selectedImageIndex,
  }) {
    return ProductDetailsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      noOfRating: noOfRating ?? this.noOfRating,
      likeCount: likeCount ?? this.likeCount,
      deliveryDays: deliveryDays ?? this.deliveryDays,
      price: price ?? this.price,
      productImages: productImages ?? this.productImages,
      seller: seller ?? this.seller,
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
    );
  }
}

class SellerData {
  int? id;
  String? name;
  String? email;
  bool? isActive;
  String? imageUrl;
  double? rating;
  int? noOfReviews;

  SellerData({
    this.id,
    this.name,
    this.email,
    this.isActive,
    this.imageUrl,
    this.rating,
    this.noOfReviews,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'emil': email,
      'isActive': isActive,
      'imageUrl': imageUrl,
      'rating': rating,
      'noOfReviews': noOfReviews,
    };
  }

  factory SellerData.fromJson(Map<String, dynamic> json) {
    return SellerData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      isActive: json['isActive'] as bool?,
      imageUrl: json['imageUrl'] as String?,
      rating: json['rating'] as double?,
      noOfReviews: json['noOfReviews'] as int?,
    );
  }
}

class ProductImages {
  int? id;
  String? imageUrl;

  ProductImages({this.id, this.imageUrl});

  static List<ProductImages> listFromJson(List jsonList) {
    return jsonList.map((e) => ProductImages.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<ProductImages> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  factory ProductImages.fromJson(Map<String, dynamic> json) {
    return ProductImages(
      id: json['id'] as int?,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
