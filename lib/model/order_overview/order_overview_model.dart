class OrderOverViewModel {
  int? id;
  double? totalAmount;
  int? noOfItems;
  DateTime? deliveryDate;

  OrderOverViewModel({
    this.id,
    this.totalAmount,
    this.noOfItems,
    this.deliveryDate,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'totalAmount': totalAmount,
      'noOfItems': noOfItems,
      'deliveryDate': deliveryDate?.millisecondsSinceEpoch,
    };
  }

  factory OrderOverViewModel.fromJson(Map<String, dynamic> json) {
    return OrderOverViewModel(
      id: json['id'] as int?,
      totalAmount: json['totalAmount'] as double?,
      noOfItems: json['noOfItems'] as int?,
      deliveryDate: DateTime.tryParse(json['deliveryDate']),
    );
  }
}
