class ProductResponse {
  final dynamic failReason;
  final dynamic failReasonContent;
  final List<Product> successContents;

  ProductResponse({this.failReason, this.failReasonContent, required this.successContents});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var successContentsList = json['successContents'] as List;
    List<Product> products = successContentsList.map((i) => Product.fromJson(i)).toList();

    return ProductResponse(
      failReason: json['failReason'],
      failReasonContent: json['failReasonContent'],
      successContents: products,
    );
  }
}

class Product {
  final int? id;
  final String? name;
  final String? addedBy;
  final int? userId;
  final int? categoryId;
  final int? parentCategoryId;
  final dynamic brandId;
  final String? photos;
  final String? thumbnailImg;
  final dynamic videoThumbnail;
  final dynamic productVideo;
  final String? videoProvider;
  final dynamic videoLink;
  final String? tags;
  final String? description;
  final String? note;
  final int? unitPrice;
  final dynamic purchasePrice;
  final String? currency;
  final int? variantProduct;
  final String? attributes;
  final String? choiceOptions;
  final String? colors;
  final dynamic variations;
  final int? todaysDeal;
  final int? published;
  final int? approved;
  final String? stockVisibilityState;
  final int? cashOnDelivery;
  final int? isEscrow;
  final int? featured;
  final int? sellerFeatured;
  final int? currentStock;
  final String? unit;
  final int? minQty;
  final int? lowStockQuantity;
  final int? discount;
  final String? discountCurrency;
  final String? discountType;
  final dynamic discountStartDate;
  final dynamic discountEndDate;
  final int? startingBid;
  final int? minimumPlaceBidAmount;
  final dynamic auctionStartDate;
  final dynamic auctionEndDate;
  final int? winningEmailSent;
  final int? auctionTimeExtension;
  final dynamic tax;
  final dynamic taxType;
  final String? shippingType;
  final int? shippingCost;
  final int? isQuantityMultiplied;
  final dynamic estShippingDays;
  final int? numOfSale;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaImg;
  final dynamic metaImgAlt;
  final dynamic pdf;
  final String? slug;
  final int? refundable;
  final int? rating;
  final dynamic barcode;
  final int? digital;
  final dynamic auctionProduct;
  final dynamic fileName;
  final dynamic filePath;
  final dynamic externalLink;
  final String? externalLinkBtn;
  final int? wholesaleProduct;
  final String? productCondition;
  final dynamic vehicleProductCondition;
  final int? isEmailSentToCustomers;
  final dynamic thumbnailImgImported;
  final int? isImported;
  final String? createdAt;
  final String? updatedAt;
  final Thumbnail? thumbnail;

  Product({
    this.id,
    this.name,
    this.addedBy,
    this.userId,
    this.categoryId,
    this.parentCategoryId,
    this.brandId,
    this.photos,
    this.thumbnailImg,
    this.videoThumbnail,
    this.productVideo,
    this.videoProvider,
    this.videoLink,
    this.tags,
    this.description,
    this.note,
    this.unitPrice,
    this.purchasePrice,
    this.currency,
    this.variantProduct,
    this.attributes,
    this.choiceOptions,
    this.colors,
    this.variations,
    this.todaysDeal,
    this.published,
    this.approved,
    this.stockVisibilityState,
    this.cashOnDelivery,
    this.isEscrow,
    this.featured,
    this.sellerFeatured,
    this.currentStock,
    this.unit,
    this.minQty,
    this.lowStockQuantity,
    this.discount,
    this.discountCurrency,
    this.discountType,
    this.discountStartDate,
    this.discountEndDate,
    this.startingBid,
    this.minimumPlaceBidAmount,
    this.auctionStartDate,
    this.auctionEndDate,
    this.winningEmailSent,
    this.auctionTimeExtension,
    this.tax,
    this.taxType,
    this.shippingType,
    this.shippingCost,
    this.isQuantityMultiplied,
    this.estShippingDays,
    this.numOfSale,
    this.metaTitle,
    this.metaDescription,
    this.metaImg,
    this.metaImgAlt,
    this.pdf,
    this.slug,
    this.refundable,
    this.rating,
    this.barcode,
    this.digital,
    this.auctionProduct,
    this.fileName,
    this.filePath,
    this.externalLink,
    this.externalLinkBtn,
    this.wholesaleProduct,
    this.productCondition,
    this.vehicleProductCondition,
    this.isEmailSentToCustomers,
    this.thumbnailImgImported,
    this.isImported,
    this.createdAt,
    this.updatedAt,
    this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      addedBy: json['added_by'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      parentCategoryId: json['parent_category_id'],
      brandId: json['brand_id'],
      photos: json['photos'],
      thumbnailImg: json['thumbnail_img'],
      videoThumbnail: json['video_thumbnail'],
      productVideo: json['product_video'],
      videoProvider: json['video_provider'],
      videoLink: json['video_link'],
      tags: json['tags'],
      description: json['description'],
      note: json['note'],
      unitPrice: json['unit_price'],
      purchasePrice: json['purchase_price'],
      currency: json['currency'],
      variantProduct: json['variant_product'],
      attributes: json['attributes'],
      choiceOptions: json['choice_options'],
      colors: json['colors'],
      variations: json['variations'],
      todaysDeal: json['todays_deal'],
      published: json['published'],
      approved: json['approved'],
      stockVisibilityState: json['stock_visibility_state'],
      cashOnDelivery: json['cash_on_delivery'],
      isEscrow: json['is_escrow'],
      featured: json['featured'],
      sellerFeatured: json['seller_featured'],
      currentStock: json['current_stock'],
      unit: json['unit'],
      minQty: json['min_qty'],
      lowStockQuantity: json['low_stock_quantity'],
      discount: json['discount'],
      discountCurrency: json['discount_currency'],
      discountType: json['discount_type'],
      discountStartDate: json['discount_start_date'],
      discountEndDate: json['discount_end_date'],
      startingBid: json['starting_bid'],
      minimumPlaceBidAmount: json['minimum_place_bid_amount'],
      auctionStartDate: json['auction_start_date'],
      auctionEndDate: json['auction_end_date'],
      winningEmailSent: json['winning_email_sent'],
      auctionTimeExtension: json['auction_time_extension'],
      tax: json['tax'],
      taxType: json['tax_type'],
      shippingType: json['shipping_type'],
      shippingCost: json['shipping_cost'],
      isQuantityMultiplied: json['is_quantity_multiplied'],
      estShippingDays: json['est_shipping_days'],
      numOfSale: json['num_of_sale'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaImg: json['meta_img'],
      metaImgAlt: json['meta_img_alt'],
      pdf: json['pdf'],
      slug: json['slug'],
      refundable: json['refundable'],
      rating: json['rating'],
      barcode: json['barcode'],
      digital: json['digital'],
      auctionProduct: json['auction_product'],
      fileName: json['file_name'],
      filePath: json['file_path'],
      externalLink: json['external_link'],
      externalLinkBtn: json['external_link_btn'],
      wholesaleProduct: json['wholesale_product'],
      productCondition: json['product_condition'],
      vehicleProductCondition: json['vehicle_product_condition'],
      isEmailSentToCustomers: json['is_email_sent_to_customers'],
      thumbnailImgImported: json['thumbnail_img_imported'],
      isImported: json['is_imported'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      thumbnail: json['thumbnail'] != null ? Thumbnail.fromJson(json['thumbnail']) : null,
    );
  }
}

class Thumbnail {
  final int? id;
  final String? fileOriginalName;
  final String? fileName;
  final int? userId;
  final int? fileSize;
  final String? extension;
  final String? type;
  final dynamic externalLink;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Thumbnail({
    this.id,
    this.fileOriginalName,
    this.fileName,
    this.userId,
    this.fileSize,
    this.extension,
    this.type,
    this.externalLink,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      id: json['id'],
      fileOriginalName: json['file_original_name'],
      fileName: json['file_name'],
      userId: json['user_id'],
      fileSize: json['file_size'],
      extension: json['extension'],
      type: json['type'],
      externalLink: json['external_link'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }
}
