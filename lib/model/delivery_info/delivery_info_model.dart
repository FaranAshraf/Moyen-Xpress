class DeliveryResponse {
  final bool? isSuccess;
  final String? message;
  final String? failReason;
  final dynamic failReasonContent;
  final List<SuccessContentInfo>? successContents;

  DeliveryResponse({
    this.isSuccess,
    this.message,
    this.failReason,
    this.failReasonContent,
    this.successContents,
  });

  factory DeliveryResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryResponse(
      isSuccess: json['isSuccess'],
      message: json['message'],
      failReason: json['failReason'],
      failReasonContent: json['failReasonContent'],
      successContents: json['successContents'] != null
          ? (json['successContents'] as List)
              .map((e) => SuccessContentInfo.fromJson(e))
              .toList()
          : null,
    );
  }
}

class SuccessContentInfo {
  final int? sellerId;
  final String? seller;
  final ShipWithMoyen? shipWithMoyen;
  final List<dynamic>? expressDelivery;
  final List<dynamic>? freePickups;

  SuccessContentInfo(  {
    
    this.sellerId,
    this.seller,
    this.shipWithMoyen,
    this.expressDelivery,
    this.freePickups,
  });

  factory SuccessContentInfo.fromJson(Map<String, dynamic> json) {
    return SuccessContentInfo(
      sellerId: json['seller_id'],
      seller: json['seller'],
      shipWithMoyen: json['ship_with_moyen'] != null
          ? ShipWithMoyen.fromJson(json['ship_with_moyen'])
          : null,
      expressDelivery: json['express_delivery'],
      freePickups: json['free_pickups'],
    );
  }
}

class ShipWithMoyen {
  final int? id;
  final double? deliveryCharges;
  final String? currency;
  final int? deliveryDays;

  ShipWithMoyen({
    this.id,
    this.deliveryCharges,
    this.currency,
    this.deliveryDays,
  });

  factory ShipWithMoyen.fromJson(Map<String, dynamic> json) {
    return ShipWithMoyen(
      id: json['id'],
      deliveryCharges: json['delivery_charges'],
      currency: json['currency'],
      deliveryDays: json['delivery_days'],
    );
  }
}
