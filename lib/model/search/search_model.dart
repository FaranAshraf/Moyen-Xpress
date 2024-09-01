class ProductResponse {
  final bool? isSuccess;
  final String? message;
  final String? failReason;
  final String? failReasonContent;
  final List<ProductSearch>? successContents;

  ProductResponse({
    this.isSuccess,
    this.message,
    this.failReason,
    this.failReasonContent,
    this.successContents,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      isSuccess: json['isSuccess'],
      message: json['message'],
      failReason: json['failReason'],
      failReasonContent: json['failReasonContent'],
      successContents: json['successContents'] != null
          ? (json['successContents'] as List)
              .map((item) => ProductSearch.fromJson(item))
              .toList()
          : null,
    );
  }
}

class ProductSearch {
  final int? id;
  final String? name;
  final num? unitPrice;
  final String? photos;

  ProductSearch({
    this.id,
    this.name,
    this.unitPrice,
    this.photos,
  });

  factory ProductSearch.fromJson(Map<String, dynamic> json) {
    return ProductSearch(
      id: json['id'],
      name: json['title'],
      photos: json['image'],
      unitPrice: json['price'],
    );
  }
}

// class Thumbnail {
//   final int? id;
//   final String? fileOriginalName;
//   final String? fileName;
//   final int? userId;
//   final int? fileSize;
//   final String? extension;
//   final String? type;
//   final dynamic externalLink;
//   final String? createdAt;
//   final String? updatedAt;
//   final dynamic deletedAt;

//   Thumbnail({
//     this.id,
//     this.fileOriginalName,
//     this.fileName,
//     this.userId,
//     this.fileSize,
//     this.extension,
//     this.type,
//     this.externalLink,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });

//   factory Thumbnail.fromJson(Map<String, dynamic> json) {
//     return Thumbnail(
//       id: json['id'],
//       fileOriginalName: json['file_original_name'],
//       fileName: json['file_name'],
//       userId: json['user_id'],
//       fileSize: json['file_size'],
//       extension: json['extension'],
//       type: json['type'],
//       externalLink: json['external_link'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       deletedAt: json['deleted_at'],
//     );
//   }
// }

class SearchProducts {
  final List<SearchPro>? products;
  final List<SearchCat>? categories;
  final List<String>? keywords;
  final List<SearchShop>? shops;

  SearchProducts({
    this.products,
    this.categories,
    this.keywords,
    this.shops,
  });

  factory SearchProducts.fromJson(Map<String, dynamic> json) {
    return SearchProducts(
      products: (json['products'] as List<dynamic>?)
          ?.map((item) => SearchPro.fromJson(item))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((item) => SearchCat.fromJson(item))
          .toList(),
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      shops: (json['shops'] as List<dynamic>?)
          ?.map((item) => SearchShop.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products?.map((item) => item.toJson()).toList(),
      'categories': categories?.map((item) => item.toJson()).toList(),
      'keywords': keywords,
      'shops': shops?.map((item) => item.toJson()).toList(),
    };
  }
}

class SearchPro {
  final int? id;
  final String? name;
  final double? unitPrice;
  String? currency;
  num? discount;
  String? discount_type;
  String? discount_currency;
  List<Taxes>? taxes;
  final String? thumbnailImg;

  SearchPro({
    this.id,
    this.name,
    this.unitPrice,
    this.thumbnailImg,
    this.currency,
    this.discount,
    this.discount_type,
    this.discount_currency,
    this.taxes,
  });

  factory SearchPro.fromJson(Map<String, dynamic> json) {
    return SearchPro(
      id: json['id'],
      name: json['name'],
      unitPrice: json['unit_price']?.toDouble(),
      thumbnailImg: json['thumbnail_img'],
      currency: json['currency'] as String?,
      discount: json['discount']==null? 0: json['discount'] as num?,
      discount_type: json['discount_type'] as String?,
      discount_currency: json['discount_currency'] as String?,
      taxes: (json['taxes'] as List<dynamic>?)
          ?.map((taxJson) => Taxes.fromJson(taxJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit_price': unitPrice,
      'thumbnail_img': thumbnailImg,
    };
  }
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



class SearchCat {
  final int? id;
  final String? name;
  final String? icon;

  SearchCat({
    this.id,
    this.name,
    this.icon,
  });

  factory SearchCat.fromJson(Map<String, dynamic> json) {
    return SearchCat(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}

class SearchShop {
  final int? id;
  final String? name;
  final String? address;
  final String? logo;

  SearchShop({
    this.id,
    this.name,
    this.address,
    this.logo,
  });

  factory SearchShop.fromJson(Map<String, dynamic> json) {
    return SearchShop(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'logo': logo,
    };
  }
}
