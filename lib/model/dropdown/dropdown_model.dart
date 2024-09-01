class DropdownModel {
  int? id;
  String? value;

  DropdownModel({this.id, this.value});

  static List<DropdownModel> listFromJson(List jsonList) {
    return jsonList.map((e) => DropdownModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<DropdownModel> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'value': value,
    };
  }

  factory DropdownModel.fromJson(Map<String, dynamic> json) {
    return DropdownModel(
      id: json['id'] as int?,
      value: json['value'] as String?,
    );
  }
}
