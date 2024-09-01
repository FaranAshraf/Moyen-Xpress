class Cities {
  int? id;
  String? name;
  String? image;

  Cities({
    this.id,
    this.name,
    this.image,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );
  }
}

class ApiResponse {
  bool? isSuccess;
  String? failReason;
  dynamic failReasonContent;
  List<Cities>? successContents;

  ApiResponse({
    this.isSuccess,
    this.failReason,
    this.failReasonContent,
    this.successContents,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      isSuccess: json['isSuccess'] as bool?,
      failReason: json['failReason'] as String?,
      failReasonContent: json['failReasonContent'],
      successContents: (json['successContents'] as List<dynamic>?)
          ?.map((e) => Cities.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
