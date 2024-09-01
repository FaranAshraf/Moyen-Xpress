import '../../resources/exports/index.dart';

class Session {
  String? tokenID;
  User? user;

  Session({
    this.tokenID,
    this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'tokenID': tokenID,
      'userDetails': user?.toJson(),
    };
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      tokenID: json['tokenID'] as String?,
      user: json['userDetails'] != null
          ? User.fromJson(json['userDetails'])
          : null,
    );
  }

  Session copyWith({
    String? tokenID,
    User? user,
  }) {
    return Session(
      tokenID: tokenID ?? this.tokenID,
      user: user ?? this.user,
    );
  }
}
