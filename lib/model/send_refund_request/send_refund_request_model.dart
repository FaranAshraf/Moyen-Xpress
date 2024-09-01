class SendRequestModel {
   num? id;
   String? date;
   String? orderId;
   String? product;
   String? amount;
   String? refundType;
   String? warehouseAddress;
   String? dropOffStatus;
   num? quantity;
   String? quantityType;
   String? status;

  SendRequestModel({
     this.id,
     this.date,
     this.orderId,
     this.product,
     this.amount,
     this.refundType,
     this.warehouseAddress,
     this.dropOffStatus,
     this.quantity,
     this.quantityType,
     this.status,
  });

  factory SendRequestModel.fromJson(Map<String, dynamic> json) {
    return SendRequestModel(
      id: json['id'],
      date: json['date'],
      orderId: json['order_id'],
      product: json['product'],
      amount: json['amount'],
      refundType: json['refund_type'],
      warehouseAddress: json['warehouse_address'],
      dropOffStatus: json['drop_off_status'],
      quantity: json['quantity'],
      quantityType: json['quantity_type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'order_id': orderId,
      'product': product,
      'amount': amount,
      'refund_type': refundType,
      'warehouse_address': warehouseAddress,
      'drop_off_status': dropOffStatus,
      'quantity': quantity,
      'quantity_type': quantityType,
      'status': status,
    };
  }
}
