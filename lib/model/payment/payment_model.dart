

class PaymentSuccess {
  num? balance;
  String? formattedBalance;
  CashPayments? cashPayments;
  MobilePayments? mobilePayments;
  WireTransfer? wireTransfer;

  PaymentSuccess({
    this.balance,
    this.formattedBalance,
    this.cashPayments,
    this.mobilePayments,
    this.wireTransfer,
  });

  factory PaymentSuccess.fromJson(Map<String, dynamic> json) {
    return PaymentSuccess(
      balance: json['balance'],
      formattedBalance: json['formatted_balance'],
      cashPayments: json.containsKey('Cash Payments')
          ? CashPayments.fromJson(json['Cash Payments'])
          : null,
      mobilePayments: json.containsKey('Mobile Payments')
          ? MobilePayments.fromJson(json['Mobile Payments'])
          : null,
      wireTransfer: json.containsKey('Wire Transfer')
          ? WireTransfer.fromJson(json['Wire Transfer'])
          : null,
    );
  }
}

class CashPayments {
  String? country;
  String? business;
  String? address;

  CashPayments({
    this.country,
    this.business,
    this.address,
  });

  factory CashPayments.fromJson(Map<String, dynamic> json) {
    return CashPayments(
      country: json['country'],
      business: json['business'],
      address: json['address'],
    );
  }
}

class MobilePayments {
  String? country;
  String? business;
  String? address;
  String? mobileCompany;
  String? mobileNumber;

  MobilePayments({
    this.country,
    this.business,
    this.address,
    this.mobileCompany,
    this.mobileNumber,
  });

  factory MobilePayments.fromJson(Map<String, dynamic> json) {
    return MobilePayments(
      country: json['country'],
      business: json['business'],
      address: json['address'],
      mobileCompany: json['mobile_company'],
      mobileNumber: json['mobile_number'],
    );
  }
}

class WireTransfer {
  String? bankAccountNumber;
  String? bankRoutingNumber;
  String? swiftCode;
  String? beneficiary;
  String? bankName;
  String? address;

  WireTransfer({
    this.bankAccountNumber,
    this.bankRoutingNumber,
    this.swiftCode,
    this.beneficiary,
    this.bankName,
    this.address,
  });

  factory WireTransfer.fromJson(Map<String, dynamic> json) {
    return WireTransfer(
      bankAccountNumber: json['bank_account_number'],
      bankRoutingNumber: json['bank_routing_number'],
      swiftCode: json['swift_code'],
      beneficiary: json['beneficiary'],
      bankName: json['bank_name'],
      address: json['address'],
    );
  }
}
