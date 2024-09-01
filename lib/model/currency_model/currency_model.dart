// To parse this JSON data, do
//
//     final currencyConversionModel = currencyConversionModelFromJson(jsonString);

import 'dart:convert';

CurrencyConversionModel currencyConversionModelFromJson(String str) => CurrencyConversionModel.fromJson(json.decode(str));

String currencyConversionModelToJson(CurrencyConversionModel data) => json.encode(data.toJson());

class CurrencyConversionModel {
  CurrencyConversionModel({
    this.result,
    this.documentation,
    this.termsOfUse,
    this.timeLastUpdateUnix,
    this.timeLastUpdateUtc,
    this.timeNextUpdateUnix,
    this.timeNextUpdateUtc,
    this.baseCode,
    this.targetCode,
    this.conversionRate,
    this.conversionResult,
  });

  String? result;
  String? documentation;
  String? termsOfUse;
  int? timeLastUpdateUnix;
  String? timeLastUpdateUtc;
  int? timeNextUpdateUnix;
  String? timeNextUpdateUtc;
  String? baseCode;
  String? targetCode;
  double? conversionRate;
  double? conversionResult;

  factory CurrencyConversionModel.fromJson(Map<String, dynamic> json) => CurrencyConversionModel(
    result: json["result"],
    documentation: json["documentation"],
    termsOfUse: json["terms_of_use"],
    timeLastUpdateUnix: json["time_last_update_unix"],
    timeLastUpdateUtc: json["time_last_update_utc"],
    timeNextUpdateUnix: json["time_next_update_unix"],
    timeNextUpdateUtc: json["time_next_update_utc"],
    baseCode: json["base_code"],
    targetCode: json["target_code"],
    conversionRate: json["conversion_rate"]?.toDouble(),
    conversionResult: json["conversion_result"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "documentation": documentation,
    "terms_of_use": termsOfUse,
    "time_last_update_unix": timeLastUpdateUnix,
    "time_last_update_utc": timeLastUpdateUtc,
    "time_next_update_unix": timeNextUpdateUnix,
    "time_next_update_utc": timeNextUpdateUtc,
    "base_code": baseCode,
    "target_code": targetCode,
    "conversion_rate": conversionRate,
    "conversion_result": conversionResult,
  };
}
