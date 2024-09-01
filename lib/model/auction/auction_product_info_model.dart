class AuctionProductInfoModel {
  int? id;
  String? brand;
  double? highestBid;
  String? productCondition;
  String? vehicleCondition;

  AuctionProductInfoModel({
    this.id,
    this.brand,
    this.highestBid,
    this.productCondition,
    this.vehicleCondition,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'brand': brand,
      'highestBid': highestBid,
      'productCondition': productCondition,
      'vehicleCondition': vehicleCondition,
    };
  }

  factory AuctionProductInfoModel.fromJson(Map<String, dynamic> json) {
    return AuctionProductInfoModel(
      id: json['id'] as int?,
      brand: json['brand'] as String?,
      highestBid: json['highestBid'] as double?,
      productCondition: json['productCondition'] as String?,
      vehicleCondition: json['vehicleCondition'] as String?,
    );
  }
}
