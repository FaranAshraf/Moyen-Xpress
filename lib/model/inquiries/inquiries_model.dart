class Inquiries {
   num? id;
   num? productId;
   String? productVariation;
   num? userId;
   num? sellerId;
   num? productQty;
   String? deliveryAddress;
   String? userNote;
   num? pricePerUnit;
   num? totalPrice;
   num? deliveryCharges;
   num? deliveryDays;
   String? sellerNote;
   num? isSellerReplied;
   num? isOrdered;
   num? seen;
   DateTime? createdAt;
   DateTime? updatedAt;
   String? deliveryCountry;
   String? deliveryState;
   String? deliveryCity;
   String? productName;

  Inquiries({
     this.id,
     this.productId,
     this.productVariation,
     this.userId,
     this.sellerId,
     this.productQty,
     this.deliveryAddress,
    this.userNote,
     this.pricePerUnit,
     this.totalPrice,
     this.deliveryCharges,
     this.deliveryDays,
     this.sellerNote,
     this.isSellerReplied,
     this.isOrdered,
     this.seen,
     this.createdAt,
     this.updatedAt,
     this.deliveryCountry,
     this.deliveryState,
     this.deliveryCity,
     this.productName,
  });

  // Factory method to parse JSON into Dart object
  factory Inquiries.fromJson(Map<String, dynamic> json) {
    return Inquiries(
      id: json['id'],
      productId: json['product_id'],
      productVariation: json['product_variation'] ?? '',
      userId: json['user_id'],
      sellerId: json['seller_id'],
      productQty: json['product_qty'],
      deliveryAddress: json['delivery_address'],
      userNote: json['user_note'],
      pricePerUnit: json['price_per_unit'],
      totalPrice: json['total_price'],
      deliveryCharges: json['delivery_charges'],
      deliveryDays: json['delivery_days'],
      sellerNote: json['seller_note'],
      isSellerReplied: json['is_seller_replied'],
      isOrdered: json['is_ordered'],
      seen: json['seen'],
       createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: DateTime.parse(json['updated_at']),
      deliveryCountry: json['delivery_country'],
      deliveryState: json['delivery_state'],
      deliveryCity: json['delivery_city'],
      productName: json['product_name'],
    );
  }
}