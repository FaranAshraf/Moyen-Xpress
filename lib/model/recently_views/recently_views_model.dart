// ignore_for_file: public_member_api_docs, sort_constructors_first

class RecentlyViewsModel {
  num? id;
  String? date;
  String? productName;
  String? productImage;
  String? sellerName;

  RecentlyViewsModel({
    this.id,
    this.date,
    this.productName,
    this.productImage,
    this.sellerName,
  });

  static List<RecentlyViewsModel> listFromJson(List? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((e) => RecentlyViewsModel.fromJson(e)).toList();
  }

  factory RecentlyViewsModel.fromJson(Map<String, dynamic> json) {
    return RecentlyViewsModel(
      id: json['id'],
      date: json['date'],
      productName: json['product_name'],
      productImage: json['product_image'],
      sellerName: json['seller_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'product_name': productName,
      'product_image': productImage,
      'seller_name': sellerName,
    };
  }
}

class RecentViewData {
  List<RecentlyViewsModel>? recentView;
  num? cartCount;
  num? wishListCount;
  num? totalProducts;
  String? cartMessage;
  String? wishListMessage;
  String? orderedMessage;

  RecentViewData({
    this.recentView,
    this.cartCount,
    this.wishListCount,
    this.totalProducts,
    this.cartMessage,
    this.wishListMessage,
    this.orderedMessage,
  });

  factory RecentViewData.fromJson(Map<String, dynamic> json) {
    return RecentViewData(
      recentView: RecentlyViewsModel.listFromJson(json['recent_views']),
      cartCount: json['cart_count'],
      wishListCount: json['wishlist_count'],
      totalProducts: json['total_ordered_products'],
      cartMessage: json['cart_message'],
      wishListMessage: json['wishlist_message'],
      orderedMessage: json['ordered_message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recent_views': recentView?.map((e) => e.toJson()).toList(),
      'cart_count': cartCount,
      'wishlist_count': wishListCount,
      'total_ordered_products': totalProducts,
      'cart_message': cartMessage,
      'wishlist_message': wishListMessage,
      'ordered_message': orderedMessage,
    };
  }
}
