// ignore_for_file: public_member_api_docs, sort_constructors_first

class ShippingDetailModel {
  int? id;
  String? title;
  String? orderId;
  String? orderDate;
  String? size;
  List<ProductImages>? productImages;
  ShippingInfo? shippingInfo;
  ProductInfo? productInfo;

  ShippingDetailModel({
    this.id,
    this.title,
    this.orderId,
    this.orderDate,
    this.size,
    this.productImages,
    this.shippingInfo,
    this.productInfo,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'orderId': orderId,
      'orderDate': orderDate,
      'size': size,
      'productImages': ProductImages.listToJson(productImages ?? []),
      'shippingInfo': shippingInfo?.toJson(),
      'productInfo': productInfo?.toJson(),
    };
  }

  factory ShippingDetailModel.fromJson(Map<String, dynamic> json) {
    return ShippingDetailModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      orderId: json['orderId'] as String?,
      orderDate: json['orderDate'] as String?,
      size: json['size'] as String?,
      productImages: ProductImages.listFromJson(json['productImages'] ?? []),
      shippingInfo: ShippingInfo.fromJson(json['shippingInfo'][0] ?? {}),
      productInfo: ProductInfo.fromJson(json['productInfo'][0] ?? {}),
    );
  }

  ShippingDetailModel copyWith({
    int? id,
    String? title,
    String? orderId,
    String? orderDate,
    String? size,
    List<ProductImages>? productImages,
    ShippingInfo? shippingInfo,
    ProductInfo? productInfo,
  }) {
    return ShippingDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      orderId: orderId ?? this.orderId,
      orderDate: orderDate ?? this.orderDate,
      size: size ?? this.size,
      productImages: productImages ?? this.productImages,
      shippingInfo: shippingInfo ?? this.shippingInfo,
      productInfo: productInfo ?? this.productInfo,
    );
  }
}

class ProductInfo {
  int? proId;
  String? quantity;
  String? subtotal;
  String? shipping;
  String? tax;
  String? coupon;
  String? total;

  ProductInfo({
    this.proId,
    this.quantity,
    this.subtotal,
    this.shipping,
    this.tax,
    this.coupon,
    this.total,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'proId':proId,
      'quantity': quantity,
      'subtotal': subtotal,
      'shipping': shipping,
      'tax': tax,
      'coupon': coupon,
      'total': total,
    };
  }

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      proId:json['proId'] as int? ,
      quantity: json['quantity'] as String?,
      subtotal: json['subtotal'] as String?,
      shipping: json['shipping'] as String?,
      tax: json['tax'] as String?,
      coupon: json['coupon'] as String?,
      total: json['total'] as String?,
    );
  }
}

class ShippingInfo {
  int? shipId;
  String? seller;
  String? paymentStatus;
  String? deliveryStatus;
  String? paymentMethod;
  String? orderStatus;
  String? shippingAddress;
  String? emailAddress;
  String? deliveryType;

  ShippingInfo({
    this.shipId,
    this.seller,
    this.paymentStatus,
    this.deliveryStatus,
    this.paymentMethod,
    this.orderStatus,
    this.shippingAddress,
    this.emailAddress,
    this.deliveryType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'shipId': shipId,
      'seller': seller,
      'paymentStatus': paymentStatus,
      'deliveryStatus': deliveryStatus,
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'shippingAddress': shippingAddress,
      'emailAddress': emailAddress,
      'deliveryType': deliveryType,
    };
  }

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      shipId: json['shipId'] as int?,
      seller: json['seller'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      deliveryStatus: json['deliveryStatus'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      orderStatus: json['orderStatus'] as String?,
      shippingAddress: json['shippingAddress'] as String?,
      emailAddress: json['emailAddress'] as String?,
      deliveryType: json['deliveryType'] as String?,
    );
  }
}

class ProductImages {
  int? id;
  String? imageUrl;

  ProductImages({this.id, this.imageUrl});

  static List<ProductImages> listFromJson(List jsonList) {
    return jsonList.map((e) => ProductImages.fromJson(e as Map<String, dynamic>)).toList();
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
