class WishList {
  final bool isSuccess;
  final String? failReason;
  final dynamic failReasonContent;
  final List<WishItem> successContents;

  WishList({
    required this.isSuccess,
    required this.failReason,
    required this.failReasonContent,
    required this.successContents,
  });

  factory WishList.fromJson(Map<String, dynamic> json) {
    return WishList(
      isSuccess: json['isSuccess'],
      failReason: json['failReason'],
      failReasonContent: json['failReasonContent'],
      successContents: List<WishItem>.from(
          json['successContents'].map((item) => WishItem.fromJson(item))),
    );
  }
}

class WishItem {
  final String? storeName;

  final WishItemProduct? product;
  final int? id;
  WishItem({required this.product, required this.id, required this.storeName});

  factory WishItem.fromJson(Map<String, dynamic> json) {
    return WishItem(
      id: json['id'],
      storeName: json['store_name'],
      product: WishItemProduct.fromJson(json['product']),
    );
  }
}

class WishItemProduct {
  final int? id;
  final String? name;
  final num? unitPrice;
  final String? thumbnailImg;

  WishItemProduct({
    required this.id,
    required this.name,
    required this.unitPrice,
    required this.thumbnailImg,
  });

  factory WishItemProduct.fromJson(Map<String, dynamic> json) {
    return WishItemProduct(
      id: json['id'],
      name: json['name'],
      unitPrice: json['unit_price'],
      thumbnailImg: json['thumbnail_img'],
    );
  }
}
