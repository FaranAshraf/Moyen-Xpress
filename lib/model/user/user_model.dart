class User {
  int? userID;
  int? defaultLocationId;
  String? emailAddress;
  String? name;
  String? lastName;
  String? address;
  String? city;
  String? country;
  String? state;
  String? zipCode;
  String? photo;
  String? phoneNo;
  String? token;
  String? preferredLanguage;

  User({
    this.userID,
    this.emailAddress,
    this.phoneNo,
    this.name,
    this.lastName,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.photo,
    this.token,
    this.preferredLanguage,
    this.defaultLocationId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'emailAddress': emailAddress,
      'phoneNo': phoneNo,
      'name': name,
      'lastName': lastName,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'photo': photo,
      'access_token': token,
      'preferredLanguage': preferredLanguage,
      'defaultLocation': defaultLocationId,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'] as int?,
      emailAddress: json['emailAddress'] as String?,
      phoneNo: json['phoneNo'] as String?,
      name: json['name'] as String?,
      lastName: json['lastName'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      zipCode: json['zipCode'] as String?,
      photo: json['photo'] as String?,
      token: json['access_token'] as String?,
      preferredLanguage: json['preferredLanguage'] as String?,
      defaultLocationId: json['defaultLocationId'] as int?,
    );
  }

  String get fullName => '${name ?? ''} ${lastName ?? ''}';

  User copyWith({
    int? userID,
    int? defaultLocationId,
    String? emailAddress,
    String? phoneNo,
    String? name,
    String? lastName,
    String? address,
    String? city,
    String? state,
    String? country,
    String? zipCode,
    String? photo,
    String? token,
    String? preferredLanguage,
  }) {
    return User(
      userID: userID ?? this.userID,
      defaultLocationId: defaultLocationId ?? this.defaultLocationId,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNo: phoneNo ?? this.phoneNo,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      photo: photo ?? this.photo,
      token: token ?? this.token,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    );
  }
}
