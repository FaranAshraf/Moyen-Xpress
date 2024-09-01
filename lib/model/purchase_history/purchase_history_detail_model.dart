class PurchaseHistoryDetail {
  bool? result;
  String? message;
  Order? order;
  List<OrderItem>? orderItems;

  PurchaseHistoryDetail({
    this.result,
    this.message,
    this.order,
    this.orderItems,
  });

  factory PurchaseHistoryDetail.fromJson(Map<String, dynamic> json) {
    return PurchaseHistoryDetail(
        result: json['result'],
        message: json['message'],
        order: json['order'] != null ? Order.fromJson(json['order']) : null,
        orderItems: (json['order_items'] as List)
            .map((item) => OrderItem.fromJson(item))
            .toList());
  }
}

class Order {
  int? id;
  String? purchaseDate;
  String? shippingAddress;
  String? city;
  String? country;
  String? postalCode;
  String? email;
  String? paymentStatus;
  String? deliveryStatus;
  String? paymentMethod;
  num? total; // Changed to num to accommodate decimal values
  num? subtotal; // Changed to num to accommodate decimal values
  num? shipping; // Changed to num to accommodate decimal values
  num? tax; // Changed to num to accommodate decimal values
  String? sellerName;

  Order({
    this.id,
    this.purchaseDate,
    this.shippingAddress,
    this.city,
    this.country,
    this.postalCode,
    this.email,
    this.paymentStatus,
    this.deliveryStatus,
    this.paymentMethod,
    this.total,
    this.subtotal,
    this.shipping,
    this.tax,
    this.sellerName,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      purchaseDate: json['purchase_date'],
      shippingAddress: json['shipping_address'],
      city: json['city'],
      country: json['country'],
      postalCode: json['postal_code'],
      email: json['email'],
      paymentStatus: json['payment_status'],
      deliveryStatus: json['delivery_status'],
      paymentMethod: json['payment_method'],
      total: (json['total'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
      shipping: (json['shipping'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      sellerName: json['seller_name'],
    );
  }
}

class OrderItem {
  String? thumbnailImg;
  String? productName;
  int? quantity;
  double? price; // Changed to double to accommodate decimal values

  OrderItem({
    this.thumbnailImg,
    this.productName,
    this.quantity,
    this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      thumbnailImg: json['thumbnail_img'],
      productName: json['product_name'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
