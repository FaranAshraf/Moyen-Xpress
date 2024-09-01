class QuotationHistoryData {
  int? id;
  String? date;
  String? productName;
  int? quantity;
  String? quantityType;
  String? description;
  String? deliveryAddress;
  String? status;
  int? quoteOrderId;

  QuotationHistoryData({
    this.id,
    this.date,
    this.productName,
    this.quantity,
    this.quantityType,
    this.description,
    this.deliveryAddress,
    this.status,
    this.quoteOrderId,
  });

  factory QuotationHistoryData.fromJson(Map<String, dynamic> json) {
    return QuotationHistoryData(
      id: json['id'],
      date: json['date'],
      productName: json['product_name'],
      quantity: json['quantity'],
      quantityType: json['quantity_type'],
      description: json['description'],
      deliveryAddress: json['delivery_address'],
      status: json['status'],
      quoteOrderId: json['quote_order_id'],
    );
  }
}


