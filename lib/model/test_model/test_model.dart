
class TestModel {
  bool? isSuccess;
  String? message;
  List<DeliveryContent>? successContents;

  TestModel({
    this.isSuccess,
    this.message,
    this.successContents,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      isSuccess: json['isSuccess'],
      message: json['message'],
      successContents: List<DeliveryContent>.from(
          json['successContents'].map((x) => DeliveryContent.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'isSuccess': isSuccess,
      'message': message,
      'successContents': successContents != null
          ? List<dynamic>.from(successContents!.map((x) => x.toJson()))
          : null,
    };
    return data;
  }
}

class DeliveryContent {
List<Product>? products;
  List<int>? cartIds;
  List<Service>? services;

  DeliveryContent({
    this.products,
    this.cartIds,
    this.services,
  });

  factory DeliveryContent.fromJson(Map<String, dynamic> json) {
    return DeliveryContent(
      products: json['products'] != null
          ? List<Product>.from(json['products'].map((x) => Product.fromJson(x)))
          : null,
      cartIds:
          json['cart_ids'] != null ? List<int>.from(json['cart_ids']) : null,
      services: json['services'] != null
          ? List<Service>.from(json['services'].map((x) => Service.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products?.map((x) => x.toJson()).toList(),
      'cart_ids': cartIds,
      'services': services?.map((x) => x.toJson()).toList(),
    };
  }
}

class Product {
  int? sellerId;
  String? shopName;
  num? checkout;
  String? thumbnail;
  String? name;
  DeliveryMethods? deliveryMethods;

  Product({
    this.sellerId,
    this.shopName,
    this.checkout,
    this.thumbnail,
    this.name,
    this.deliveryMethods,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sellerId: json['seller_id'],
      shopName: json['shop_name'],
      checkout: json['checkout'],
      thumbnail: json['thumbnail'],
      name: json['name'],
      deliveryMethods: json['delivery_methods'] != null
          ? DeliveryMethods.fromJson(json['delivery_methods'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seller_id': sellerId,
      'shop_name': shopName,
      'checkout': checkout,
      'thumbnail': thumbnail,
      'name': name,
      'delivery_methods': deliveryMethods?.toJson(),
    };
  }
}

class DeliveryMethods {
  List<PickupAddress>? pickupAddress;
  ExpressDelivery? expressDelivery;
  num? sendQuote;
  ShipWithMoyen? shipWithMoyen;

  DeliveryMethods({
    this.pickupAddress,
    this.expressDelivery,
    this.shipWithMoyen,
    this.sendQuote,
  });

  factory DeliveryMethods.fromJson(Map<String, dynamic> json) {
    // Ensure json['pickup_address'] and json['express_delivery'] are lists
    return DeliveryMethods(
      pickupAddress:
          json['pickup_address'] != null && json['pickup_address'] is List
              ? List<PickupAddress>.from(
                  json['pickup_address'].map((x) => PickupAddress.fromJson(x)))
              : [],
      expressDelivery: json['express_delivery'] != null &&
              json['express_delivery'] is Map<String, dynamic>
          ? ExpressDelivery.fromJson(json['express_delivery'])
          : null,
      shipWithMoyen: json['ship_with_moyen'] != null &&
              json['ship_with_moyen'] is Map<String, dynamic>
          ? ShipWithMoyen.fromJson(json['ship_with_moyen'])
          : null,
      sendQuote: json['send_qoute'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pickup_address': pickupAddress?.map((x) => x.toJson()).toList(),
      'express_delivery': expressDelivery?.toJson(),
      'ship_with_moyen': shipWithMoyen?.toJson(),
      'send_qoute': sendQuote,
    };
  }
}

class PickupAddress {
  int? id;
  String? type;
  String? address;

  PickupAddress({
    this.id,
    this.type,
    this.address,
  });

  factory PickupAddress.fromJson(Map<String, dynamic> json) {
    return PickupAddress(
      id: json['id'],
      type: json['type'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'address': address,
    };
  }
}

class ExpressDelivery {
  final int? id;
  String? type;
  final double? charges;
  final int? estDays;
  final String? currency;

  ExpressDelivery({
    this.id,
    this.charges,
    this.type,
    this.estDays,
    this.currency,
  });

  factory ExpressDelivery.fromJson(Map<String, dynamic> json) {
    return ExpressDelivery(
      id: json['id'],
      type: json['type'],
      charges: json['charges'],
      estDays: json['est_days'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'charges': charges,
      'est_days': estDays,
      'currency': currency,
    };
  }
}

class ShipWithMoyen {
  final int? id;
  final String? type;
  final double? charges;
  final int? estDays;
  final String? currency;

  ShipWithMoyen({
    this.id,
    this.type,
    this.charges,
    this.estDays,
    this.currency,
  });

  factory ShipWithMoyen.fromJson(Map<String, dynamic> json) {
    return ShipWithMoyen(
      id: json['id'],
      type: json['type'],
      charges: json['charges'].toDouble(),
      estDays: json['est_days'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'charges': charges,
      'est_days': estDays,
      'currency': currency,
    };
  }
}

class Service {
  String? name;
  String? description;
  num? cost;
  String? shopName;
  int? checkout;
  String? thumbnail;

  Service({
    this.name,
    this.description,
    this.cost,
    this.shopName,
    this.checkout,
    this.thumbnail,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      description: json['description'],
      cost: json['cost'],
      shopName: json['shop_name'],
      checkout: json['checkout'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'cost': cost,
      'shop_name': shopName,
      'checkout': checkout,
      'thumbnail': thumbnail,
    };
  }
}
