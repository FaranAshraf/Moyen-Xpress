class ServiceResponse {
  bool isSuccess;
  String? failReason;
  dynamic failReasonContent;
  List<Service> successContents;

  ServiceResponse({
    required this.isSuccess,
    this.failReason,
    this.failReasonContent,
    required this.successContents,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      isSuccess: json['isSuccess'],
      failReason: json['failReason'],
      failReasonContent: json['failReasonContent'],
      successContents: List<Service>.from(
          json['successContents'].map((x) => Service.fromJson(x))),
    );
  }
}

class Service {
  int id;
  String serviceName;


  Service({
    required this.id,
    required this.serviceName,
   
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceName: json['service_name'],
     
    );
  }
}
