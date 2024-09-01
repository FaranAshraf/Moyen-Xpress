class ShippingQuoteDetailModel {
  bool isSuccess;
  String? failReason;
  String? failReasonContent;
  QuoteDetail? quoteDetail;

  ShippingQuoteDetailModel({
    required this.isSuccess,
    this.failReason,
    this.failReasonContent,
    this.quoteDetail,
  });

 factory ShippingQuoteDetailModel.fromJson(Map<String, dynamic> json) {
  return ShippingQuoteDetailModel(
    isSuccess: json['isSuccess'] ?? false,
    failReason: json['failReason'],
    failReasonContent: json['failReasonContent'],
    quoteDetail: json['QuoteDetail'] != null
        ? QuoteDetail.fromJson(json['QuoteDetail'])
        : null,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'failReason': failReason,
      'failReasonContent': failReasonContent,
      'QuoteDetail': quoteDetail?.toJson(),
    };
  }
}

class QuoteDetail {
  int? id;
  String? trackingId;
  int? userId;
  int? tempUserId;
  String? shipType;
  String? itemType;
  // String? shipVia;
  String? fromName;
  String? fromEmail;
  String? fromPhone;
  String? fromCountryId;
  String? fromStateId;
  String? fromCityId;
  String? fromPostalCode;
  // String? fromBussinessEmail;
  // String? fromBussinessPhone;
  String? fromAddress1;
  String? fromAddress2;
  String? toName;
  String? toEmail;
  String? toPhone;
  String? toCountryId;
  String? toStateId;
  String? toCityId;
  String? toPostalCode;
  String? toBussinessEmail;
  String? toBussinessPhone;
  String? toAddress1;
  String? toAddress2;
  // String? weight;
  // String? length;
  // String? width;
  // String? height;
  // int? quantity;
  // String? description;
  // String? valueOfItems;
  String? shipmentDate;
  // double? shippingCost;
  // int? deliveryDays;
  // String? duties;
  // String? tax;
  // String? fuelSurcharge;
  // double? totalCost;
  // String? currency;
  int? isCustomerPaid;
  // String? paidAmount;
  // String? paymentMethod;
  // String? paymentDetails;
  // String? bankTransferProofImage;
  // String? status;
  // String? customerStatus;
  // String? orderStatus;
  // String? createdAt;
  // String? updatedAt;
  // String? transactionId;
  List<Product>? products;

  QuoteDetail({
     this.id,
     this.trackingId,
     this.userId,
    this.tempUserId,
     this.shipType,
     this.itemType,
    //  this.shipVia,
     this.fromName,
     this.fromEmail,
     this.fromPhone,
     this.fromCountryId,
     this.fromStateId,
     this.fromCityId,
     this.fromPostalCode,
    //  this.fromBussinessEmail,
    //  this.fromBussinessPhone,
     this.fromAddress1,
     this.fromAddress2,
     this.toName,
     this.toEmail,
     this.toPhone,
     this.toCountryId,
     this.toStateId,
     this.toCityId,
     this.toPostalCode,
     this.toBussinessEmail,
     this.toBussinessPhone,
     this.toAddress1,
     this.toAddress2,
    // this.weight,
    // this.length,
    // this.width,
    // this.height,
    // this.quantity,
    //  this.description,
    //  this.valueOfItems,
     this.shipmentDate,
    //  this.shippingCost,
    //  this.deliveryDays,
    // this.duties,
    // this.tax,
    // this.fuelSurcharge,
    //  this.totalCost,
    //  this.currency,
     this.isCustomerPaid,
    // this.paidAmount,
    // this.paymentMethod,
    // this.paymentDetails,
    // this.bankTransferProofImage,
    //  this.status,
    //  this.customerStatus,
    //  this.orderStatus,
    //  this.createdAt,
    //  this.updatedAt,
    // this.transactionId,
     this.products,
  });

  factory QuoteDetail.fromJson(Map<String, dynamic> json) {
    return QuoteDetail(
      id: json['id'],
      trackingId: json['tracking_id'],
      userId: json['user_id'],
      tempUserId: json['temp_user_id'],
      shipType: json['ship_type'],
      itemType: json['item_type'],
      // shipVia: json['ship_via'],
      fromName: json['from_name'],
      fromEmail: json['from_email'],
      fromPhone: json['from_phone'],
      fromCountryId: json['from_country_id'],
      fromStateId: json['from_state_id'],
      fromCityId: json['from_city_id'],
      fromPostalCode: json['from_postal_code'],
      // fromBussinessEmail: json['from_bussiness_email'],
      // fromBussinessPhone: json['from_bussiness_phone'],
      fromAddress1: json['from_address_1'],
      fromAddress2: json['from_address_2'],
      toName: json['to_name'],
      toEmail: json['to_email'],
      toPhone: json['to_phone'],
      toCountryId: json['to_country_id'],
      toStateId: json['to_state_id'],
      toCityId: json['to_city_id'],
      toPostalCode: json['to_postal_code'],
      toBussinessEmail: json['to_bussiness_email'],
      toBussinessPhone: json['to_bussiness_phone'],
      toAddress1: json['to_address_1'],
      toAddress2: json['to_address_2'],
      // weight: json['weight'],
      // length: json['length'],
      // width: json['width'],
      // height: json['height'],
      // quantity: json['quantity'],
      // description: json['description'],
      // valueOfItems: json['value_of_items'],
      shipmentDate: json['shipment_date'],
      // shippingCost: json['shipping_cost'].toDouble(),
      // deliveryDays: int.tryParse(json['delivery_days'].toString()),
      // duties: json['duties'],
      // tax: json['tax'],
      // fuelSurcharge: json['fuel_surcharge'],
      // totalCost: json['total_cost'].toDouble(),
      // currency: json['currency'],
      isCustomerPaid: json['is_customer_paid'],
      // paidAmount: json['paid_amount'],
      // paymentMethod: json['payment_method'],
      // paymentDetails: json['payment_details'],
      // bankTransferProofImage: json['bank_transfer_proof_image'],
      // status: json['status'],
      // customerStatus: json['customer_status'],
      // orderStatus: json['order_status'],
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
      // transactionId: json['transaction_id'],
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tracking_id': trackingId,
      'user_id': userId,
      'temp_user_id': tempUserId,
      'ship_type': shipType,
      'item_type': itemType,
      // 'ship_via': shipVia,
      'from_name': fromName,
      'from_email': fromEmail,
      'from_phone': fromPhone,
      'from_country_id': fromCountryId,
      'from_state_id': fromStateId,
      'from_city_id': fromCityId,
      'from_postal_code': fromPostalCode,
      // 'from_bussiness_email': fromBussinessEmail,
      // 'from_bussiness_phone': fromBussinessPhone,
      'from_address_1': fromAddress1,
      'from_address_2': fromAddress2,
      'to_name': toName,
      'to_email': toEmail,
      'to_phone': toPhone,
      'to_country_id': toCountryId,
      'to_state_id': toStateId,
      'to_city_id': toCityId,
      'to_postal_code': toPostalCode,
      'to_bussiness_email': toBussinessEmail,
      'to_bussiness_phone': toBussinessPhone,
      'to_address_1': toAddress1,
      'to_address_2': toAddress2,
      // 'weight': weight,
      // 'length': length,
      // 'width': width,
      // 'height': height,
      // 'quantity': quantity,
      // 'description': description,
      // 'value_of_items': valueOfItems,
      'shipment_date': shipmentDate,
      // 'shipping_cost': shippingCost,
      // 'delivery_days': deliveryDays,
      // 'duties': duties,
      // 'tax': tax,
      // 'fuel_surcharge': fuelSurcharge,
      // 'total_cost': totalCost,
      // 'currency': currency,
      'is_customer_paid': isCustomerPaid,
      // 'paid_amount': paidAmount,
      // 'payment_method': paymentMethod,
      // 'payment_details': paymentDetails,
      // 'bank_transfer_proof_image': bankTransferProofImage,
      // 'status': status,
      // 'customer_status': customerStatus,
      // 'order_status': orderStatus,
      // 'created_at': createdAt,
      // 'updated_at': updatedAt,
      // 'transaction_id': transactionId,
      'products': products?.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  int? id;
  int? shippingQuoteId;
  String? productName;
  String? weight;
  String? length;
  String? width;
  String? height;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) { 
    return Product(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shipping_quote_id': shippingQuoteId,
      'product_name': productName,
      'weight': weight,
      'length': length,
      'width': width,
      'height': height,
      'quantity': quantity,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
