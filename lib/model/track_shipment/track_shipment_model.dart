
class TrackShipment {
  String? trackingId;
  String? description;
  String? valueOfParcel;
  String? shipmentVia;
  String? shipmentStatus;
  List<ShippingQuoteProduct>? shippingQuoteProducts;
  Location? from;
  Location? to;

  TrackShipment({
     this.trackingId,
     this.description,
     this.valueOfParcel,
     this.shipmentVia,
     this.shipmentStatus,
     this.shippingQuoteProducts,
     this.from,
     this.to,
  });

  factory TrackShipment.fromJson(Map<String, dynamic> json) {
    var shippingQuoteProductsList = json['shipping_quote_products'] as List;
    List<ShippingQuoteProduct> products = shippingQuoteProductsList
        .map((productJson) => ShippingQuoteProduct.fromJson(productJson))
        .toList();

    return TrackShipment(
      trackingId: json['tracking_id'],
      description: json['description'],
      valueOfParcel: json['Value of Parcel'],
      shipmentVia: json['Shipment Via'],
      shipmentStatus: json['Shipment Status'],
      shippingQuoteProducts: products,
      from: Location.fromJson(json['from']),
      to: Location.fromJson(json['to']),
    );
  }
}

class ShippingQuoteProduct {
  num? id;
  num? shippingQuoteId;
  String? productName;
  String? weight;
  String? length;
  String? width;
  String? height;
  num? quantity;
  String? createdAt;
  String? updatedAt;

  ShippingQuoteProduct({
     this.id,
     this.shippingQuoteId,
     this.productName,
     this.weight,
     this.length,
     this.width,
     this.height,
     this.quantity,
     this.createdAt,
     this.updatedAt,
  });

  factory ShippingQuoteProduct.fromJson(Map<String, dynamic> json) {
    return ShippingQuoteProduct(
      id: json['id'],
      shippingQuoteId: json['shipping_quote_id'],
      productName: json['product_name'],
      weight: json['weight'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Location {
  String? city;
  String? state;
  String? country;

  Location({
     this.city,
     this.state,
     this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }
}
