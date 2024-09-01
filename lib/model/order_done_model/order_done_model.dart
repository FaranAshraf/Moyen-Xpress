

class OrderDone {
   List<OrderItem>? orderItems;
   int? orderId;
   String? orderCode;
   DateTime? orderDate;
   String? deliveryStatus;
   String? paymentStatus;
   String? paymentType;
   num? subtotal;
   num? totalTax;
   num? totalShipping;
   num? total;
   String? userName;
   String? userEmail;
   String? shippingAddress;

  OrderDone({
    this.orderItems,
    this.orderId,
    this.orderCode,
    this.orderDate,
    this.deliveryStatus,
    this.paymentType,
    this.paymentStatus,
    this.subtotal,
    this.totalTax,
    this.totalShipping,
    this.total,
    this.userName,
    this.userEmail,
    this.shippingAddress,
  });

  factory OrderDone.fromJson(Map<String, dynamic> json) {
    DateTime? orderDate = DateTime.tryParse(json['order_date']);
    var orderItemsList = json['order_items'] as List?;
    List<OrderItem>? items;
    if (orderItemsList != null) {
      items = orderItemsList.map((itemJson) => OrderItem.fromJson(itemJson)).toList();
    }

    return OrderDone(
      orderItems: items,
      orderId: json['order_id'],
      orderCode: json['order_code'],
      orderDate: orderDate,
      deliveryStatus: json['delivery_status'],
      paymentStatus: json['payment_status'],
      paymentType: json['payment_type'],
      subtotal: json['subtotal'],
      totalTax: json['total_tax'],
      totalShipping: json['total_shipping'],
      total: json['total'],
      userName: json['user_name'],
      userEmail: json['user_email'],
      shippingAddress: json['shipping_address'],
    );
  }
}

class OrderItem {
   int? id;
   String? productType;
   String? productName;
   String? serviceName;
   String? variation;
   num? quantity;
   String? deliveryType;
   num? price;
   num? tax;
   num? shippingCost;

  OrderItem({
    this.id,
    this.productType,
    this.productName,
    this.serviceName,
    this.variation,
    this.quantity,
    this.deliveryType,
    this.price,
    this.tax,
    this.shippingCost,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      productType: json['product_type'],
      productName: json['product_name'],
      serviceName: json['service_name'],
      variation: json['variation'],
      quantity: json['quantity'],
      deliveryType: json['delivery_type'],
      price: json['price'],
      tax: json['tax'],
      shippingCost: json['shipping_cost'],
    );
  }
}
