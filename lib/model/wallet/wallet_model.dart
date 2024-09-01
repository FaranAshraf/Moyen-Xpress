class WalletModel {
  num? walletBalance;
  String? currency;
  List<WalletHistory>? walletHistory;
  Pagination? pagination;

  WalletModel({
    this.walletBalance,
    this.currency,
    this.walletHistory,
    this.pagination,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    var walletHistoryList = (json['wallet_history'] as List)
        .map((i) => WalletHistory.fromJson(i))
        .toList();
    
    return WalletModel(
      walletBalance: json['wallet_balance'],
      currency: json['currency'],
      walletHistory: walletHistoryList,
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wallet_balance': walletBalance,
      'currency': currency,
      'wallet_history': walletHistory?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class WalletHistory {
  num? id;
  String? date;
  num? amount;
  String? currency; // Added currency field
  String? transactionType; // Renamed to match JSON

  WalletHistory({
    this.id,
    this.date,
    this.amount,
    this.currency, // Added currency field
    this.transactionType,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) {
    return WalletHistory(
      id: json['id'],
      date: json['date'],
      amount: json['amount'],
      currency: json['currency'], // Added currency field
      transactionType: json['transaction_type'], // Renamed to match JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'currency': currency, // Added currency field
      'transaction_type': transactionType, // Renamed to match JSON
    };
  }
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      count: json['count'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      totalPages: json['total_pages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'count': count,
      'per_page': perPage,
      'current_page': currentPage,
      'total_pages': totalPages,
    };
  }
}
