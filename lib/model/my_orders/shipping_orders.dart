class ShippingOrders {
   int? id;
   String? trackingId;
   int? userId;
   dynamic tempUserId;
   String? shipType;
   String? itemType;
   String? shipVia;
   String? fromName;
   String? fromEmail;
   String? fromPhone;
   String? fromCountryId;
   String? fromStateId;
   String? fromCityId;
   String? fromPostalCode;
   dynamic fromBusinessEmail;
   dynamic fromBusinessPhone;
   String? fromAddress1;
   String? fromAddress2;
   String? toName;
   String? toEmail;
   String? toPhone;
   String? toCountryId;
   String? toStateId;
   String? toCityId;
   String? toPostalCode;
   dynamic toBusinessEmail;
   dynamic toBusinessPhone;
   String? toAddress1;
   String? toAddress2;
   dynamic weight;
   dynamic length;
   dynamic width;
   dynamic height;
   dynamic quantity;
   String? description;
   String? valueOfItems;
   String? shipmentDate;
   int? shippingCost;
   int? deliveryDays;
   int? duties;
   int? tax;
   int? fuelSurcharge;
   int? totalCost;
   String? currency;
   int? isCustomerPaid;
   String? paidAmount;
   String? paymentMethod;
   dynamic paymentDetails;
   List<String>? bankTransferProofImage;
   String? status;
   String? customerStatus;
   String? orderStatus;
  DateTime? createdAt;
   String? updatedAt;
   dynamic transactionId;

  ShippingOrders({
     this.id,
     this.trackingId,
     this.userId,
     this.tempUserId,
     this.shipType,
     this.itemType,
     this.shipVia,
     this.fromName,
     this.fromEmail,
     this.fromPhone,
     this.fromCountryId,
     this.fromStateId,
     this.fromCityId,
     this.fromPostalCode,
     this.fromBusinessEmail,
     this.fromBusinessPhone,
     this.fromAddress1,
     this.fromAddress2,
     this.toName,
     this.toEmail,
     this.toPhone,
     this.toCountryId,
     this.toStateId,
     this.toCityId,
     this.toPostalCode,
     this.toBusinessEmail,
     this.toBusinessPhone,
     this.toAddress1,
     this.toAddress2,
     this.weight,
     this.length,
     this.width,
     this.height,
     this.quantity,
     this.description,
     this.valueOfItems,
     this.shipmentDate,
     this.shippingCost,
     this.deliveryDays,
     this.duties,
     this.tax,
     this.fuelSurcharge,
     this.totalCost,
     this.currency,
     this.isCustomerPaid,
     this.paidAmount,
     this.paymentMethod,
     this.paymentDetails,
     this.bankTransferProofImage,
     this.status,
     this.customerStatus,
     this.orderStatus,
     this.createdAt,
     this.updatedAt,
     this.transactionId,
  });

  factory ShippingOrders.fromJson(Map<String, dynamic> json) {
     DateTime? createdAt = DateTime.tryParse(json['created_at']);
    return ShippingOrders(
      id: json['id'],
      trackingId: json['tracking_id'],
      userId: json['user_id'],
      tempUserId: json['temp_user_id'],
      shipType: json['ship_type'],
      itemType: json['item_type'],
      shipVia: json['ship_via'],
      fromName: json['from_name'],
      fromEmail: json['from_email'],
      fromPhone: json['from_phone'],
      fromCountryId: json['from_country_id'],
      fromStateId: json['from_state_id'],
      fromCityId: json['from_city_id'],
      fromPostalCode: json['from_postal_code'],
      fromBusinessEmail: json['from_bussiness_email'],
      fromBusinessPhone: json['from_bussiness_phone'],
      fromAddress1: json['from_address_1'],
      fromAddress2: json['from_address_2'],
      toName: json['to_name'],
      toEmail: json['to_email'],
      toPhone: json['to_phone'],
      toCountryId: json['to_country_id'],
      toStateId: json['to_state_id'],
      toCityId: json['to_city_id'],
      toPostalCode: json['to_postal_code'],
      toBusinessEmail: json['to_bussiness_email'],
      toBusinessPhone: json['to_bussiness_phone'],
      toAddress1: json['to_address_1'],
      toAddress2: json['to_address_2'],
      weight: json['weight'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      quantity: json['quantity'],
      description: json['description'],
      valueOfItems: json['value_of_items'],
      shipmentDate: json['shipment_date'],
      shippingCost: json['shipping_cost'],
      deliveryDays: json['delivery_days'],
      duties: json['duties'],
      tax: json['tax'],
      fuelSurcharge: json['fuel_surcharge'],
      totalCost: json['total_cost'],
      currency: json['currency'],
      isCustomerPaid: json['is_customer_paid'],
      paidAmount: json['paid_amount'],
      paymentMethod: json['payment_method'],
      paymentDetails: json['payment_details'],
      bankTransferProofImage: json['bank_transfer_proof_image'] != null
          ? List<String>.from(json['bank_transfer_proof_image'])
          : null,
      status: json['status'],
      customerStatus: json['customer_status'],
      orderStatus: json['order_status'],
      createdAt: createdAt,
      updatedAt: json['updated_at'],
      transactionId: json['transaction_id'],
    );
  }
}
