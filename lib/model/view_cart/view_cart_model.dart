// ignore_for_file: public_member_api_docs, sort_constructors_first
class Cart {
  final bool? isSuccess;
  final String? message;
  final String? failReason;
  final String? failReasonContent;
  final List<CartItem>? successContents;

  Cart({
    this.isSuccess,
    this.message,
    this.failReason,
    this.failReasonContent,
    this.successContents,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      isSuccess: json['isSuccess'],
      message: json['message'],
      failReason: json['failReason'],
      failReasonContent: json['failReasonContent'],
      successContents: (json['successContents'] as List<dynamic>?)
          ?.map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}

class CartItem {
  final int? id;
  final int? ownerId;
  final int? userId;
  final dynamic tempUserId;
  final int? addressId;
  final int? productId;
  final String? productType;
  final String? purchaseType;
  final dynamic bookingDate;
  final dynamic variation;
  final double? price;
  final double? tax;
  final double? shippingCost;
  final String? shippingType;
  final int? shippingId;
  final dynamic pickupPoint;
  final num? discount;
  final dynamic productReferralCode;
  final dynamic couponCode;
  final int? couponApplied;
  int? quantity;
  final int? serviceWithMoyen;
  final int? serviceWithMoyenQty;
  final String? createdAt;
  final String? updatedAt;
  final String? shopName;
  final Product? product;
  List<Taxes>? taxes;
  final Services? service;

  CartItem({
    this.id,
    this.ownerId,
    this.userId,
    this.tempUserId,
    this.addressId,
    this.productId,
    this.productType,
    this.purchaseType,
    this.bookingDate,
    this.variation,
    this.price,
    this.tax,
    this.shippingCost,
    this.shippingType,
    this.shippingId,
    this.pickupPoint,
    this.discount,
    this.productReferralCode,
    this.couponCode,
    this.couponApplied,
    this.quantity,
    this.serviceWithMoyen,
    this.serviceWithMoyenQty,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.taxes,
    this.service,
    this.shopName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
  return CartItem(
    id: json['id'],
    ownerId: json['owner_id'],
    userId: json['user_id'],
    tempUserId: json['temp_user_id'],
    addressId: json['address_id'],
    productId: json['product_id'],
    productType: json['product_type'],
    purchaseType: json['purchase_type'],
    bookingDate: json['booking_date'],
    variation: json['variation'],
    price: json['price']?.toDouble(),
    tax: json['tax']?.toDouble(),
    shippingCost: json['shipping_cost']?.toDouble(),
    shippingType: json['shipping_type'],
    shippingId: json['shipping_id'],
    pickupPoint: json['pickup_point'],
    discount: json['discount'] as num,
    productReferralCode: json['product_referral_code'],
    couponCode: json['coupon_code'],
    couponApplied: json['coupon_applied'],
    quantity: json['quantity'] as int,
    serviceWithMoyen: json['service_with_moyen'],
    serviceWithMoyenQty: json['service_with_moyen_qty'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    shopName: json['shop_name'],
    product: json['product'] != null ? Product.fromJson(json['product']) : null,
    service: json['service'] != null ? Services.fromJson(json['service']) : null,
    taxes: (json['taxes'] as List<dynamic>?)
        ?.map((taxJson) => Taxes.fromJson(taxJson as Map<String, dynamic>))
        .toList(),
  );
}

  CartItem copyWith({
    int? id,
    int? ownerId,
    int? userId,
    dynamic tempUserId,
    int? addressId,
    int? productId,
    String? productType,
    String? purchaseType,
    dynamic bookingDate,
    dynamic variation,
    double? price,
    double? tax,
    double? shippingCost,
    String? shippingType,
    int? shippingId,
    dynamic pickupPoint,
    double? discount,
    dynamic productReferralCode,
    dynamic couponCode,
    int? couponApplied,
    int? quantity,
    int? serviceWithMoyen,
    int? serviceWithMoyenQty,
    String? createdAt,
    String? updatedAt,
    String? shopName,
    Product? product,
    List<Taxes>? taxes,
    Services? service,
  }) {
    return CartItem(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      userId: userId ?? this.userId,
      tempUserId: tempUserId ?? this.tempUserId,
      addressId: addressId ?? this.addressId,
      productId: productId ?? this.productId,
      productType: productType ?? this.productType,
      purchaseType: purchaseType ?? this.purchaseType,
      bookingDate: bookingDate ?? this.bookingDate,
      variation: variation ?? this.variation,
      price: price ?? this.price,
      tax: tax ?? this.tax,
      shippingCost: shippingCost ?? this.shippingCost,
      shippingType: shippingType ?? this.shippingType,
      shippingId: shippingId ?? this.shippingId,
      pickupPoint: pickupPoint ?? this.pickupPoint,
      discount: discount ?? this.discount,
      productReferralCode: productReferralCode ?? this.productReferralCode,
      couponCode: couponCode ?? this.couponCode,
      couponApplied: couponApplied ?? this.couponApplied,
      quantity: quantity ?? this.quantity,
      serviceWithMoyen: serviceWithMoyen ?? this.serviceWithMoyen,
      serviceWithMoyenQty: serviceWithMoyenQty ?? this.serviceWithMoyenQty,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      shopName: shopName ?? this.shopName,
      product: product ?? this.product,
      taxes: taxes ?? this.taxes,
      service: service ?? this.service,
    );
  }
}

class Product {
  final int? id;
  final String? name;
  final dynamic thumbnail;
  final dynamic photos;
  final String? currency;
  // ignore: non_constant_identifier_names
  final double? unit_price;
  num? discount;
  String? discount_type;
  String? discount_currency;
  

  // ignore: non_constant_identifier_names
  Product( {this.id, this.name, this.thumbnail, this.photos,this.currency,this.unit_price, this.discount, this.discount_currency, this.discount_type,});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      photos: json['photos'],
      currency: json['currency'],
     unit_price: json['unit_price']?.toDouble(),
     discount: (json['discount'] as num?) ?? 0,
     discount_currency: json['discount_currency'] as String?,
     discount_type: json['discount_type'] as String?,
   
     
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


  class Services {
  final int? id;
  final String? name;
  final dynamic thumbnail;
  final String? currency;
  // ignore: non_constant_identifier_names
  final double? unit_price;

  // ignore: non_constant_identifier_names
  Services( {this.id, this.name, this.thumbnail,this.currency,this.unit_price});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'],
      name: json['service_name'],
      thumbnail: json['thumbnail_image'],
      currency: json['currency'],
     unit_price: json['unit_price']?.toDouble(),
    );
  }
}
