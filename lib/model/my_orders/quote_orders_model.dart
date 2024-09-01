class QuoteOrders {
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
  String? sellerName;
  String? productName;

  QuoteOrders({
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
    this.sellerName,
    this.productName,
  });

  factory QuoteOrders.fromJson(Map<String, dynamic> json) {
        DateTime? createdAt = DateTime.tryParse(json['created_at']);
    return QuoteOrders(
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
      sellerName: json['seller_name'],
      productName: json['product_name'],
    );
  }
}
