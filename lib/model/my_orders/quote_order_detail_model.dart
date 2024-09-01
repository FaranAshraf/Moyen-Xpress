class QuoteOrderDetail {
   int? id;
   num? quoteReplyId;
   num? quoteId;
   num? sellerId;
   num? isPaid;
   num? commissionCalculated;
   String? transactionId;
   num? paidPayment;
   String? paymentType;
   String? deliveryStatus;
   DateTime? createdAt;
   DateTime? updatedAt;
   String? quoteName;
   int? quoteQuantity;
   String? deliveryAddress;
   String? userName;
   String? sellerName;
   String? userEmail;
   num? deliveryCharges;
   num? totalQuotePrice;
   num? perUnitPrice;

  QuoteOrderDetail({
     this.id,
     this.quoteReplyId,
     this.quoteId,
     this.sellerId,
     this.isPaid,
     this.commissionCalculated,
     this.transactionId,
     this.paidPayment,
     this.paymentType,
     this.deliveryStatus,
     this.createdAt,
     this.updatedAt,
     this.quoteName,
     this.quoteQuantity,
     this.deliveryAddress,
     this.userName,
     this.sellerName,
     this.userEmail,
     this.deliveryCharges,
     this.totalQuotePrice,
     this.perUnitPrice,
  });

  factory QuoteOrderDetail.fromJson(Map<String, dynamic> json) {
        DateTime? createdAt = DateTime.tryParse(json['created_at']);
  
    return QuoteOrderDetail(
      id: json['id'],
      quoteReplyId: json['quote_reply_id'],
      quoteId: json['quote_id'],
      sellerId: json['seller_id'],
      isPaid: json['is_paid'],
      commissionCalculated: json['commission_calculated'],
      transactionId: json['transaction_id'],
      paidPayment: json['paid_payment'],
      paymentType: json['payment_type'],
      deliveryStatus: json['delivery_status'],
      createdAt: createdAt,
      updatedAt: DateTime.parse(json['updated_at']),
      quoteName: json['quote_name'],
      quoteQuantity: json['quote_quantity'],
      deliveryAddress: json['delivery_address'],
      userName: json['user_name'],
      sellerName: json['seller_name'],
      userEmail: json['user_email'],
      deliveryCharges: json['delivery_charges'],
      totalQuotePrice: json['total_quote_price'],
      perUnitPrice: json['per_unit_price'],
    );
  }
}
