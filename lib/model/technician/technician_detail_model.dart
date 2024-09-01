class ResponseModel {
  bool isSuccess;
  String message;
  dynamic failReason;
  dynamic failReasonContent;
  TechnicianDetail? successContents;

  ResponseModel({
    required this.isSuccess,
    required this.message,
    required this.failReason,
    required this.failReasonContent,
    required this.successContents,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      isSuccess: json['isSuccess'],
      message: json['message'],
      failReason: json['failReason'],
      failReasonContent: json['failReasonContent'],
      successContents: TechnicianDetail.fromJson(json['successContents']),
    );
  }
}

// Model class for the "successContents" part of the JSON response
class TechnicianDetail {
  int? id;
  String? serviceName;
  String? thumbnailImage;
  String? description;
  num? price;
  num? rating;
  num? tax;
  String? companyName;
  TechnicianDetail(
      {required this.id,
      required this.serviceName,
      required this.thumbnailImage,
      this.description,
      this.price,
      this.rating,
      this.tax,
      this.companyName
      });

  factory TechnicianDetail.fromJson(Map<String, dynamic> json) {
    return TechnicianDetail(
      id: json['id'],
      serviceName: json['service_name'],
      thumbnailImage: json['thumbnail_image'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      tax: json['tax'],
      companyName: json['company_name'],
    );
  }
}
