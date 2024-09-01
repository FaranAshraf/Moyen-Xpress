class QuoteOrdersModel {
  int? id;
  String? quoteID;
  String? quoteDate;
  String? size;
  String? adminApproval;
  String? paymentStatus;
  String? pickUpDate;
  List<QuoteProImages>? productImages;
  ShipmentDetailFrom? shipmentDetailFrom;
  ShipmentDetailTo? shipmentDetailTo;
  PackageDescription? pkgDescription;
  ShipmentCostDetail? shipmentCostDetail;

  QuoteOrdersModel({
    this.id,
    this.quoteID,
    this.quoteDate,
    this.size,
    this.adminApproval,
    this.paymentStatus,
    this.pickUpDate,
    this.productImages,
    this.shipmentDetailFrom,
    this.shipmentDetailTo,
    this.pkgDescription,
    this.shipmentCostDetail,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'quoteID': quoteID,
      'quoteDate': quoteDate,
      'size': size,
      'adminApproval': adminApproval,
      'paymentStatus': paymentStatus,
      'pickUpDate': pickUpDate,
      'productImages': QuoteProImages.listToJson(productImages ?? []),
      'shipmentDetailFrom': shipmentDetailFrom?.toJson(),
      'shipmentDetailTo': shipmentDetailTo?.toJson(),
      'pkgDescription': pkgDescription?.toJson(),
      'shipmentCostDetail': shipmentCostDetail?.toJson(),
    };
  }

factory QuoteOrdersModel.fromJson(Map<String, dynamic> json) {
  return QuoteOrdersModel(
    id: json['id'] as int?,
    quoteID: json['quoteID'] as String?,
    quoteDate: json['quoteDate'] as String?,
    size: json['size'] as String?,
    adminApproval: json['adminApproval'] as String?,
    paymentStatus: json['paymentStatus'] as String?,
    pickUpDate: json['pickUpDate'] as String?,
    productImages: QuoteProImages.listFromJson(json['productImages'] ?? []),
    shipmentDetailFrom: ShipmentDetailFrom.fromJson(json['shipmentDetailFrom'] ?? {}),
    shipmentDetailTo: ShipmentDetailTo.fromJson(json['shipmentDetailTo'] ?? {}),
    pkgDescription: PackageDescription.fromJson(json['pkgDescription'] ?? {}),
    shipmentCostDetail: ShipmentCostDetail.fromJson(json['shipmentCostDetail'] ?? {}),
  );
}

  QuoteOrdersModel copyWith({
    int? id,
    String? quoteID,
    String? quoteDate,
    String? size,
    String? adminApproval,
    String? paymentStatus,
    List<QuoteProImages>? productImages,
    ShipmentDetailFrom? shipmentDetailFrom,
    ShipmentDetailTo? shipmentDetailTo,
    PackageDescription? pkgDescription,
    ShipmentCostDetail? shipmentCostDetail,
  }) {
    return QuoteOrdersModel(
      id: id ?? this.id,
      quoteID: quoteID ?? this.quoteID,
      quoteDate: quoteDate ?? this.quoteDate,
      size: size ?? this.size,
      adminApproval: adminApproval ?? this.adminApproval,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      productImages: productImages ?? this.productImages,
      shipmentDetailFrom: shipmentDetailFrom ?? this.shipmentDetailFrom,
      shipmentDetailTo: shipmentDetailTo ?? this.shipmentDetailTo,
      pkgDescription: pkgDescription ?? this.pkgDescription,
      shipmentCostDetail: shipmentCostDetail ?? this.shipmentCostDetail,
    );
  }
}

class QuoteProImages {
  int? id;
  String? imageUrl;

  QuoteProImages({this.id, this.imageUrl});

  static List<QuoteProImages> listFromJson(List jsonList) {
    return jsonList.map((e) => QuoteProImages.fromJson(e as Map<String, dynamic>)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<QuoteProImages> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  factory QuoteProImages.fromJson(Map<String, dynamic> json) {
    return QuoteProImages(
      id: json['id'] as int?,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}

class ShipmentCostDetail {
  int? deliveryDays;
  String? duties;
  String? shippingCost;
  String? tax;
  String? fuelSurcharges;
  String? totalCost;
  String? paymentStatus;

  ShipmentCostDetail({
    this.deliveryDays,
    this.duties,
    this.shippingCost,
    this.tax,
    this.fuelSurcharges,
    this.totalCost,
    this.paymentStatus,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'deliveryDays': deliveryDays,
      'duties': duties,
      'shippingCost': shippingCost,
      'tax': tax,
      'fuelSurcharges': fuelSurcharges,
      'totalCost': totalCost,
      'paymentStatus': paymentStatus,
    };
  }

  factory ShipmentCostDetail.fromJson(Map<String, dynamic> json) {
    return ShipmentCostDetail(
      deliveryDays: json['deliveryDays'] as int?,
      duties: json['duties'] as String?,
      shippingCost: json['shippingCost'] as String?,
      tax: json['tax'] as String?,
      fuelSurcharges: json['fuelSurcharges'] as String?,
      totalCost: json['totalCost'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
    );
  }
}

class PackageDescription {
  String? productName;
  String? boxSize;
  int? quantity;
  String? weight;

  PackageDescription({
    this.productName,
    this.boxSize,
    this.quantity,
    this.weight,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'productName': productName,
      'boxSize': boxSize,
      'quantity': quantity,
      'weight': weight,
    };
  }

  factory PackageDescription.fromJson(Map<String, dynamic> json) {
    return PackageDescription(
      productName: json['productName'] as String?,
      boxSize: json['boxSize'] as String?,
      quantity: json['quantity'] as int?,
      weight: json['weight'] as String?,
    );
  }
}

class ShipmentDetailFrom {
  String? fullName;
  String? email;
  String? country;
  String? state;
  String? city;
  String? postalCode;
  String? phoneNumber;
  String? address1;
  String? address2;

  ShipmentDetailFrom({
    this.fullName,
    this.email,
    this.country,
    this.state,
    this.city,
    this.postalCode,
    this.phoneNumber,
    this.address1,
    this.address2,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'country': country,
      'state': state,
      'city': city,
      'postalCode': postalCode,
      'phoneNumber': phoneNumber,
      'address1': address1,
      'address2': address2,
    };
  }

  factory ShipmentDetailFrom.fromJson(Map<String, dynamic> json) {
  return ShipmentDetailFrom(
    fullName: json['fullName'] as String?,
    email: json['email'] as String?,
    country: json['country'] as String?,
    state: json['state'] as String?,
    city: json['city'] as String?,
    postalCode: json['postalCode'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    address1: json['address1'] as String?,
    address2: json['address2'] as String?,
  );
}
}

class ShipmentDetailTo {
  String? fullNameTo;
  String? emailTo;
  String? countryTo;
  String? stateTo;
  String? cityTo;
  String? postalCodeTo;
  String? phoneNumberTo;
  String? address1To;
  String? address2To;

  ShipmentDetailTo({
    this.fullNameTo,
    this.emailTo,
    this.countryTo,
    this.stateTo,
    this.cityTo,
    this.postalCodeTo,
    this.phoneNumberTo,
    this.address1To,
    this.address2To,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fullNameTo': fullNameTo,
      'emailTo': emailTo,
      'countryTo': countryTo,
      'stateTo': stateTo,
      'cityTo': cityTo,
      'postalCodeTo': postalCodeTo,
      'phoneNumberTo': phoneNumberTo,
      'address1To': address1To,
      'address2To': address2To,
    };
  }

  factory ShipmentDetailTo.fromJson(Map<String, dynamic> json) {
  return ShipmentDetailTo(
    fullNameTo: json['fullNameTo'] as String?,
    emailTo: json['emailTo'] as String?,
    countryTo: json['countryTo'] as String?,
    stateTo: json['stateTo'] as String?,
    cityTo: json['cityTo'] as String?,
    postalCodeTo: json['postalCodeTo'] as String?,
    phoneNumberTo: json['phoneNumberTo'] as String?,
    address1To: json['address1To'] as String?,
    address2To: json['address2To'] as String?,
  );
}
}
