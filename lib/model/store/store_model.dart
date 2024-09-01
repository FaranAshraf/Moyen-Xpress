// ignore_for_file: public_member_api_docs, sort_constructors_first
class StoreModel {
  String? title;
  String? image;
  double? rating;
  int? noOfRating;
  StoreModel({
    this.title,
    this.image,
    this.rating,
    this.noOfRating,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'rating': rating,
      'noOfRatings': noOfRating
    };
  }

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      title: json['title'] as String?,
      image: json['image'] as String?,
      rating: json['rating'] as double?,
      noOfRating: json['noOfRating'] as int?,
    );
  }

  StoreModel copyWith({
    String? storeName,
    String? storeImage,
    double? rating,
    int? noOfRating,
  }) {
    return StoreModel(
      title: title ?? this.title,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      noOfRating: noOfRating ?? this.noOfRating,
    );
  }
}

class ResponseModel {
  bool isSuccess;
  dynamic failReason;
  dynamic failReasonContent;
  StoreDetail? successContents;

  ResponseModel({
    required this.isSuccess,
    required this.failReason,
    required this.failReasonContent,
    required this.successContents,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      isSuccess: json['isSuccess'],
      failReason: json['failReason'],
      failReasonContent: json['failReasonContent'],
      successContents: json['successContents'] != null
          ? StoreDetail.fromJson(json['successContents'])
          : null,
    );
  }
}

class StoreDetail {
  List<Detail>? details;
  List<Product>? allProducts;
  List<Product>? featuresProducts;
  List<Product>? newArrivals;
  List<Product>? topSelling;
  StoreDetail(
      {this.details,
      this.allProducts,
      this.featuresProducts,
      this.newArrivals,
      this.topSelling});

  factory StoreDetail.fromJson(Map<String, dynamic> json) {
    return StoreDetail(
      details:
          List<Detail>.from(json['details'].map((x) => Detail.fromJson(x))),
      allProducts: json['all_products'] != null
          ? List<Product>.from(
              json['all_products'].map((x) => Product.fromJson(x)))
          : null,
      featuresProducts: json['featured_products'] != null
          ? List<Product>.from(
              json['featured_products'].map((x) => Product.fromJson(x)))
          : null,
      newArrivals: json['new_arrival_products'] != null
          ? List<Product>.from(
              json['new_arrival_products'].map((x) => Product.fromJson(x)))
          : null,
      topSelling: json['top_selling_products'] != null
          ? List<Product>.from(
              json['top_selling_products'].map((x) => Product.fromJson(x)))
          : null,
    );
  }
}

class Detail {
  int? id;
  String? name;
  String? image;
  String? address;
  num? rating;

  Detail({
    required this.id,
    required this.name,
    required this.rating,
    required this.image,
    required this.address,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      name: json['name'],
      rating: json['rating'],
      image: json['image'],
      address: json['address'],
    );
  }
}

class Product {
  int? id;
  String? name;
  String? image;
  num? unitPrice;
  int? discount;
  num? rating;
  Product(
      {this.id,
      this.name,
      this.image,
      this.unitPrice,
      this.discount,
      this.rating});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['thumbnail_img'],
      unitPrice: json['price'],
      discount: json['discount'],
      rating: json['rating'],
    );
  }
}

class Rates {
  final double rate;

  Rates({required this.rate});

  factory Rates.fromJson(Map<String, dynamic> json) {
    return Rates(
      rate: json['rates'] != null ? json['rates'].toDouble() : 0.0,
    );
  }
}
