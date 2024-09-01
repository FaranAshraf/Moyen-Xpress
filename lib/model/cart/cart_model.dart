enum DeliveryType {
  expressDelivery(id: 0, title: "Express Delivery"),
  shipWithMoyen(id: 1, title: "Ship With Moyen");

  final int id;
  final String title;

  const DeliveryType({required this.id, required this.title});

  static String getTitle(int? id) {
    DeliveryType data = DeliveryType.values.firstWhere(
      (element) => element.id == id,
      orElse: () => DeliveryType.expressDelivery,
    );

    return data.title;
  }

  static int getId(int? id) {
    DeliveryType data = DeliveryType.values.firstWhere(
      (element) => element.id == id,
      orElse: () => DeliveryType.expressDelivery,
    );

    return data.id;
  }
}

class CartModel {
  int? id;
  String? shopName;
  bool? isSelected;
  int? selectedDeliveryType;
  List<CartDataModel>? items;
  List<DeliveryDataModel>? deliveryType;

  CartModel({
    this.id,
    this.shopName,
    this.isSelected = false,
    this.selectedDeliveryType = -1,
    this.items,
    this.deliveryType,
  });

  static List<CartModel> listFromJson(List jsonList) {
    return jsonList.map((e) => CartModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<CartModel> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'shopName': shopName,
      'isSelected': isSelected,
      'selectedDeliveryType': selectedDeliveryType,
      'items': CartDataModel.listToJson(items ?? []),
      'deliveryType': DeliveryDataModel.listToJson(deliveryType ?? []),
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as int?,
      shopName: json['shopName'] as String?,
      isSelected: json['isSelected'] ?? CartModel().isSelected,
      selectedDeliveryType:
          json['selectedDeliveryType'] ?? CartModel().selectedDeliveryType,
      items: CartDataModel.listFromJson(json['items'] ?? []),
      deliveryType: DeliveryDataModel.listFromJson(json['deliveryType'] ?? []),
    );
  }

  CartModel copyWith({
    int? id,
    String? shopName,
    bool? isSelected,
    int? selectedDeliveryType,
    List<CartDataModel>? items,
    List<DeliveryDataModel>? deliveryType,
  }) {
    return CartModel(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      isSelected: isSelected ?? this.isSelected,
      selectedDeliveryType: selectedDeliveryType ?? this.selectedDeliveryType,
      items: items ?? this.items,
      deliveryType: deliveryType ?? this.deliveryType,
    );
  }
}

class DeliveryDataModel {
  int? id;
  int? estimatedDeliveryDays;
  double? deliveryCharges;

  DeliveryDataModel({
    this.id,
    this.estimatedDeliveryDays,
    this.deliveryCharges,
  });

  static List<DeliveryDataModel> listFromJson(List jsonList) {
    return jsonList.map((e) => DeliveryDataModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(
      List<DeliveryDataModel> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'estimatedDeliveryDays': estimatedDeliveryDays,
      'deliveryCharges': deliveryCharges,
    };
  }

  factory DeliveryDataModel.fromJson(Map<String, dynamic> json) {
    return DeliveryDataModel(
      id: json['id'] as int?,
      estimatedDeliveryDays: json['estimatedDeliveryDays'] as int?,
      deliveryCharges: json['deliveryCharges'] as double?,
    );
  }
}

class CartDataModel {
  int? id;
  int? qty;
  String? imageUrl;
  String? title;
  double? price;
  double? discount;
  double? tax;

  CartDataModel({
    this.id,
    this.qty,
    this.imageUrl,
    this.title,
    this.price,
    this.discount,
    this.tax,
  });

  static List<CartDataModel> listFromJson(List jsonList) {
    return jsonList.map((e) => CartDataModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<CartDataModel> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'qty': qty,
      'imageUrl': imageUrl,
      'title': title,
      'price': price,
      'discount': discount,
      'tax': tax,
    };
  }

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json['id'] as int?,
      qty: json['qty'] as int?,
      imageUrl: json['imageUrl'] as String?,
      title: json['title'] as String?,
      price: json['price'] as double?,
      discount: json['discount'] as double?,
      tax: json['tax'] as double?,
    );
  }

  CartDataModel copyWith({
    int? id,
    int? qty,
    String? imageUrl,
    String? title,
    double? price,
    double? discount,
    double? tax,
  }) {
    return CartDataModel(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
    );
  }
}
