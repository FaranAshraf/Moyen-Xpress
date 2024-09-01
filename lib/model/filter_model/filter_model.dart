class CarBrand {
  int? id;
  String? name;
  
  CarBrand({
     this.id,
     this.name,
 
  });

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      id: json['id'] as int?,
      name: json['name'] as String?,

    );
  }
}


class ColorsBrand {
  int? id;
  String? name;
  String? code;
  
  ColorsBrand({
     this.id,
     this.name,
     this.code,
 
  });

  factory ColorsBrand.fromJson(Map<String, dynamic> json) {
    return ColorsBrand(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,

    );
  }
}