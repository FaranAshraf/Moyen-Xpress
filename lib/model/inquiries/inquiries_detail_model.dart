class InquiryDetailCheck {
  final InquiryDetailModel? successContents;
  InquiryDetailCheck({
    this.successContents,
  });

  factory InquiryDetailCheck.fromJson(Map<String, dynamic> json) {
    return InquiryDetailCheck(
      successContents: json['successContents'] != null
          ? InquiryDetailModel.fromJson(json['successContents'])
          : null,
    );
  }
}


class InquiryDetailModel {
   num? id;
   String? productName;
   num? productQty;
   num? pricePerUnit;
   num? totalPrice;
   num? deliveryCharges;
   num? deliveryDays;
   String? deliveryAddress;
   String? userNote;
   String? sellerNote;
   num? isSellerReplied;

  InquiryDetailModel({
     this.id,
     this.productName,
     this.productQty,
     this.pricePerUnit,
     this.totalPrice,
     this.deliveryCharges,
     this.deliveryDays,
     this.deliveryAddress,
     this.userNote,
     this.sellerNote,
     this.isSellerReplied,
  });

  factory InquiryDetailModel.fromJson(Map<String, dynamic> json) {
    return InquiryDetailModel(
      id: json['id'],
      productName: json['product_name'],
      productQty: json['product_qty'],
      pricePerUnit: json['price_per_unit'],
      totalPrice: json['total_price'],
      deliveryCharges: json['delivery_charges'],
      deliveryDays: json['delivery_days'],
      deliveryAddress: json['delivery_address'],
      userNote: json['user_note'],
      sellerNote: json['seller_note'],
      isSellerReplied: json['is_seller_replied'],
    );
  }
}
