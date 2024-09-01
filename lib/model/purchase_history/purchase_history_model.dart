class OrderHistory {
  final int? id;
  final String deliveryStatus;
  final num? grandTotal;
  final String? code;
  final DateTime? createdAt;

  OrderHistory({
    this.id,
    required this.deliveryStatus,
    required this.grandTotal,
    required this.code,
    required this.createdAt,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    DateTime? createdAt = DateTime.tryParse(json['created_at']);
    return OrderHistory(
      id: json['id'],
      deliveryStatus: json['delivery_status'],
      grandTotal: json['grand_total'] ?? 0.00,
      code: json['code'],
      createdAt: createdAt,
    );
  }
}
