import 'package:moyen_express/resources/exports/index.dart';

class ProductData {
  Product product;
  RatingAndReviews ratingReviews;
  List<ListViewModel> topSellingProducts;
  List<ListViewModel> relatedProducts;
  SocialUrls socialUrls;
  ProductData({
    required this.product,
    required this.ratingReviews,
    required this.topSellingProducts,
    required this.relatedProducts,
    required this.socialUrls,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      product: Product.fromJson(json['product']),
      ratingReviews: RatingAndReviews.fromJson(json['rating_and_reviews']),
      topSellingProducts:
          ListViewModel.listFromJson(json['top_selling_products']),
      relatedProducts: ListViewModel.listFromJson(json['related_products']),
      socialUrls: SocialUrls.fromJson(json['social_urls'])
    );
  }
}

class Product {
  int? id;
  String? name;
  String? addedBy;
  String? description;
  String? note;
  num? unitPrice;
  String? currency;
  String? thumbnailImg;
  String? unit;
  num? rating;
  num? discount;
  String? discount_type;
  String? discount_currency;
  int? shippingDays;
  int? refundAble;
  List<String>? galleryImages;
  List<Question>? questions;
  List<Review>? reviews;
  DateTime? auctionEndDate;
  int selectedImageIndex;
  Shop? shop;
  num? stock;
  List<ColorModel>? colors;
  List<String>? colorsName;
  List<ChoiceOption>? choiceOptions;
  num? startingBid;
  String? productCondition;
  String? vehicleCondition;
  num? highestBid;
  num? minimumBid;
  num? minQty;
  List<Taxes>? taxes;

  Product(
      {required this.id,
      required this.name,
      required this.addedBy,
      required this.description,
      required this.note,
      required this.unitPrice,
      required this.currency,
      required this.thumbnailImg,
      required this.rating,
      required this.discount,
      this.discount_type,
      this.discount_currency,
      required this.shippingDays,
      required this.refundAble,
      required this.galleryImages,
      required this.questions,
      required this.reviews,
      this.productCondition,
      this.vehicleCondition,
      this.startingBid,
      this.selectedImageIndex = 0,
      this.auctionEndDate,
      this.shop,
      this.choiceOptions,
      this.stock,
      this.colors,
      this.highestBid,
      this.unit,
      this.minimumBid,
      this.colorsName,
      
      this.minQty,
      this.taxes,
      });

  factory Product.fromJson(Map<String, dynamic> json) {
    var choiceOptionsList = jsonDecode(json['choice_options']) as List;
    List<ChoiceOption> choiceOptions = choiceOptionsList
        .map((choiceOption) => ChoiceOption.fromJson(choiceOption))
        .toList();
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
      addedBy: json['added_by'] as String?,
      description: json['description'] as String?,
      auctionEndDate: json['auction_end_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['auction_end_date'] * 1000)
          : null,
      unitPrice: json['unit_price'] as num?,
      currency: json['currency'] as String?,
      productCondition: json['product_condition'] as String?,
      vehicleCondition: json['vehicle_product_condition'] as String?,
      unit: json['unit'] as String?,
      stock: json['stock'] as num?,
      highestBid: json["highest_bid"] as num?,
      startingBid: json['starting_bid'] as num?,
      note: json['note'] as String?,
      rating: json['rating'] as num?,
      discount: (json['discount'] as num?) ?? 0,
      discount_type: json['discount_type'] as String?,
      discount_currency: json['discount_currency'] as String?,
      minimumBid: json['minimum_place_bid_amount'] as num?,
      minQty: json['min_qty'] as num?,
      shippingDays: json['est_shipping_days'] as int?,
      refundAble: json['refundable'] as int?,
      thumbnailImg: json['thumbnail_img'] as String?,
      galleryImages: List<String>.from(json['gallery_images']),
      colorsName: List<String>.from(json['color_names']),
      questions: (json['questions'] as List<dynamic>?)
          ?.map((questionJson) =>
              Question.fromJson(questionJson as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((reviewJson) =>
              Review.fromJson(reviewJson as Map<String, dynamic>))
          .toList(),
      shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
      colors: json['colors'] != null
          ? List<ColorModel>.from(jsonDecode(json['colors'])
              .map<ColorModel>((color) => ColorModel(hexCode: color)))
          : null,
      choiceOptions: choiceOptions,
       taxes: (json['taxes'] as List<dynamic>?)
          ?.map((taxJson) => Taxes.fromJson(taxJson as Map<String, dynamic>))
          .toList(),
    );
  }
}


class Taxes {
  int? id;
  int? productId;
  int? taxId;
  double? tax;
  String? taxType;
  String? createdAt;
  String? updatedAt;

  Taxes({
    this.id,
    this.productId,
    this.taxId,
    this.tax,
    this.taxType,
    this.createdAt,
    this.updatedAt,
  });

  factory Taxes.fromJson(Map<String, dynamic> json) {
    return Taxes(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      taxId: json['tax_id'] as int?,
      tax: (json['tax'] as num?)?.toDouble(), // Ensuring the type is double
      taxType: json['tax_type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}




class ChoiceOption {
  String attributeId;
  List<String> values;

  ChoiceOption({
    required this.attributeId,
    required this.values,
  });

  factory ChoiceOption.fromJson(Map<String, dynamic> json) {
    return ChoiceOption(
      attributeId: json['attribute_id'],
      values: List<String>.from(json['values']),
    );
  }
}

class ColorModel {
  String? hexCode;

  ColorModel({
    this.hexCode,
  });

  factory ColorModel.fromJson(String json) {
    return ColorModel(
      hexCode: json,
    );
  }
}

class Review {
  int? id;
  int? orderDetailId;
  int? productId;
  int? userId;
  num? rating;
  String? comment;
  int? status;
  int? viewed;

  Review({
    required this.id,
    this.orderDetailId,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.status,
    required this.viewed,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int?,
      orderDetailId: json['order_detail_id'] as int?,
      productId: json['product_id'] as int?,
      userId: json['user_id'] as int?,
      rating: json['rating'] as num?,
      comment: json['comment'] as String?,
      status: json['status'] as int?,
      viewed: json['viewed'] as int?,
    );
  }
}

class Question {
  int? id;
  int? productId;
  int? userId;
  String? question;
  int? status;
  List<Answer>? answers;
  User? user;

  Question({
    required this.id,
    required this.productId,
    required this.userId,
    required this.question,
    required this.status,
    this.answers,
    required this.user,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      userId: json['user_id'] as int?,
      question: json['question'] as String?,
      status: json['status'] as int?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((answerJson) =>
              Answer.fromJson(answerJson as Map<String, dynamic>))
          .toList(),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class Answer {
  int? id;
  int? questionId;
  int? productId;
  int? userId;
  String? answer;
  int? status;

  Answer({
    required this.id,
    required this.questionId,
    required this.productId,
    required this.userId,
    required this.answer,
    required this.status,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as int?,
      questionId: json['question_id'] as int?,
      productId: json['product_id'] as int?,
      userId: json['user_id'] as int?,
      answer: json['answer'] as String?,
      status: json['status'] as int?,
    );
  }
}

class Shop {
  int? id;
  int? userId;
  String? name;
  String? shopType;
  String? logo;
  String? sliders;
  String? phone;
  String? address;
  num? rating;
  num? reviews;
  User? user;

  Shop({
    this.id,
    this.userId,
    this.name,
    this.shopType,
    this.logo,
    this.sliders,
    this.phone,
    this.address,
    this.rating,
    this.reviews,
    this.user,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      shopType: json['shop_type'],
      logo: json['logo'],
      sliders: json['sliders'],
      phone: json['phone'],
      address: json['address'],
      rating: json['rating'],
      reviews: json['reviews'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  int? id;
  int? referredBy;
  String? providerId;
  String? userType;
  String? name;
  String? email;
  String? logo;

  User({
    this.id,
    this.referredBy,
    this.providerId,
    this.userType,
    this.name,
    this.email,
    this.logo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      referredBy: json['referred_by'] as int?,
      providerId: json['provider_id'] as String?,
      userType: json['user_type'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      logo: json['avatar_original'] as String?,
    );
  }
}

class ReviewDetail {
  String? userName;
  int? rating;
  String? comment;
  String? date;
  String? image;
  RatingsByFeature? ratingsByFeature;

  ReviewDetail(
      {this.userName,
      this.rating,
      this.comment,
      this.ratingsByFeature,
      this.date,
      this.image});

  factory ReviewDetail.fromJson(Map<String, dynamic> json) {
    return ReviewDetail(
      userName: json['user_name'],
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      image: json['image'],
      ratingsByFeature: json['ratings_by_feature'] != null
          ? RatingsByFeature.fromJson(json['ratings_by_feature'])
          : null,
    );
  }
}

class RatingAndReviews {
  int? totalRatings;
  String? averageRating;
  int? globalRatings;
  RatingsByStar? ratingsByStar;
  List<ReviewDetail>? reviews;
  CustomerRatingByFeature? customerRatingsFeature;
  RatingAndReviews(
      {this.totalRatings,
      this.averageRating,
      this.globalRatings,
      this.ratingsByStar,
      this.reviews,
      this.customerRatingsFeature});

  factory RatingAndReviews.fromJson(Map<String, dynamic> json) {
    return RatingAndReviews(
      totalRatings: json['total_ratings'],
      averageRating: json['average_rating'],
      globalRatings: json['global_ratings'],
      ratingsByStar: json['ratings_by_star'] != null
          ? RatingsByStar.fromJson(json['ratings_by_star'])
          : null,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
              .map((i) => ReviewDetail.fromJson(i))
              .toList()
          : null,
      customerRatingsFeature: json['customer_ratings_by_feature'] != null
          ? CustomerRatingByFeature.fromJson(
              json['customer_ratings_by_feature'])
          : null,
    );
  }
}

class RatingsByStar {
  double? fiveStar;
  double? fourStar;
  double? threeStar;
  double? twoStar;
  double? oneStar;

  RatingsByStar({
    this.fiveStar,
    this.fourStar,
    this.threeStar,
    this.twoStar,
    this.oneStar,
  });

  factory RatingsByStar.fromJson(Map<String, dynamic> json) {
    return RatingsByStar(
      fiveStar: json['5_star'] != null ? _parseDouble(json['5_star']) : null,
      fourStar: json['4_star'] != null ? _parseDouble(json['4_star']) : null,
      threeStar: json['3_star'] != null ? _parseDouble(json['3_star']) : null,
      twoStar: json['2_star'] != null ? _parseDouble(json['2_star']) : null,
      oneStar: json['1_star'] != null ? _parseDouble(json['1_star']) : null,
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value);
    } else if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return null;
    }
  }
}

class RatingsByFeature {
  double? easyToUse;
  double? valueForMoney;
  double? durability;
  double? temperatureControl;
  double? versatility;
  double? easyToClean;

  RatingsByFeature({
    this.easyToUse,
    this.valueForMoney,
    this.durability,
    this.temperatureControl,
    this.versatility,
    this.easyToClean,
  });

  factory RatingsByFeature.fromJson(Map<String, dynamic> json) {
    return RatingsByFeature(
      easyToUse: json['easy_to_use'] != null
          ? double.parse(json['easy_to_use'])
          : null,
      valueForMoney: json['value_for_money'] != null
          ? double.parse(json['value_for_money'])
          : null,
      durability:
          json['durability'] != null ? double.parse(json['durability']) : null,
      temperatureControl: json['temperature_control'] != null
          ? double.parse(json['temperature_control'])
          : null,
      versatility: json['versatility'] != null
          ? double.parse(json['versatility'])
          : null,
      easyToClean: json['easy_to_clean'] != null
          ? double.parse(json['easy_to_clean'])
          : null,
    );
  }
}

class CustomerRatingByFeature {
  num? easyToUse;
  num? valueForMoney;
  num? durability;
  num? temperatureControl;
  num? versatility;
  num? easyToClean;

  CustomerRatingByFeature({
    this.easyToUse,
    this.valueForMoney,
    this.durability,
    this.temperatureControl,
    this.versatility,
    this.easyToClean,
  });

  factory CustomerRatingByFeature.fromJson(Map<String, dynamic> json) {
    return CustomerRatingByFeature(
      easyToUse: json['easy_to_use'],
      valueForMoney: json['value_for_money'],
      durability: json['durability'],
      temperatureControl: json['temperature_control'],
      versatility: json['versatility'],
      easyToClean: json['easy_to_clean'],
    );
  }
}

class SocialUrls {
  final String? email;
  final String? twitter;
  final String? facebook;
  final String? linkedin;
  final String? whatsapp;
  final String? pinterest;
  final String? reddit;
  final String? messenger;
  final String? vk;
  final String? koo;

  SocialUrls({
    this.email,
    this.twitter,
    this.facebook,
    this.linkedin,
    this.whatsapp,
    this.pinterest,
    this.reddit,
    this.messenger,
    this.vk,
    this.koo,
  });

  factory SocialUrls.fromJson(Map<String, dynamic> json) {
    return SocialUrls(
      email: json['email'],
      twitter: json['twitter'],
      facebook: json['facebook'],
      linkedin: json['linkedin'],
      whatsapp: json['whatsapp'],
      pinterest: json['pinterest'],
      reddit: json['reddit'],
      messenger: json['messenger'],
      vk: json['vk'],
      koo: json['koo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'twitter': twitter,
      'facebook': facebook,
      'linkedin': linkedin,
      'whatsapp': whatsapp,
      'pinterest': pinterest,
      'reddit': reddit,
      'messenger': messenger,
      'vk': vk,
      'koo': koo,
    };
  }
}
