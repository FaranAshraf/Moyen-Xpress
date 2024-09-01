class CountryState {
  int? id;
  String? name;
  String? image;

  CountryState({
    this.id,
    this.name,
    this.image,
  });

  factory CountryState.fromJson(Map<String, dynamic> json) {
    return CountryState(
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
  List<CountryState>? successContents;

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
          ?.map((e) => CountryState.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
