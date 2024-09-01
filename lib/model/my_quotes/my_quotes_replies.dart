import '../../resources/exports/index.dart';

class QuoteReply {
  int? id;
  String? sellerName;
  num? perUnitPrice;
  String? currency;
  num? totalQuotePrice;
  num? tax;
  num? deliveryCharges;
  String? deliveryDays;
  String? status;
  int? isPaid;
  Options? options;

  QuoteReply({
    this.id,
    this.sellerName,
    this.perUnitPrice,
    this.currency,
    this.totalQuotePrice,
    this.tax,
    this.deliveryCharges,
    this.deliveryDays,
    this.status,
    this.isPaid,
    this.options,
  });

  factory QuoteReply.fromJson(Map<String, dynamic> json) {
    return QuoteReply(
      id: json['id'],
      sellerName: json['seller_name'],
      perUnitPrice: json['per_unit_price'],
      currency: json['currency'],
      totalQuotePrice: json['total_quote_price'],
      tax: json['tax'],
      deliveryCharges: json['delivery_charges'],
      deliveryDays: json['delivery_days'],
      status: json['status'],
      isPaid: json['is_paid'],
      options:
          json['options'] != null ? Options.fromJson(json['options']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seller_name': sellerName,
      'per_unit_price': perUnitPrice,
      'currency': currency,
      'total_quote_price': totalQuotePrice,
      'tax': tax,
      'delivery_charges': deliveryCharges,
      'delivery_days': deliveryDays,
      'status': status,
      'is_paid': isPaid,
      'options': options?.toJson(),
    };
  }
}

class Options {
  bool? accept;
  bool? reject;

  Options({this.accept, this.reject});

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      accept: json['accept'],
      reject: json['reject'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accept': accept,
      'reject': reject,
    };
  }
}

class QuoteRepliesModel {
  List<QuoteReply>? quoteReplies;

  QuoteRepliesModel({this.quoteReplies});

  factory QuoteRepliesModel.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print("Parsing JSON: $json");
    }
    if (json.containsKey('quote_replies')) {
      var quoteRepliesJson = json['quote_replies'] as List<dynamic>?;
      var quoteReplies = quoteRepliesJson?.map((item) => QuoteReply.fromJson(item)).toList();
      return QuoteRepliesModel(quoteReplies: quoteReplies);
    } else if (json.containsKey('successContents')) {
      var successContents = json['successContents'] as Map<String, dynamic>;
      var quoteRepliesJson = successContents['quote_replies'] as List<dynamic>?;
      var quoteReplies = quoteRepliesJson?.map((item) => QuoteReply.fromJson(item)).toList();
      return QuoteRepliesModel(quoteReplies: quoteReplies);
    } else {
      return QuoteRepliesModel();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'quote_replies': quoteReplies?.map((i) => i.toJson()).toList(),
    };
  }
}



