import 'package:http/http.dart' as http;
import 'package:moyen_express/resources/exports/index.dart';

import '../../../model/currency_model/currency_model.dart';

class CurrencyConversionController extends GetxController {
  final GetStorage _getStorage = GetStorage();
  RxString currentCurrency = "USD".obs;
  final Rx<CurrencyConversionModel> currencyConversionModel =
      CurrencyConversionModel().obs;
  RxBool haveCurrencyData = false.obs;
  RxDouble conversionRate = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    currentCurrency.value = _getStorage.read(Strings.CurrencyType) ?? "USD";
    getCurrencyConversionData();
  }

RxString convertCurrencyAmt({required String? amount, bool toUsd = false,}) {
  
  // it is getting null here
  RxString newAmount = '0'.obs;
  newAmount.value = amount ?? '0';

  if (haveCurrencyData.value && amount != null) {
    double amountValue;
    try {
      print('product amount pricte $amount');
      amountValue = double.parse(amount);
    } catch (e) {
      print('Error parsing amount: $amount');
      return newAmount;
    }

 
      // Call function to get conversion rate based on the provided currencyType
      
    

    if (toUsd) {
      // Convert from current currency to USD
      newAmount.value = (amountValue / (currencyConversionModel.value.conversionRate ?? 1.0)).toStringAsFixed(2);
    } else {
      // Convert from USD to current currency
      newAmount.value = (amountValue * (currencyConversionModel.value.conversionRate ?? 1.0)).toStringAsFixed(2);
    }
  }

  return newAmount;
}


RxString convertCurrencyAmtWithType({required String? amount, bool toUsd = false, required String? currencyType}) {
  getCurrencyConversionData(
    currencyType: currencyType
  );
  print('ab toh hojaaaaa::::::::::::::: ${currencyType}');
  // it is getting null here
  RxString newAmount = '0'.obs;
  newAmount.value = amount ?? '0';

  if (haveCurrencyData.value && amount != null) {
    double amountValue;
    try {
      print('product amount pricte $amount');
      amountValue = double.parse(amount);
    } catch (e) {
      print('Error parsing amount: $amount');
      return newAmount;
    }

 
      // Call function to get conversion rate based on the provided currencyType
      
    

    if (toUsd) {
      // Convert from current currency to USD
      newAmount.value = (amountValue / (currencyConversionModel.value.conversionRate ?? 1.0)).toStringAsFixed(2);
    } else {
      // Convert from USD to current currency
      newAmount.value = (amountValue * (currencyConversionModel.value.conversionRate ?? 1.0)).toStringAsFixed(2);
    }
  }

  return newAmount;
}


  changeCurrentCurrency(String newCurrency) {
    currentCurrency.value = newCurrency;
    _getStorage.write(Strings.CurrencyType, currentCurrency.value);
    getCurrencyConversionData();
    if (kDebugMode) {
      print("new currency :: $newCurrency");
    }
  }

  getCurrencyConversionData({String? currencyType}) async {
      haveCurrencyData.value =
          await getCurrencyConversionModel(
            to: currentCurrency.value,
            currencyType: currencyType ?? 'XOF');

  }

  Future<bool> getCurrencyConversionModel({required String to,  String? currencyType}) async {
    
    bool status = false;
    var url =
        "https://v6.exchangerate-api.com/v6/94b8866b69008bc78844e8d6/pair/${currencyType}/$to";

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);

        // CurrencyConversionModel currencyConversionModel =
        currencyConversionModel.value =
            CurrencyConversionModel.fromJson(result);
        conversionRate.value =
            currencyConversionModel.value.conversionRate ?? 1;
        update();

        if (kDebugMode) {
          print(
              "currencyConversionModel ${currencyConversionModel.toJson().toString()}");
          log.e('currencyConversionModel: success');
        }
        status = true;
      } else {
        if (kDebugMode) {
          print(
              "currencyConversionModel ${currencyConversionModel.toJson().toString()}");
           log.e('currencyConversionModel: fail');
        }
        status = false;
      }
    } catch (e) {
      status = false;
      if (kDebugMode) {
         log.e('currencyConversionModel: fail');

        print(e);
      }
    }

    return status;
  }
}