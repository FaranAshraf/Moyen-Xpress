// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moyen_express/model/store/store_model.dart';

class ListViewModel {
  int? id;
  // int? discountPer;
  String? image;
  String? title;
  double? price;
  double? rating;
  String? tag;
  num? qty;
  num? stock;
  num? minimumQty;
  String? currency;
  num? discount;
  String? discount_type;
  String? discount_currency;
  
  List<Taxes>? taxes;

  ListViewModel(
      {this.id,
      // this.discountPer,
      this.image,
      this.title,
      this.price,
      this.rating,
      this.tag,
      this.qty,
      this.stock,
      this.minimumQty,
      this.currency,
      this.discount,
      this.discount_type,
      this.discount_currency,
      this.taxes,
      });

  static List<ListViewModel> listFromJson(List jsonList) {
    return jsonList.map((e) => ListViewModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<ListViewModel> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      // 'discountPer': discountPer,
      'image': image,
      'title': title,
      'price': price,
      'rating': rating,
      'tag': tag,
      'qty': qty,
      'stock': stock,
      'min_qty': minimumQty,
      'currency': currency,
    };
  }

  factory ListViewModel.fromJson(Map<String, dynamic> json) {
    return ListViewModel(
      id: json['id'] as int?,
      // discountPer: (json['discount'] ?? 0).toInt(),
      image: json['image'] as String?,
      title: json['title'] as String?,
      price: (json['price'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      tag: json['tag'] as String?,
      qty: json['current_stock'] as int?,
      stock: json['stock'] as num?,
      minimumQty: json['min_qty'] as num?,
      currency: json['currency'] as String?,
      discount: json['discount']==null? 0: json['discount'] as num?,
      discount_type: json['discount_type'] as String?,
      discount_currency: json['discount_currency'] as String?,
      taxes: (json['taxes'] as List<dynamic>?)
          ?.map((taxJson) => Taxes.fromJson(taxJson as Map<String, dynamic>))
          .toList(),
    );
  }





  static fromStoreModel(StoreModel storeModel) {}
}

class Taxes {
  int? id;
  int? productId;
  int? taxId;
  double? tax;
  String? taxType;
  String? createdAt;
  String? updatedAt;

  Taxes({
    this.id,
    this.productId,
    this.taxId,
    this.tax,
    this.taxType,
    this.createdAt,
    this.updatedAt,
  });

  factory Taxes.fromJson(Map<String, dynamic> json) {
    return Taxes(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      taxId: json['tax_id'] as int?,
      tax: (json['tax'] as num?)?.toDouble(), // Ensuring the type is double
      taxType: json['tax_type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}