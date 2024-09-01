class LocationsModel {
  int? defaultLocation;
  List<LocationsDataModel>? locations;

  LocationsModel({this.defaultLocation, this.locations});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'defaultLocation': defaultLocation,
      'locations': LocationsDataModel.listToJson(locations ?? []),
    };
  }

  factory LocationsModel.fromJson(Map<String, dynamic> json) {
    return LocationsModel(
      defaultLocation: json['defaultLocation'] as int?,
      locations: LocationsDataModel.listFromJson(json['locations'] ?? []),
    );
  }

  LocationsModel copyWith({
    int? defaultLocation,
    List<LocationsDataModel>? locations,
  }) {
    return LocationsModel(
      defaultLocation: defaultLocation ?? this.defaultLocation,
      locations: locations ?? this.locations,
    );
  }
}

class LocationsDataModel {
  int? id;
  String? countryName;
  String? cityName;
  String? stateName;
  int? postalCode;
  int? phoneNo;
  String? completeAddress;

  LocationsDataModel({
    this.id,
    this.countryName,
    this.cityName,
    this.stateName,
    this.postalCode,
    this.phoneNo,
    this.completeAddress,
  });

  static List<LocationsDataModel> listFromJson(List jsonList) {
    return jsonList.map((e) => LocationsDataModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(
      List<LocationsDataModel> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'countryName': countryName,
      'cityName': cityName,
      'stateName': stateName,
      'postalCode': postalCode,
      'phoneNo': phoneNo,
      'completeAddress': completeAddress,
    };
  }

  factory LocationsDataModel.fromJson(Map<String, dynamic> json) {
    return LocationsDataModel(
      id: json['id'] as int?,
      countryName: json['countryName'] as String?,
      cityName: json['cityName'] as String?,
      stateName: json['stateName'] as String?,
      postalCode: json['postalCode'] as int?,
      phoneNo: json['phoneNo'] as int?,
      completeAddress: json['completeAddress'] as String?,
    );
  }

  LocationsDataModel copyWith({
    int? id,
    String? countryName,
    String? cityName,
    String? stateName,
    int? postalCode,
    int? phoneNo,
    String? completeAddress,
  }) {
    return LocationsDataModel(
      id: id ?? this.id,
      countryName: countryName ?? this.countryName,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      postalCode: postalCode ?? this.postalCode,
      phoneNo: phoneNo ?? this.phoneNo,
      completeAddress: completeAddress ?? this.completeAddress,
    );
  }
}

class AddressModel {
  List<AddressData>? successContents;
  AddressModel({
    this.successContents,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      successContents: json['successContents'] != null
          ? (json['successContents'] as List)
              .map((data) => AddressData.fromJson(data))
              .toList()
          : null,
    );
  }
}

class AddressData {
  int? id;
  int? userId;
  String? address;
  String? postalCode;
  String? phone;
  int? setDefault;
  DateTime? createdAt;
  DateTime? updatedAt;
  CountryModel? country;
  StateModel? state;
  CityModel? city;
  UserModel? user;

  AddressData({
    this.id,
    this.userId,
    this.address,
    this.postalCode,
    this.phone,
    this.setDefault,
    this.createdAt,
    this.updatedAt,
    this.country,
    this.state,
    this.city,
    this.user,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      id: json['id'],
      userId: json['user_id'],
      address: json['address'],
      postalCode: json['postal_code'],
      phone: json['phone'],
      setDefault: json['set_default'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      country: json['country'] != null
          ? CountryModel.fromJson(json['country'])
          : null,
      state: json['state'] != null ? StateModel.fromJson(json['state']) : null,
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

class CountryModel {
  int? id;
  String? name;

  CountryModel({this.id, this.name});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class StateModel {
  int? id;
  String? name;

  StateModel({this.id, this.name});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CityModel {
  int? id;
  String? name;

  CityModel({this.id, this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class UserModel {
  int? id;
  String? userType;
  String? name;
  String? email;

  UserModel({
    this.id,
    this.userType,
    this.name,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userType: json['user_type'],
      name: json['name'],
      email: json['email'],
    );
  }
}
