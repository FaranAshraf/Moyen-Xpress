class CashBackResponse {
  List<CashBackModel>? successContents;

  CashBackResponse({this.successContents});

  factory CashBackResponse.fromJson(Map<String, dynamic> json) {
    var list = json['successContents'] as List<dynamic>?;
    // ignore: prefer_null_aware_operators
    List<CashBackModel>? successContents = list != null
        ? list.map((item) => CashBackModel.fromJson(item)).toList()
        : null;

    return CashBackResponse(
      successContents: successContents,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'successContents': successContents?.map((item) => item.toJson()).toList(),
    };
  }
}


class CashBackModel {
  String? date;
  String? orderCode;
  String? productName;
  String? cashbackAmount;

  CashBackModel({
    this.date,
    this.orderCode,
    this.productName,
    this.cashbackAmount,
  });
  static List<CashBackModel> listFromJson(List? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((e) => CashBackModel.fromJson(e)).toList();
  }

  factory CashBackModel.fromJson(Map<String, dynamic> json) {
    return CashBackModel(
      date: json['Date'] as String?,
      orderCode: json['Order Code'] as String?,
      productName: json['Product Name'] as String?,
      cashbackAmount: json['Cashback Amount'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Date': date,
      'Order Code': orderCode,
      'Product Name': productName,
      'Cashback Amount': cashbackAmount,
    };
  }
}
