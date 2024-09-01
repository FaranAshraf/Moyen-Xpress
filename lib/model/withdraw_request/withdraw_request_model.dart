class WalletSuccessContents {
  String? walletBalance;
  List<WithdrawRequest>? withdrawRequests;

  WalletSuccessContents({
    this.walletBalance,
    this.withdrawRequests,
  });

  factory WalletSuccessContents.fromJson(Map<String, dynamic> json) {
    var withdrawRequestsList = json['withdraw_requests'] as List;
    List<WithdrawRequest> withdrawRequests =
        withdrawRequestsList.map((e) => WithdrawRequest.fromJson(e)).toList();

    return WalletSuccessContents(
      walletBalance: json['wallet_balance'],
      withdrawRequests: withdrawRequests,
    );
  }
}

class WithdrawRequest {
  int? id;
  String? date;
  String? amount;
  String? withdrawType;
  String? status;
  String? message;
  String? screenshotUrl;

  WithdrawRequest({
    this.id,
    this.date,
    this.amount,
    this.withdrawType,
    this.status,
    this.message,
    this.screenshotUrl,
  });

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) {
    return WithdrawRequest(
      id: json['id'],
      date: json['date'],
      amount: json['amount'],
      withdrawType: json['withdraw_type'],
      status: json['status'],
      message: json['message'],
      screenshotUrl: json['screenshot_url'],
    );
  }
}
