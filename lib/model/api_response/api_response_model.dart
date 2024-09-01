class ApiResponse {
  bool? isSuccess;
  dynamic failReason;
  String? failReasonContent;
  String? message;
  dynamic successContents;
  num? combinedOrderId;
  num? orderId;
  double? rates; // Added field for rates

  ApiResponse({
    this.isSuccess,
    this.failReason,
    this.failReasonContent,
    this.message,
    this.successContents,
    this.combinedOrderId,
    this.orderId,
    this.rates, // Added parameter for rates
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      isSuccess: json['isSuccess'],
      failReason: json['failReason'],
      message: json['message'],
      failReasonContent: json['failReasonContent'],
      successContents: (json['successContents']),
      combinedOrderId: (json['combined_order_id']),
      orderId: json['order_id'],
      rates: json['rates'] != null
          ? double.parse(json['rates'].toString())
          : null, // Parsing rates field
    );
  }
}
